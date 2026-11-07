# pyro_render_ad_protocol

渲染层与 Feed 容器广告占位符抽象协议包 (0 依赖任何广告 SDK)。

## 💡 核心职责

1. **`RenderAdSlot` 极简广告占位组件**:
   - 提供清爽的命名构造函数：`RenderAdSlot.bottomBanner()`, `.topBanner()`, `.inlineMedium()`, `.inlineLarge()`, `.inlineChip()`, `.fullScreen()`。
2. **`RenderAdInterface` 全局接口入口**:
   - 商业化装配层启动时通过 `setAdBuilder()` 注入真实广告渲染回调。
   - 当 VIP 用户免广告或未注入广告库时，自动隐形坍缩为 `SizedBox.shrink()` (0 像素开销)。
