# 广告模块（Ads）卡顿与 ANR 深度技术分析及全局熔断方案

本文档详细记录了在开发与真机/模拟器测试过程中，广告模块导致应用启动卡顿、热重载未响应（ANR）以及反复无限请求的核心物理原因与对应解决方案，供后续重构或交接查阅。

---

## 一、核心痛点与现象

1. **应用启动/热重载频繁弹出 “App isn't responding” (ANR)**；
2. **控制台疯狂刷屏 `Ad failed to load: LoadAdError(code: 0, message: Unable to obtain a JavascriptEngine.)`**；
3. **Android 系统日志连续报告 `Choreographer: Skipped 33~62 frames! The application may be doing too much work on its main thread.`**；
4. **即使用户本地拦截了广告（或处于无广告环境），应用仍在主线程持续发起跨进程请求，严重拖垮性能**。

---

## 二、四大底层根本原因剖析

### 1. 缓存状态重置引发的“死循环重试风暴”（最关键代码 Bug）
* **定位文件**：`lib/ads/ad_cache_provider.dart`
* **原错误逻辑**：
  ```dart
  onAdFailedToLoad: (ad, error) {
    ad.dispose();
    state = const AdCacheState(); // 🔴 致命 Bug：将 isStarted 重置为了 false！
  }
  ```
* **破坏链条**：
  1. 某个卡片广告加载失败；
  2. 缓存状态被重置为初始状态（`isStarted: false`）；
  3. 页面中的 Widget（`InlineAdaptiveBannerAdWidget`）监听到状态变更触发重新构建（Rebuild）；
  4. Widget 发现 `isStarted == false`，误以为“这个广告还未请求过”，立即再次触发 `loadAd()`；
  5. 再次请求 ➡️ 再次失败 ➡️ 再次重置 ➡️ 再次触发，**形成每秒数十次的无限死循环请求，直接压死主线程！**

### 2. Google Mobile Ads SDK 的原生 Binder IPC 阻塞
* **定位日志**：`W/ServiceBindIntentUtils: Dynamic lookup for intent failed for action: com.google.android.gms.ads.service.START`
* **底层原理**：
  * Google 广告 SDK 在底层不是纯 Dart 代码，而是通过 Android Binder 机制与 Google Play 服务进行跨进程通讯；
  * 当运行在无 JS 引擎的模拟器或被网络拦截（AdBlock）的环境中时，SDK 会在 Android 主线程上进行同步 Binder 查找重试，造成主线程严重丢帧（600ms~1000ms 冻结）。

### 3. 开屏广告（AppOpenAd）的递归预加载与导航卡死
* **定位文件**：`lib/ads/adwidgets/app_open_ad.dart`
* **原错误逻辑**：
  * 在 `onAdDismissed` 和 `onAdFailedToShow` 中无脑直接调用 `loadAd()` 递归预加载；
  * 在 `_isShowingAd == true` 时直接 `return`，没有触发 `_safelyInvokeDismissCallback()`，导致 Splash 启动页等待超时。

### 4. 未加载广告时的硬性空白占位（UI 塌陷/占位浪费）
* **定位文件**：`lib/ads/adwidgets/native_ads.dart`
* **原错误逻辑**：
  * 使用 `ConstrainedBox(minHeight: 320)` 强行锁定高度，即使广告加载失败，界面依然留下一大块 320 高度的空白灰色色块。

---

## 三、已实施的完整优化与全局熔断机制

### 1. 斩断死循环链条（`ad_cache_provider.dart`）
```dart
onAdFailedToLoad: (ad, error) {
  ad.dispose();
  debugPrint('Ad failed to load: $error');
  // 保持 isStarted = true，彻底锁定状态，生命周期内绝不发起二次重复请求！
  state = state.copyWith(
    bannerAd: null,
    isStarted: true,
    isLoaded: false,
  );
}
```

### 2. 全局广告智能熔断机制（Global Circuit Breaker）
* **核心理念**：**“检测不到广告或环境不支持，直接全面停止，绝不浪费算力”**。
* 当任意广告组件捕获到环境不支持（`Unable to obtain a JavascriptEngine`）或网络硬拦截（`code: 0`）时，立即通知全局 `AdState`：
  ```dart
  if (error.message.contains('JavascriptEngine') || error.code == 0) {
    ref.read(adStateProvider.notifier).disableAds();
  }
  ```
* **熔断收益**：
  * 一旦熔断触发，全 App 的 `adState` 变为 `false`；
  * 全局所有广告组件立即自动折叠为 `const SizedBox.shrink()`（0 尺寸、0 通信、0 渲染）；
  * 整个应用后续绝不再发出任何广告请求，完美保障拦截用户的极速流畅体验。

### 3. 开屏广告硬超时与安全放行
* 在 `AppOpenAdManager.loadAd()` 增加 2 秒硬超时熔断（`.timeout(Duration(milliseconds: 2000))`）；
* 无论广告成功、失败还是超时，均无条件放行主页面导航。

### 4. 广告失败零占位（SizedBox.shrink）
* 移除了 `ConstrainedBox` 硬性 320 高度限制；
* 广告失败时界面组件高度瞬间归零，UI 自然上提，不留任何空白坑位。

---

## 四、后续替换/重构建议

1. **若切换其他广告 SDK**（如穿山甲、Unity Ads 等）：
   * 务必保留 **“单次尝试 + 失败熔断”** 机制；
   * 严禁在 `onFailed` 回调中直接调用自身 `load()` 方法；
2. **测试建议**：
   * 在模拟器无 Google Play 环境下测试：验证熔断机制是否生效（应只打印一次失败后彻底静默）；
   * 在真实网络弱网/断网环境下测试：验证页面是否能秒级渲染且不卡顿。
