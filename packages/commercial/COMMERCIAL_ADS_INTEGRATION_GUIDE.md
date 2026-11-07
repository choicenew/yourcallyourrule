# 📖 Pyro 商业化广告系统 — 接入与 UI 消费指导手册
> **(Commercial Ads Integration & Usage Guide)**
> 
> **手册定位**：本文档为应用开发者的**接入与 UI 消费操作指南**。指导如何在任何 Pyro 宿主 App（如 `pyro_magma` / `aura_wallpaper`）或微包中进行快速配置、生产 ID 集中注入、测试隔离验证，以及 6 大 UI 门户组件的零思考使用。

---

## ⚡ 一、 3 分钟极速接入流程

在任意新的 App 项目中接入广告，只需完成以下 **3 步**：

### 步骤 1：主 App 集中注入全平台生产广告位 ID (`AdsConfig`)
主 App 创建 `AppAdsConfig` 继承 `AdsConfig`，集中管理全平台 AdUnit IDs：

```dart
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

class AppAdsConfig extends AdsConfig {
  const AppAdsConfig({
    super.admobAppId,
    super.admobBannerId,
    super.admobInterstitialId,
    super.admobRewardedId,
    super.admobNativeId,
    super.liftoffAppId,
    super.liftoffBannerId,
  });

  static const AppAdsConfig production = AppAdsConfig(
    admobAppId: 'ca-app-pub-7500321599129263~3347511713',
    admobBannerId: 'ca-app-pub-7500321599129263/7861430370',
    admobInterstitialId: 'ca-app-pub-7500321599129263/1982417737',
    admobRewardedId: 'ca-app-pub-7500321599129263/5224354917',
    admobNativeId: 'ca-app-pub-7500321599129263/2757981774',
    liftoffAppId: '6adcc13158e014823b7cea39',
    liftoffBannerId: 'BANNER_ADS-1234567',
  );
}
```

### 步骤 2：启动注册与策略绑定 (`main.dart`)
在主 App 的 `main()` 入口或冷启动初始化逻辑中调用注入与挂载：

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 集中灌入全平台生产广告位 ID
  AdsHub.instance.setProductionConfig(AppAdsConfig.production);

  // 2. (可选) 绑定云端 Remote Config 监听热重载与策略函数委托
  AdPolicyManager.instance.attachRemoteConfig(RemoteConfigService.instance.auraRemoteConfig);

  // 3. 婚礼挂载商业连接器
  CommercialAdConnectors.ensureAdConnectorsMounted();

  runApp(const MyApp());
}
```

### 步骤 3：UI 零传参无感消费
在任何页面直接调用 UI 门户，UI 控件自动从 `AdsConfig` 提取对应平台的真实广告位 ID：

```dart
// 高层自适应内嵌 Banner (自动从 AdsConfig 提取 ID)
const AdsInlineBanner(tier: AdTrafficTier.tier1, height: 60.0)

// 原生卡片广告
const AdsNative(tier: AdTrafficTier.tier1, style: NativeStyle.medium)
```

---

## 🧪 二、 官方测试 ID 隔离测试 SOP (`AdsConfig.test()`)

为防止开发与 QA 阶段误用真实 AdUnit ID 导致 AdMob 账号因“Invalid Traffic / 自查自点”被封禁，系统在 `AdsConfig.test()` 中预置了标准的官方测试 ID。

### 测试模式环境注入：
```dart
if (kDebugMode) {
  // Debug 调试模式下自动注入测试配置，100% 秒充，0 封号风险
  AdsHub.instance.setProductionConfig(const AdsConfig.test());
} else {
  // 正式打包发布使用线上后台真实的 AppAdsConfig.production
  AdsHub.instance.setProductionConfig(AppAdsConfig.production);
}
```

---

## 🎨 三、 6 大 UI 门户组件消费指南

`pyro_ads_hub` 导出并提供了以下 6 大全格式高层组件：

### 1. 内嵌 Banner 组件 (`AdsInlineBanner`)
自带**骨架屏占位卡片 (Skeleton Loader)**，彻底消除 0 高度塌陷界面跳变：

```dart
const AdsInlineBanner(
  tier: AdTrafficTier.tier1, // 查表选择 Tier 梯队
  height: 80.0,              // 设定固定骨架高度
)
```

### 2. 原生广告组件 (`AdsNative`)
自适应美化卡片，适应 Dark/Light 主题，完全不遮挡原生“Ad”标：

```dart
const AdsNative(
  tier: AdTrafficTier.tier1,
  style: NativeStyle.medium, // small, medium, large 模板
)
```

### 3. 插屏广告 Helper (`AdsInterstitial`)
```dart
// 1. 预加载插屏广告
await AdsInterstitial.load(AdTrafficTier.tier1);

// 2. 交互节点触发展示
await AdsInterstitial.show(AdTrafficTier.tier1);
```

### 4. 激励视频 Helper (`AdsRewarded`)
```dart
await AdsRewarded.show(
  AdTrafficTier.tier1,
  onUserEarnedReward: (rewardItem) {
    debugPrint('用户获得奖励: ${rewardItem.amount} ${rewardItem.type}');
  },
);
```

### 5. 开屏广告 Helper (`AdsAppOpen`)
```dart
await AdsAppOpen.show(
  AdTrafficTier.tier1,
);
```

---

## 📄 四、 许可证 (License)

MIT License - Pyro Magma Workspace
