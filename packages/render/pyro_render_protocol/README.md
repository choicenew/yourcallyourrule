# pyro_render_protocol

`pyro_render_protocol` 是渲染体系中的**纯契约与协议定义包**。

## 职责定位
* **绝对无状态**：不管理任何注册表，不提供单例实例，不保存任何运行时状态。
* **类型定义**：定义了 `CardBuilder`、`SlotBuilder` 和 `RouteAction` 等类型签名。
* **零耦合**：没有任何外部包依赖（仅依赖 Flutter 框架的 `Widget` 和 `BuildContext`）。
