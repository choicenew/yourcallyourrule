# 📦 pyro_ads_policy (Commercial Ad Policy Micro-Package)

> **定位**：Pyro Commercial 商业变现矩阵中的**广告策略控制与动态 Tier 路由独立微包**。

---

## 🏛️ 一、 架构设计与领域隔离原则 (Domain Isolation)

本包遵循 **Pyro Monorepo 领域物理隔离原则 (Domain Isolation Principle)**：
- **零跨域硬依赖**：本包位于 `packages/commercial/` 商业化领域内，**物理上 0 依赖**任何风控包（`pyro_risk_profiler`）或推荐算法包（`packages/algorithms/`）。
- **函数委托注入 (Function Delegate Resolver)**：主 App 若需接入外部风控或算法，只需在启动时传入 `AdPolicyTierResolver` 纯函数句柄，彻底解耦。

```text
┌────────────────────────────────────────────────────────┐
│             1. 宿主 App (main.dart / bootstrap.dart)    │
│    (注入 AppAdsConfig，传入 setCustomTierResolver 委托) │
└───────────────────────────┬────────────────────────────┘
                            │
                            ▼
                 2. pyro_ads_policy (本包)
       (AdPolicyManager: 本地规则 + 极速云重载 + 策略决议)
                            │
                            ▼
                    3. pyro_ads_hub
                (中央注册中心与瀑布流降级仲裁)
```

---

## ⚙️ 二、 核心组件说明

### 1. `AdPolicySpec` (策略规范数据模型)
用于定义商业化策略的具体参数：
- `defaultTier`: 默认基准流量梯队（默认 `AdTrafficTier.tier1`）。
- `newUserTier` / `activeUserTier` / `churnRiskUserTier`：不同生命周期阶段的基准 Tier。
- `vipTier`: VIP 特权用户 Tier（默认 `AdTrafficTier.none` 关闭广告）。
- `interstitialMinIntervalSeconds`: 插屏广告最小冷却秒数。
- `regionTierOverrides`: 地域动态重定向配置 Map（如 `{'JP': 'tier2'}`）。

### 2. `AdPolicyManager` (策略控制器单例)
继承自 `ValueNotifier<AdTrafficTier>`，向全 App 广播当前策略决议：
- **`attachRemoteConfig(AuraRemoteConfig remoteConfig)`**：绑定并监听云端双云下发引擎的 `onConfigUpdated` 流，云端下发 JSON 策略时自动解析并实时热更新。
- **`setCustomTierResolver(AdPolicyTierResolver? resolver)`**：允许主 App 动态注入自定义策略回调。
- **`updateVipStatus(bool isVip)`**：更新本地 VIP 状态（VIP 自动分配 `AdTrafficTier.none`）。

---

## 🚀 三、 极速接入与使用 SOP

### 1. 主 App 初始化与闭包委托注入
在主 App 的冷启动阶段（如 `main.dart`）：

```dart
import 'package:pyro_ads_policy/pyro_ads_policy.dart';

void initAdPolicy() {
  final policyManager = AdPolicyManager.instance;

  // 1. (可选) 绑定云端 Remote Config 监听热更新
  policyManager.attachRemoteConfig(RemoteConfigService.instance.auraRemoteConfig);

  // 2. (可选) 注入主 App 自身的动态评估函数委托 (彻底零跨域硬依赖)
  policyManager.setCustomTierResolver(() {
    // 调用主 App 内部掌握的风控/算法运算结果并返回 Tier
    return myAppRiskService.currentEvaluatedAdTier;
  });
}
```

### 2. UI 门户与中台响应式消费
高层 UI 门户（如 `AdsInlineBanner`）与商业中台（`CommercialHub`）会自动读取 `AdPolicyManager.instance.value` 作为当前生效的 `AdTrafficTier` 策略。

---

## 📄 四、 许可证 (License)

MIT License - Pyro Magma Workspace
