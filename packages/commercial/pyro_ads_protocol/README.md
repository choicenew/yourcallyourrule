# 📦 pyro_ads_protocol (Commercial Ads Protocol Package)

> **定位**：Pyro Commercial 商业变现矩阵中的**纯抽象契约与全平台生产/测试广告位 ID 配置大本营**。

---

## 🏛️ 一、 架构规范与红线 (Domain Isolation)

- **纯抽象契约**：仅定义接口与数据模型，**物理上 0 依赖任何三方 SDK**（如 AdMob, AppLovin, Firebase 等）。
- **零跨域依赖**：仅依赖 `flutter` SDK，作为商业化矩阵最底层的契约包供所有驱动、Hub 与策略包引用。

---

## ⚙️ 二、 核心类与模型

1. **`NetworkAdapter`**：广告渠道微驱动统一抽象接口（定义 `initialize`, `buildBanner`, `buildNative`, `load/showInterstitial`, `load/showRewarded`, `load/showAppOpen` 及测试 ID 提取）。
2. **`AdsConfig`**：全平台生产环境与测试环境广告位 ID（Banner, MREC, Interstitial, Rewarded, Native, AppOpen）集中强类型配置基类。提供多态查表提取方法 `getPlacementId(String providerId, AdSlotType slotType)`。
3. **`AdProviderToken`**：广告渠道 Provider 标识 Token 常量类（`admob`, `applovin`, `unity`, `startio`, `liftoff`, `house_ads`），严格符合无裸字符串硬编码规约。
4. **`AdTrafficTier`**：流量/广告位梯队分级枚举（`tier1` ~ `tier5`, `none`）。
5. **`MagmaRewardItem`**：激励广告视频播放完毕触发的奖励回调数据模型。

---

## 📄 三、 许可证 (License)

MIT License - Pyro Magma Workspace
