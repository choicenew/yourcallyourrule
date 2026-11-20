# 📦 pyro_ads_admob (Google Mobile Ads Driver)

> **定位**：Pyro Commercial 商业变现矩阵中针对 **Google Mobile Ads (AdMob)** 的**纯底层哑驱动微包 (Dumb Driver)**。

---

## 🏛️ 一、 架构规范与单向解耦设计 (Protocol - Hub - Driver)

本包遵循 Pyro Commercial 商业化架构标准（`commercial_architecture_protocol`）：

```text
┌────────────────────────────────────────────────────────┐
│             1. pyro_commercial_hub / 宿主 App           │
│           (商业变现中台：挂载驱动与内购特权无缝闭环)        │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
                    2. pyro_ads_hub
                (中央注册中心与瀑布流调度中枢)
                            │
                            ▼
                 3. pyro_ads_admob (本微包)
            (纯哑驱动：实现 NetworkAdapter 抽象契约)
                            │
                            ▼
                  4. pyro_ads_protocol
                 (纯抽象契约与数据模型)
```

### 核心铁律：
- **纯哑驱动 (Dumb Driver)**：本包不依赖 `pyro_ads_hub`，也不包含任何全局状态判断（如“是否开启广告”、“是否是 VIP 免广告”）。
- **零越权**：所有缓冲/预加载指令与展示调度均由中央中枢 `pyro_ads_hub` 发出，驱动仅负责响应并调用 Google Mobile Ads 原生 SDK 执行。

---

## 🚀 二、 注册挂载与快速使用

### 1. 注册挂载至 `AdsHub` 中枢

在应用启动时（如 `CommercialAdConnectors` 或 `main.dart`），将 AdMob 适配器挂载注册至全局 `AdsHub.instance`：

```dart
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_ads_admob/pyro_ads_admob.dart';

void registerAdmobDriver() {
  // 注册为 Tier 1 (第一梯队) 广告驱动
  AdsHub.instance.registerDriver(
    level: 1,
    adapter: PyroAdsAdmobAdapter(),
  );
}
```

### 2. 通过 `pyro_ads_hub` 统一调度使用

注册完成后，业务层只需直接使用 `pyro_ads_hub` 的高层 Widget 与静态 Helper，无缝享受瀑布流回退：

```dart
import 'package:pyro_ads_hub/pyro_ads_hub.dart';

// 横幅广告 (Banner)
const AdsInlineBanner(height: 60.0)

// 原生卡片广告 (Native)
const AdsNative(style: NativeStyle.medium)

// 插屏广告缓冲与展示
await AdsInterstitial.load(AdTrafficTier.tier1);
await AdsInterstitial.show(AdTrafficTier.tier1);

// 激励视频播放
await AdsRewarded.show(
  AdTrafficTier.tier1,
  onUserEarnedReward: (reward) {
    print('获得奖励: ${reward.type} x ${reward.amount}');
  },
);
```

---

## 🛠️ 三、 支持的广告类型 (Supported Ad Types)

| 广告类型 | 契约接口 | 功能说明 |
|---|---|---|
| **Banner 横幅** | `buildBanner(placementId)` | 响应式自适应横幅，自动适配屏幕宽度 |
| **Native 原生** | `buildNative(placementId, style)` | 支持 Small / Medium / Large 模板原生广告卡片 |
| **Interstitial 插屏** | `loadInterstitial()` / `showInterstitial()` | 全屏插屏广告，支持 Hub 提前缓冲秒出 |
| **Rewarded 激励视频** | `loadRewarded()` / `showRewarded()` | 激励视频，触发 `MagmaRewardItem` 回调 |
| **App Open 开屏** | `loadAppOpen()` / `showAppOpen()` | 应用冷启动/热唤醒开屏广告 |

---

## 🧪 四、 测试配置 (Test Ad Units)

本包已内置 Google 官方标准的测试 AdUnit ID，可通过 `getTest*Id()` 提取使用：

```dart
final adapter = PyroAdsAdmobAdapter();

print(adapter.getTestBannerId());       // ca-app-pub-3940256099942544/6300978111
print(adapter.getTestNativeId());       // ca-app-pub-3940256099942544/2247696110
print(adapter.getTestInterstitialId()); // ca-app-pub-3940256099942544/1033173712
print(adapter.getTestRewardedId());     // ca-app-pub-3940256099942544/5224354917
```

---

## 📄 五、 许可证 (License)

MIT License - Pyro Magma Workspace
