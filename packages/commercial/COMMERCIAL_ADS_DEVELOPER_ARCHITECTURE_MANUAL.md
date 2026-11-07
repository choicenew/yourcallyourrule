# 🧠 Pyro 商业化广告系统 — 核心开发与维护架构手册
> **(Commercial Ads Developer Architecture & Maintenance Manual)**
> 
> **手册定位**：本文档为底层广告框架、策略决策引擎与重构治理的**核心开发与维护手册**。详细记录了 Protocol - Policy - Hub - Driver 四层单向拓扑、生产 ID 集中注入流向、AuraRemoteConfig 云端热重载策略与谷歌 AdMob 零遮挡合规红线。

---

## 🏛️ 一、 Protocol - Policy - Hub - Driver 核心单向解耦拓扑

系统遵循严谨的领域单向依赖拓扑，避免任何跨层与跨领域硬硬耦合：

```text
┌─────────────────────────────────────────────────────────────────────────┐
│                    1. 宿主 App (main.dart / bootstrap.dart)              │
│       (一键灌入 AppAdsConfig，横插 PyroAppLaunchGuard 冷启动门禁)        │
└─────────────────────────────────┬───────────────────────────────────────┘
                                  │
      ┌───────────────────────────┼───────────────────────────┐
      ▼                           ▼                           ▼
2. pyro_commercial_hub   3. pyro_ads_policy          4. pyro_purchase_core / ui
 (商业变现装配门面中台)     (策略大脑: 本地/云端Tier)   (IAP 原生支付 & VIP 状态写盘)
 ├── CommercialAdConnectors       ├── AdPolicySpec           ├── PurchaseEngine
 └── RewardedAdStrategy           └── AdPolicyManager        └── PurchaseState
      │                           │                           │
      └───────────────────────────┼───────────────────────────┘
                                  ▼
                        5. pyro_ads_hub
                   (注册定位器 & 瀑布流降级仲裁中枢)
                   ├── AdsHub.instance (_drivers & _adsConfig)
                   └── WaterfallStrategyArbitrator (降级链)
                                  │
                                  ▼
                        6. pyro_ads_<driver>
                 (AdMob / AppLovin / Liftoff 等哑驱动微包)
                 └── 1:1 纯哑巴实现 (零私有 Manager)
                                  │
                                  ▼
                        7. pyro_ads_protocol
                   (纯契约：NetworkAdapter & AdsConfig 大本营)
```

---

## ⚙️ 二、 全平台生产环境广告 ID 注入与降级链路

```text
                           UI 门户 (AdsInlineBanner / AdsNative)
                                        │
                                        ▼
                           是否显式传入了 placementId ?
                                  ╱           ╲
                             (是)╱             ╲(否)
                                ▼               ▼
                        使用显式 placementId   调用 AdsHub.instance.getPlacementId()
                                                提取注入的 AdsConfig 生产 ID
                                                        │
                                                        ▼
                                                配置是否存在生产 ID ?
                                                       ╱       ╲
                                                  (是)╱         ╲(否)
                                                     ▼           ▼
                                                使用生产 ID   调用 adapter.getTest*Id()
                                                              兜底降级为官方测试 ID
```

---

## 🧠 三、 商业策略微包 (`pyro_ads_policy`) 运行原理

### 1. 本地规则 + 极速云重载流向
- **本地规约 (`AdPolicySpec`)**：基准 Tier1~5 路由及生命周期规则（如 VIP 用户分配 `AdTrafficTier.none`）。
- **云端热重载 (`attachRemoteConfig`)**：监听 `AuraRemoteConfig.onConfigUpdated` 事件，云端下发新的 `commercial_policy` JSON 策略时无感热切换，向全 App 广播最新的 `AdTrafficTier`。
- **函数委托注入 (`AdPolicyTierResolver`)**：主 App 可通过 `setCustomTierResolver` 在外部注入算好的风控/算法层级，物理上 **0 跨域依赖** 风控包！

---

## ⛔ 四、 谷歌 AdMob 政策红线：零遮挡 (Zero Overlap Policy)

### 🚨 绝对禁止在 `AdWidget` 上方覆盖任何 UI 层！
* **谷歌政策风控红线**：Google AdMob 开发者政策（*Ad Overlap & Obscured Ads Policy*）严禁在 `AdWidget`（广告画布）上方覆盖任何 UI 节点（包括 Stack 叠层、透明点击拦截层、GestureDetector 遮罩或 Loading 蒙版）。
* **后果**：任何覆盖在 `AdWidget` 上方的 Flutter UI 都会被 AdMob 后台机器算法判定为“诱导误触/隐藏广告 (Obscured Ad / Invalid Click)”，**直接触发政策告警甚至封禁 AdMob 账号**！
* **合规解法**：
  1. 广告卡片外壳 **必须纯外包 (Outer Wrapping)**，完全不使用 `Stack` 层叠在 `AdWidget` 上方，100% 露出原生广告及其自带的“Ad / 广告”标识。
  2. 触发类广告（如全屏插屏/激励视频）的防重标志位只写在触发按钮的点击事件代码中，**绝对不上广告 UI 覆盖遮罩**！

---

## 🛡️ 五、 哑驱动微包治理红线 (Dumb Driver Rule)

所有广告底层微包（`pyro_ads_admob`, `pyro_ads_applovin`, `pyro_ads_liftoff` 等）：
1. **彻底做纯哑巴 (Dumb Driver)**：绝对不包含私有的 `AdManager` 单例、私有的 `AdConfig` 或内部私有 Riverpod 状态。
2. **零越权**：驱动类只需忠实实现 `NetworkAdapter` 接口，仅负责响应该驱动在原生侧的初始化与广告渲染。
