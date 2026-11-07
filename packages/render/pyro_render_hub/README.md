# pyro_render_hub

`pyro_render_hub` 是渲染体系中的**中介与注册中心（Mediator Registry）**。它不负责任何具体的 UI 渲染，而是作为一个“服务定位器”调度中心，统一转发卡片和插槽的构建请求。

## 主要内容
### `RenderHub`
提供以下能力：
*   **注册**：
    *   `registerCard(type, builder)`: 内容渲染包在初始化时注册对应的卡片。
    *   `registerSlot(name, builder)`: UI 容器包（如 Feed UI）注册对应的功能插槽。
    *   `registerRoute(type, action)`: 注册页面路由跳转处理器。
*   **分发**：
    *   `buildCard(type, data)`: 输入具体类型和泛型数据，产出对应的卡片 Widget。
    *   `buildSlot(name, params)`: 输入插槽名与参数，产出对应的局部插槽 Widget。
    *   `navigate(context, type, params)`: 执行对应类型的跳转动作。
