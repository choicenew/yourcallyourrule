# 📦 pyro_ads_hub (Commercial Ads Service Locator & UI Portals)

> **定位**：Pyro Commercial 商业变现矩阵中的**广告驱动注册中心、瀑布流降级仲裁中枢与 6 大高层 UI 门户组件包**。

---

## 🏛️ 一、 架构规范与责任边界

本包作为广告体系的服务定位器（Service Locator）与 UI 门户：
- **`AdsHub` 单例**：维护底层驱动注册表（`_drivers`）、层级映射（`_driversByLevel`）、梯队供应商映射（`_tierProviderMap`）以及主 App 注入的生产配置大本营 `AdsConfig`。
- **`WaterfallStrategyArbitrator` 仲裁器**：负责按 Tier 1 (AdMob) ➔ Tier 2 (AppLovin) ➔ Tier 3 (Unity) ➔ Tier 4 (Start.io) ➔ Tier 5 (House Ads) 自动降级解析可用驱动。
- **高层 UI 门户组件**：提供 `AdsBanner`、`AdsInlineBanner`、`AdsNative` 以及 `AdsInterstitial`、`AdsRewarded`、`AdsAppOpen` 静态 Helper。

---

## 🚀 二、 极速使用 SOP

### 1. 生产 AdUnit ID 集中注入
在主 App 初始化阶段（如 `main.dart`）：

```dart
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

void initAdsHub() {
  // 集中灌入主 App 真实的 AdsConfig 生产广告位 ID
  AdsHub.instance.setProductionConfig(AppAdsConfig.production);
}
```

### 2. UI 门户解耦消费
在界面中调用 UI 门户组件或 Helper：

```dart
// 1. 内嵌 Banner (带有骨架屏防高度塌陷)
const AdsInlineBanner(tier: AdTrafficTier.tier1, height: 60.0)

// 2. 原生广告卡片
const AdsNative(tier: AdTrafficTier.tier1, style: NativeStyle.medium)

// 3. 插屏广告预载与展示
await AdsInterstitial.load(AdTrafficTier.tier1);
await AdsInterstitial.show(AdTrafficTier.tier1);

// 4. 激励视频播放
await AdsRewarded.show(
  AdTrafficTier.tier1,
  onUserEarnedReward: (reward) => print('获得奖励: ${reward.amount}'),
);
```

---

## 📄 三、 许可证 (License)

MIT License - Pyro Magma Workspace
