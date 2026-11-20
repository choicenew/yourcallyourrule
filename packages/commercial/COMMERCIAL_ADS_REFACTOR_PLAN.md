# 📖 Commercial 商业化广告系统断层修复与策略中枢重构计划
> **(Commercial Ads Architecture Refactor & Policy Engine Plan)**
>
> 文件位置: `packages/commercial/COMMERCIAL_ADS_REFACTOR_PLAN.md`

本文档旨在彻底解决 `packages/commercial/` 商业化体系中存在的**广告 ID 集中注入机制缺失**、**`CommercialHub` 越俎代庖硬编码 Tier**、以及**动态 Tier 策略控制中心悬空**的三大核心逻辑断层，并对 `pyro_ads_admob` 驱动微包按照原版 `pyro_ads_magma/lib/src/networks/admob_adapter.dart` 的极简纯哑驱动规范进行彻底重构。

---

## 🏛️ 一、 重构核心哲学与职责边界

1. **`pyro_commercial_config.yaml`** ➔ 纯粹作为**编译期打包与构建开关 (Build-Time Packaging Config)**，仅管理 `ads_drivers` 打包开关与静态默认 Tier 映射。
2. **`AdsConfig` 集中配置大本营** ➔ 归属于 `pyro_ads_protocol`，作为强类型数据模型集中管理全平台生产 AdUnit / Placement IDs，由主 App 启动时一次性灌入。
3. **`pyro_ads_policy` 策略微包 [NEW]** ➔ 继承并演进 `pyro_ads_magma` 原版的 Tier 1~5 路由分发逻辑，融合本地控制规则与云端 `AuraRemoteConfig` 动态 JSON 下发热更新。
4. **`pyro_commercial_hub` 装配中台** ➔ 纠正硬编码 `initialTier` 的越权行为，聚焦于**装配门面 (`CommercialAdConnectors`) + 看广告兑换 VIP 特权**的跨域纽带职责。
5. **`pyro_ads_admob` 驱动重构 (1:1 复刻 `pyro_ads_magma/admob_adapter.dart`)** ➔ 彻底剔除 `AdManager`、`AdConfig`、`AppOpenAdManager` 以及 Riverpod 的 `adCacheProvider`。保持 `PyroAdsAdmobAdapter` 为 100% 纯哑巴驱动，仅保留内部 `_AdMobBanner` 与 `_AdMobNative` 控件及 Android 原生 XML 布局工厂注册。

---

## 🛠️ 二、 拟变更组件与文件清单 (Proposed Changes)

### 1. 契约层与配置大本营 (`pyro_ads_protocol`)

#### [NEW] `packages/commercial/pyro_ads_protocol/lib/src/models/ads_config.dart`
- 定义全平台（AdMob, AppLovin, Liftoff, Unity, Start.io, House Ads）生产环境 App ID 与各格式（Banner, MREC, Interstitial, Rewarded, Native, AppOpen）广告位 ID 集中配置契约基类 `AdsConfig`。
- 提供通用多态查表提取方法 `getPlacementId(String providerId, AdSlotType slotType)`。
- 主 App 可继承此类（如 `AppAdsConfig`）提供 `production` 与 `test` 实例。

#### [MODIFY] `packages/commercial/pyro_ads_protocol/lib/pyro_ads_protocol.dart`
- 导出 `ads_config.dart`。

---

### 2. 调度中枢与 ID 查表对接 (`pyro_ads_hub`)

#### [MODIFY] `packages/commercial/pyro_ads_hub/lib/src/ads_hub.dart`
- 在 `AdsHub` 单例中添加 `AdsConfig? _adsConfig` 成员与 `void setProductionConfig(AdsConfig config)` 注入方法。
- 添加 `String? getPlacementId(String providerId, AdSlotType slotType)` 查表方法。

#### [MODIFY] `packages/commercial/pyro_ads_hub/lib/src/widgets/ads_inline_banner.dart` & `ads_native.dart`
- 更新 ID 提取逻辑：`final id = placementId ?? AdsHub.instance.getPlacementId(adapter.providerId, slotType) ?? adapter.getTestBannerId() ?? 'default_placement';`
- 实现 UI 侧零硬编码、零传参，自动吃 `AdsConfig` 生产配置！

#### [MODIFY] `packages/commercial/pyro_ads_hub/lib/src/helpers/ads_interstitial.dart` & `ads_rewarded.dart` & `ads_app_open.dart`
- 同步更新 3 大 Helper 的 ID 自动提取与降级链路。

---

### 3. 新建独立商业策略微包 (`pyro_ads_policy`) [NEW PACKAGE]

#### [NEW] `packages/commercial/pyro_ads_policy/pubspec.yaml`
- 建立 `pyro_ads_policy` 微包，依赖 `pyro_ads_protocol`、`pyro_ads_hub` 及 `pyro_config_remote`。

#### [NEW] `packages/commercial/pyro_ads_policy/lib/src/models/ad_policy_spec.dart`
- 定义本地控制策略规则模型（用户生命周期 Tier 分发规则：新用户 Tier 1、活跃用户 Tier 2、流失风险 Tier 4、VIP 用户 None，频控冷却秒数等）。

#### [NEW] `packages/commercial/pyro_ads_policy/lib/src/ad_policy_manager.dart`
- 继承 `Notifier<AdTrafficTier>` / Riverpod 状态通知器，作为全 App 的策略大脑。
- 复刻并演进 `pyro_ads_magma` 的 Tier 1~5 降级路由机制。
- 监听 `AuraRemoteConfig.onConfigUpdated` 流，解析云端下发的 `commercial_policy` JSON 策略，动态重定向与覆盖本地策略。
- 响应式向全 App 的高层 UI 门户与中台广播当前的 `AdTrafficTier` 决议。

---

### 4. 纠正 Commercial Hub 越权与装配纽带 (`pyro_commercial_hub`)

#### [MODIFY] `packages/commercial/pyro_commercial_hub/lib/src/commercial_hub.dart`
- 移除 `showRewardedAdForPrivilege` 中硬编码的 `initialTier = AdTrafficTier.tier1`。
- 改为向 `pyro_ads_policy` 获取当前决议出的动态有效 Tier，绝不越权硬编码指定 Tier。
- 聚焦于：**`CommercialAdConnectors` 装配挂载 + 激励视频看广告换 VIP 特权写盘**。

---

### 5. 彻底重构 AdMob 驱动微包 (`pyro_ads_admob`)

#### [REFACTOR] 1:1 对齐 `pyro_ads_magma/lib/src/networks/admob_adapter.dart`
- **`pyro_ads_admob/lib/src/pyro_ads_admob_adapter.dart`**: 重构实现纯哑驱动，直接管理原生 XML 布局工厂注册、`_AdMobBanner` 与 `_AdMobNative` 控件以及插屏/激励/开屏逻辑。
- **剔除多余过度拆分逻辑**: 删除 `lib/ad_manager.dart` 中的 `AdConfig` 与 `AdManager` 单例、`lib/adwidgets/app_open_ad.dart` 中的 `AppOpenAdManager`，以及 Riverpod 的 `adCacheProvider`。彻底实现零私有 Manager、零私有 Riverpod 状态、纯哑驱动！

---

## 🧪 三、 验证计划 (Verification Plan)

### 1. 自动化单元测试
- **`pyro_ads_protocol_test.dart`**：验证 `AdsConfig` 契约查表 `getPlacementId()` 在各 Provider ID 与 `AdSlotType` 下的匹配准确性。
- **`pyro_ads_hub_test.dart`**：验证 `AdsHub.instance.setProductionConfig` 注入后，`AdsInlineBanner` / `AdsNative` 无传参时自动提取生产配置 ID 与无配置时的测试 ID 降级。
- **`pyro_ads_policy_test.dart`** [NEW]：测试 `AdPolicyManager` 的本地生命周期规则决议，以及模拟 `AuraRemoteConfig` 云端 JSON 策略下发后的热更新切 Tier。
- **`commercial_hub_test.dart`**：验证 `CommercialHub` 在剥离硬编码 `initialTier` 后，与 `AdPolicyManager` 动态 Tiers 的联动兑换。
- **`pyro_ads_admob_test.dart`**：验证重构后的纯哑驱动 `PyroAdsAdmobAdapter` 在不依赖 `AdManager` / `adCacheProvider` 情况下正确初始化及响应全格式广告请求。

### 2. 交互与全流程校验
- 在 `pyro_commercial_hub/test/` 或宿主 App 测试入口中运行全流程挂载测试，验证主 App 冷启动初始化 ➔ 灌入 `AdsConfig` ➔ `AdPolicyManager` 计算 Tier ➔ `AdsHub` 瀑布流降级 ➔ 哑驱动渲染的完整闭环。
