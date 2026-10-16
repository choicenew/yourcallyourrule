#  Flutter AdMob 广告模块（Ads）高收益与高性能重构指南

> **文档目的**：本 README 总结了在 Flutter 中集成 Google AdMob 广告时，关于 **“提升有效展示率 (Show Rate)”**、**“最大化广告收益 (eCPM)”**、**“消除页面滑动延迟”** 以及 **“解决 UI 布局塌陷”** 的完整经验与最佳工程实践。
> 
> **用途**：可直接复制本文档内容提供给其他 AI（如 ChatGPT、Claude、DeepSeek 等）或团队开发者，作为 Flutter 广告模块重构与优化的标准参考。

---

## 一、 核心设计理念

1. **利益最大化 (Maximize Impression Revenue)**：
   * 广告收益公式为 `收益 = (展示数 / 1000) × eCPM`。
   * 广告 **“被请求”** 或 **“被匹配”** 并不产生收益，只有 **“真实被用户看到 (Impression)”** 才会产生收益。
   * **核心法则**：绝不盲目塞大量广告，但凡在一个位置放了广告，就必须保证该广告 **“0 延迟秒出”**、**“布局不弹跳”**、**“滑回来不销毁”**，将有效展示率（Show Rate）拉到 90%+。

2. **流畅体验 (Zero-Jank & Zero-Lag)**：
   * 严禁广告在加载过程中破坏 UI 布局稳定性；
   * 严禁滑动列表时反复销毁和重新拉取广告；
   * 严禁无网/拦截环境下在主线程死循环重试导致 ANR。

---

## 二、 四大核心痛点与底层原理剖析

### 1. 痛点一：0 高度塌陷（Layout Shift）导致广告滑过去后才出现
* **现象**：用户在列表或页面中滑动，划过广告位时什么也没看到；几秒后网络请求返回，广告突然变高（如 250px），把页面剧烈推开。但此时用户早就划走了。
* **原因**：广告 Widget 在加载中（`isLoaded == false`）时直接返回了 `const SizedBox.shrink()`（高度为 0），导致广告位在布局中“不存在”。
* **经验解决方案**：
  * **预留固定空间（Skeleton Placeholder）**：在广告加载过程中，提前预留固定规格的高度（如横幅 60px、原生广告 200px），并渲染极简优雅的 `AD` 标识与微 Loading。
  * 用户滑到该位置时，空间已被锁死，广告加载成功瞬间无缝渲染，**有效展示率拉满**；若彻底失败，再静默折叠为 0。

---

### 2. 痛点二：列表滑动销毁循环（Dispose on Scroll）
* **现象**：列表上下滑动时，滑上去广告没了，划下来又要重新等 3~5 秒网络请求；用户感觉“滑了百八十遍都没广告”。
* **原因**：Flutter 的 `ListView` 或 `CustomScrollView` 默认会将划出屏幕外（Off-screen）的 Widget 进行 `dispose()` 销毁。再次划入时触发 `initState()` 重新建立网络连接拉广告。
* **经验解决方案**：
  * **内存保活 (`AutomaticKeepAliveClientMixin`)**：所有广告 Widget 必须混入 `AutomaticKeepAliveClientMixin` 并将 `wantKeepAlive` 设为 `true`。
  * 广告一旦加载成功，整个页面生命周期内**在内存中持续保活**，用户上下滑动多少次，划回来都是 **0 毫秒秒级呈现**。

---

### 3. 痛点三：同页面多个广告位引发 `AdUnit` 挂载冲突
* **现象**：同一页面放置多个广告位时，控制台报错 `Ad already attached to widget tree`，后面的广告位永远空白。
* **原因**：AdMob 原生 SDK 不允许同一个广告对象实例（`BannerAd` / `NativeAd`）同时挂载到 Widget 树的多个节点上。
* **经验解决方案**：
  * **独立作用域隔离 (`_scopedAdInfo`)**：在 Widget 的 `initState` 中克隆 `AdInfo`，生成唯一的 Provider Key，让 Riverpod/状态管理为每个卡片生成完全独立的广告对象，彻底隔离冲突。

---

### 4. 痛点四：死循环重试风暴与 ANR 卡死
* **现象**：在无 JS 引擎、断网或开启广告拦截 (AdBlock) 的环境下，控制台无限刷屏报错，应用弹出 “App isn't responding”。
* **原因**：广告加载失败回调（`onAdFailedToLoad`）中误将状态重置为了未开始状态，触发 UI 重构，重新调用 `loadAd()`，形成每秒数十次的死循环请求。
* **经验解决方案**：
  * **锁定失败状态 (`isFailed = true`)**：失败后保持 `isStarted = true` 并标记 `isFailed = true`，周期内绝对不自动发起二次重试；
  * **全局熔断机制 (Circuit Breaker)**：捕获到环境硬拦截（code 0 或缺乏 JS 引擎）时，直接触发全局 `adStateProvider` 禁用，全 App 秒切无广告模式，不消耗任何主线程算力。

---

## 三、 代码结构与组件规范

目录 `lib/ads/` 的核心架构说明：

```text
lib/ads/
├── ad_manager.dart              # 全局 AdUnit ID 统一配置中心
├── ad_state.dart                # 全局广告开关 (StateNotifier)
├── ad_control_service.dart      # 广告逻辑控制服务 (关联会员VIP购买状态)
├── ad_cache_provider.dart       # 基于 Riverpod 的独立广告缓存中心
├── google_ad.dart               # 多类型底层 Google 广告封装组件 (带保活与骨架屏)
├── adwidgets/
│   ├── inline_adaptive_ad.dart  # 行内自适应 Banner 广告组件 (生产级防塌陷首选)
│   ├── anchored_adaptive_ad.dart# 底部固定的锚定 Banner 广告组件
│   ├── app_open_ad.dart         # 开屏广告管理器 (带超时熔断与放行机制)
│   └── native_ads.dart          # 原生高级广告构建函数
└── README.md                    # 本文档
```

---

## 四、 标准使用范例

### 1. 列表/页面中推荐使用的自适应 Banner：

```dart
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';

// 直接在 Column 或 ListView 内部插入，无需手动外加 Height 包裹
const InlineAdaptiveBannerAdWidget(
  adInfo: AdManager.adaptiveBannerAd,
  height: 60, // 可选：指定占位高度，防止加载期间布局塌陷
)
```

### 2. 原生/通用广告 Widget：

```dart
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

const GoogleAdWidget(
  adInfo: AdManager.bannerAd,
  height: 60,
)
```

---

## 五、 AI 助手参考提示词（Prompt Template）

你可以直接复制以下框内文本，粘贴给其他 AI 助手：

```text
在 Flutter 项目中处理 AdMob 广告模块时，请严格遵守以下工业级高收益与防卡顿法则：

1. [防止高度塌陷] 广告在加载过程中（isLoaded == false 且 !isFailed）绝对不能返回 SizedBox.shrink()。必须使用预留固定高度的骨架屏/占位 Container（例如 height: 60 或 height: 200），防止布局在广告加载成功后剧烈弹跳或因用户滑走而丢失展示量（Impression）。
2. [滑动保活] 所有列表中的广告 Widget 必须混入 AutomaticKeepAliveClientMixin 并开启 wantKeepAlive = true。确保用户上下滑动列表时，已加载的广告保存在内存中，滑回来能 0 毫秒秒出，严禁销毁重新拉取。
3. [单例隔离] 确保同一页面中的多个广告组件使用独立的 Provider/State 作用域实例，防止 AdMob SDK 抛出 "Ad already attached to widget tree" 错误。
4. [禁止无脑重试] 广告加载失败（onAdFailedToLoad）后必须标记 isFailed = true 且不能将请求状态重置为未开始，严禁在回调中递归调用 load()，防止触发死循环请求导致主线程 ANR 卡死。
```
