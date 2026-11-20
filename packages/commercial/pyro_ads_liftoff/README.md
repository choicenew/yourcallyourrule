# 📦 pyro_ads_liftoff (Liftoff / Vungle Ads Driver)

> **定位**：Pyro Commercial 商业变现矩阵中针对 **Liftoff (Vungle) Ads (`hx_liftoff_ads`)** 的**纯底层哑驱动微包 (Dumb Driver)**。

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
                 3. pyro_ads_liftoff (本微包)
            (纯哑驱动：实现 NetworkAdapter 抽象契约)
                            │
                            ▼
                  4. pyro_ads_protocol
                 (纯抽象契约与数据模型)
```

---

## ⚙️ 二、 App ID 与 广告位 (Placement ID) 配置指南

### 1. 官网默认 App ID
Liftoff 平台给出的应用标识符 App ID 为：
```text
6adcc13158e014823b7cea39
```
在未传入自定义配置时，本微包内置以此 24 位 App ID（`6adcc13158e014823b7cea39`）作为初始化默认值。

### 2. 配置文件配置方式 (`pyro_commercial_config.yaml`)
主 App 项目根目录下的 `pyro_commercial_config.yaml` 中，按如下结构配置驱动打包开关、App ID 及各格式 Placement ID：

```yaml
ads_drivers:
  liftoff: true      # 启用 Liftoff (Vungle) 广告驱动

liftoff:
  app_id: "6adcc13158e014823b7cea39"    # 官网 App ID
  placements:
    banner: "BANNER_ADS-1234567"         # Banner 横幅广告位 ID
    mrec: "MREC_ADS-1234567"             # MREC 矩形广告位 ID
    native: "NATIVE_ADS-1234567"         # Native 原生广告位 ID
    interstitial: "INTERSTITIAL_ADS-1234567" # 插屏广告位 ID
    rewarded: "REWARDED_ADS-1234567"     # 激励视频广告位 ID
    app_open: "APP_OPEN_ADS-1234567"     # 开屏/应用打开广告位 ID
```

### 3. 代码动态传参初始化
在调用 `AdsHub.instance.initializeRegisteredAdapters(config)` 或 `LiftoffAdapter().initialize(config)` 时传入参数 Map：

```dart
await AdsHub.instance.initializeRegisteredAdapters({
  'appId': '6adcc13158e014823b7cea39', // 或 'liftoffAppId'
  'liftoffPlacements': {
    'banner': 'BANNER_ADS-1234567',
    'native': 'NATIVE_ADS-1234567',
    'interstitial': 'INTERSTITIAL_ADS-1234567',
    'rewarded': 'REWARDED_ADS-1234567',
    'appOpen': 'APP_OPEN_ADS-1234567',
  },
});
```

---

## 📱 三、 原生平台配置要求与 Dashboard 关键注意事项

### 1. Liftoff Dashboard 关键配置铁律（⚠️ 极其重要）
- **必须关闭 In-App Bidding**：在 Liftoff 后台为每个 Placement 创建广告位时，**务必关闭 (OFF) "In-App Bidding" 开关**（使用传统 Waterfall 瀑布流模式）。开启竞价模式会导致客户端抛出错误码 **`224`**。

### 2. Android 平台配置
- **`minSdkVersion`**：必须设为 **24** 或更高 (Android 7.0+)。
- **网络权限**：底层微包自动补充 `INTERNET` 与 `ACCESS_NETWORK_STATE` 权限。

### 3. iOS 平台配置 (`ios/Runner/Info.plist`)
- **iOS 版本**：iOS 13.0+ (`Podfile` 中配置 `platform :ios, '13.0'`)。
- **SKAdNetwork**：需将 Liftoff / Vungle 的 `SKAdNetworkItems` 添加入 `Info.plist`。
- **ATT 隐私授权**：如使用 App Tracking Transparency 框架，需声明 `NSUserTrackingUsageDescription`。

### 4. Windows 平台配置
- 支持 Windows 10 (build 16299+) 64 位平台，目标系统需安装 Microsoft Edge WebView2 Runtime。

---

## 🚀 四、 注册挂载与快速使用

### 1. 注册挂载至 `AdsHub` 中枢

```dart
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_ads_liftoff/pyro_ads_liftoff.dart';

void registerLiftoffDriver() {
  // 注册为 Tier 3 或 Tier 4 广告驱动
  AdsHub.instance.registerDriver(
    level: 3,
    adapter: LiftoffAdapter(),
  );
}
```

### 2. 通过 `pyro_ads_hub` 高层 API 消费

```dart
import 'package:pyro_ads_hub/pyro_ads_hub.dart';

// 1. 横幅 Banner
const AdsInlineBanner(tier: AdTrafficTier.tier3, height: 60.0);

// 2. 原生卡片 Native
const AdsNative(tier: AdTrafficTier.tier3, style: NativeStyle.medium);

// 3. 插屏广告缓冲与展示
await AdsInterstitial.load(AdTrafficTier.tier3);
await AdsInterstitial.show(AdTrafficTier.tier3);

// 4. 激励视频播放
await AdsRewarded.show(
  AdTrafficTier.tier3,
  onUserEarnedReward: (reward) {
    print('获得 Liftoff 奖励: ${reward.type} x ${reward.amount}');
  },
);
```

---

## 🧪 五、 支持的广告类型 (Supported Ad Formats)

| 广告类型 | 契约接口 | 功能说明 |
|---|---|---|
| **Banner 横幅** | `buildBanner(placementId)` | 响应式 320x50 Banner 控件 |
| **Native 原生** | `buildNative(placementId, style)` | 支持 Small / Medium 原生模板卡片 |
| **Interstitial 插屏** | `loadInterstitial()` / `showInterstitial()` | 全屏插屏广告，支持 Hub 缓冲预载 |
| **Rewarded 激励视频** | `loadRewarded()` / `showRewarded()` | 激励视频，触发 `MagmaRewardItem` 转化 |
| **App Open 开屏** | `loadAppOpen()` / `showAppOpen()` | 冷启动/应用唤醒全屏开屏广告 |

---

## 📄 六、 许可证 (License)

MIT License - Pyro Magma Workspace
