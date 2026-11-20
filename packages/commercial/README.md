# Pyro Commercial Monetization & Ads Architecture Guide (商业化与广告矩阵架构指南)

本文档是 `packages/commercial/` 目录下商业化变现与广告矩阵体系的系统性架构导览与接入 SOP。

---

## 1. 核心架构与领域拓扑

本商业化体系遵循 **Protocol - Policy - Hub - Driver** 严格单向解耦与领域隔离范式，实现内购、广告与自家矩阵的彻底物理解耦：

```text
                       【顶层】 pyro_commercial_hub 
                   (总商业中台：装配门面与特权到期兑换纽带)
                                   │
         ┌─────────────────────────┼─────────────────────────┐
         ▼                         ▼                         ▼
【内购支柱】 pyro_purchase_core   【策略大脑】 pyro_ads_policy    【广告支柱】 pyro_ads_hub 
    (IAP 支付与特权状态)        (本地/云端Tier策略管理)         (AdsHub & 瀑布流调度)
         │                         │                         │
         ▼                         ▼                         ▼
【内购契约】 pyro_purchase_protocol                【广告契约】 pyro_ads_protocol 
     (纯数据模型与接口)                                (AdsConfig & AdTrafficTier)
                                                             ▲
                                                             │ 纯单向依赖
                                           ┌─────────────────┴─────────────────┐
                                           ▼                                   ▼
                                 pyro_ads_<driver>                   pyro_house_ads
                              (AdMob / AppLovin等驱动)             (自家矩阵/VIP促销组件)
```

---

## 2. 商业化微包结构与职责划分

| 微包名称 | 职责与定位 | 依赖红线 |
| :--- | :--- | :--- |
| **`pyro_ads_protocol`** | 广告契约包（定义 `NetworkAdapter`, `AdsConfig` 配置大本营, `AdTrafficTier`, `AdSlotType`, `MagmaRewardItem`） | 仅允许依赖 `flutter` SDK，物理上 0 重型三方 SDK |
| **`pyro_ads_policy`** | 商业策略控制微包（管理本地 `AdPolicySpec` 与云端 `AuraRemoteConfig` 动态 JSON 下发热更新） | 仅依赖 `pyro_ads_protocol`, `pyro_ads_hub` 与 `pyro_config_remote`，**物理上 0 跨域依赖** |
| **`pyro_ads_hub`** | 广告注册中心、Waterfall 瀑布流调度中枢与 6 大高层广告 UI 门户组件 | 依赖 `pyro_ads_protocol` |
| **`pyro_ads_admob`** | 纯底层 Google Mobile Ads (AdMob) 纯哑驱动微包 | 仅依赖 `pyro_ads_protocol` 与 `google_mobile_ads` |
| **`pyro_ads_applovin`** | 纯底层 AppLovin MAX 驱动微包 | 仅依赖 `pyro_ads_protocol` 与 `applovin_max` |
| **`pyro_ads_unity`** | 纯底层 Unity LevelPlay 驱动微包 | 仅依赖 `pyro_ads_protocol` 与 `unity_levelplay_mediation` |
| **`pyro_ads_startapp`** | 纯底层 Start.io 驱动微包 | 仅依赖 `pyro_ads_protocol` 与 `startapp_sdk` |
| **`pyro_ads_liftoff`** | 纯底层 Liftoff (Vungle) 驱动微包 | 仅依赖 `pyro_ads_protocol` 与 `hx_liftoff_ads` |
| **`pyro_house_ads`** | 自家矩阵广告包（提供 `MatrixAppItem` 矩阵描述、自包名分流与自适应卡片） | 仅依赖 `flutter` SDK，**物理上 0 广告 SDK** |
| **`pyro_app_launch_guard`** | 启动门禁微包（管理冷启动 Splash ➔ Onboarding ➔ 开屏广告 2s 硬超时管线） | 仅依赖 `pyro_ads_protocol` 与 `pyro_ads_hub` |
| **`pyro_purchase_protocol`** | 内购与商品契约包（定义 `ProductItem`, `CommercialUIConfig`） | 仅允许依赖 `flutter` SDK |
| **`pyro_purchase_core`** | 原生 In-App Purchase 支付流、订阅验证与特权状态本地写盘 | 依赖 `pyro_purchase_protocol` |
| **`pyro_purchase_ui`** | 纯哑 UI 组件包（付费墙 Paywall、订阅弹窗 `CommercialPrivilegeSheet` 与商品卡片） | 仅依赖 `pyro_purchase_protocol` |
| **`pyro_commercial_hub`** | 商业变现装配中台（`CommercialAdConnectors` 装配挂载 + 激励视频看广告换 VIP 特权写盘） | 装配中台，聚合管理“看广告换 VIP”等闭环策略 |

---

## 3. 全平台生产环境广告 ID 注入 SOP (`AdsConfig`)

主 App（如 `aura_wallpaper` / `pyro_magma`）在写 UI 界面时 **100% 无需在代码里硬编码传递具体的广告位 ID**！

### 步骤 1：主 App 创建 `AppAdsConfig` 继承 `AdsConfig`
在主 App 的项目代码中定义 `app_ads_config.dart`：

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
    super.liftoffInterstitialId,
  });

  /// 生产环境真实 ID 配置
  static const AppAdsConfig production = AppAdsConfig(
    admobAppId: 'ca-app-pub-7500321599129263~3347511713',
    admobBannerId: 'ca-app-pub-7500321599129263/7861430370',
    admobInterstitialId: 'ca-app-pub-7500321599129263/1982417737',
    admobRewardedId: 'ca-app-pub-7500321599129263/5224354917',
    admobNativeId: 'ca-app-pub-7500321599129263/2757981774',
    liftoffAppId: '6adcc13158e014823b7cea39',
    liftoffBannerId: 'BANNER_ADS-1234567',
    liftoffInterstitialId: 'INTERSTITIAL_ADS-1234567',
  );
}
```

### 步骤 2：启动时注入 `AdsHub`
在 `main()` 或 `bootstrap.dart` 初始化时：

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 一次性集中注入生产广告位 ID 大本营
  AdsHub.instance.setProductionConfig(AppAdsConfig.production);

  // 2. 装配挂载商业连接器
  CommercialAdConnectors.ensureAdConnectorsMounted();

  runApp(const MyApp());
}
```

### 步骤 3：高层 UI 零传参无感消费
在页面中调用：
```dart
// UI 自动去 AdsConfig 提取当前平台的生产广告位 ID，未配置时自动降级测试 ID！
const AdsInlineBanner(tier: AdTrafficTier.tier1, height: 60.0)
const AdsNative(tier: AdTrafficTier.tier1, style: NativeStyle.medium)
```

---

## 4. 配置文件存放与格式指南 (`pyro_commercial_config.yaml`)

### 配置文件定位
`pyro_commercial_config.yaml` **只作为编译期打包与构建开关**，用于控制打包工具链（`prepare_build.dart`）决定将哪些底层广告 SDK 编译打入安装包。

```yaml
app_package_name: "com.pyro.wallpaper"

# 1. 广告驱动打包开关 (配置为 true 才会拉取 SDK 并打入 APP)
ads_drivers:
  admob: true        # 启用 AdMob ➔ 编译期打包 pyro_ads_admob
  applovin: true     # 启用 AppLovin ➔ 编译期打包 pyro_ads_applovin
  liftoff: true      # 启用 Liftoff ➔ 编译期打包 pyro_ads_liftoff
  unity: false       # 禁用 Unity ➔ 编译期彻底剔除，0 原生 SDK 占用!
  startio: false     # 禁用 Start.io ➔ 编译期彻底剔除，0 原生 SDK 占用!
  house_ads: true    # 启用自家矩阵 ➔ 编译期打包 pyro_house_ads

# 2. 静态默认 Waterfall 梯队映射
tier_mapping:
  tier1: "admob"
  tier2: "applovin"
  tier3: "liftoff"
  tier5: "house_ads"
```

---

## 5. 策略控制与云端热重载 SOP (`pyro_ads_policy`)

主 App 可通过 `AdPolicyManager` 进行离在线动态策略调控：

```dart
// 1. 绑定双云 AuraRemoteConfig (Cloudflare + Firebase) 热重载流
AdPolicyManager.instance.attachRemoteConfig(RemoteConfigService.instance.auraRemoteConfig);

// 2. 传入主 App 动态评估函数委托 (0 跨域包依赖)
AdPolicyManager.instance.setCustomTierResolver(() {
  return myAppRiskService.currentEvaluatedAdTier;
});
```

---

## 📄 6. 许可证 (License)

MIT License - Pyro Magma Workspace
