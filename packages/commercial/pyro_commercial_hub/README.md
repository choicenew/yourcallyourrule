# Pyro Commercial Hub (商业变现与激励调度中台)

商业变现与激励广告调度中枢门面微包。

## 🌟 核心职责

1. **变现与特权聚合 (`CommercialHub`)**：
   - 聚合内购特权 (`pyro_purchase_core`) 与广告调度 (`pyro_ads_hub`)；
   - 提供观看激励视频兑换限时 VIP 特权的统一业务转化策略模型。
2. **连接器注入挂载 (`CommercialAdConnectors`)**：
   - 将 `AdsHub` 中的横幅与原生广告组件桥接挂载至 `RenderAdInterface`。
3. **架构解耦纯洁性**：
   - 遵循 `commercial_architecture_protocol`，底层各广告驱动（`pyro_ads_admob`, `pyro_ads_applovin`, `pyro_ads_unity`, `pyro_ads_startapp`, `pyro_house_ads` 等）相互独立并等同自洽，平级注册至 `AdsHub.instance`。

## 🚀 快速使用

```dart
// 1. 初始化商业中台
CommercialHub.init(
  purchaseState: purchaseState,
);

// 2. 挂载广告渲染连接器
CommercialAdConnectors.ensureAdConnectorsMounted();
```
