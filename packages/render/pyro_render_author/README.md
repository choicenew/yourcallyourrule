# pyro_render_author

`pyro_render_author` 是创作者与作者主页内容的**具体渲染与消费实现微包**。

## 职责与组件
* **创作者卡片 (`AuthorCard`)**: 实现了信息流内的创作者卡片，展示作者头像、认证徽标、简介签名、作品数与粉丝数统计看板，并在点击时触发全屏创作者主页路由。
* **作者主页落地页面 (`AuthorProfileScreen`)**: 全模态通用的作者主页整体布局，包含头像、背景横幅、关注状态与统计看板，并向 `pyro_render_hub` 注册标准 `ReaderBuilder`（`registerReader('author', ...)`）与主页路由（`registerRoute('author_profile', ...)` / `registerRoute('author_detail', ...)`）。
* **动作提供者 (`AuthorActionProvider`)**: 实现 `ActionProvider` 规范，为作者模组提供 `follow`/`following`、`like`/`liked`、`share` 与 `translate` 等响应式工具栏操作意图管理。
* **国际化适配 (`AuthorLocalizations`)**: 支持应用全局或者微包层级自适应重写创作者模块相关提示词与操作文案。
* **意图定义 (`AuthorIntents`)**: 定义 `AuthorFollowIntent`、`AuthorLikeIntent`、`AuthorShareIntent` 与 `AuthorTranslateIntent` 业务意图。
* **插槽解耦嵌入**: 独立于具体的 `pyro_render_feed_ui` 包，直接通过 `pyro_render_hub` 获取并嵌入名为 `feed_ui_slot` 的通用 UI 插槽组件：
  ```dart
  RenderHub.instance.buildSlot('feed_ui_slot', slotParams)
  ```
* **生命周期与动作注册**:
  ```dart
  AuthorRenderer.register(); // 自动注册 RenderHub 的 Card/Reader/Route 以及 ActionHub 的 ActionProvider
  ```
