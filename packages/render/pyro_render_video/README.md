# pyro_render_video

`pyro_render_video` 是视频多媒体内容的**专用具体渲染与交互消费实现包**。

## 目录结构与标准设计规范
严格遵循 Pyro 微包标准分层架构：
```
packages/pyro_render_video/
  ├── lib/
  │   ├── pyro_render_video.dart            # 统一根导出入口
  │   ├── l10n/
  │   │   └── intl_en.arb                   # 标准 ARB 国际化定义模板
  │   └── src/
  │       ├── video_localizations.dart       # 可被主工程覆盖的语言接口与默认实现
  │       ├── video_intents.dart             # 视频交互意图 (Play, Like, Download)
  │       ├── video_card.dart                # 纯数据驱动的视频卡片 Widget
  │       ├── video_action_provider.dart     # 视频动作交互中枢
  │       └── video_renderer.dart            # 微包装配中枢
  └── test/
      └── pyro_render_video_test.dart       # 单元测试与国际化覆盖验证
```

## 职责范围
* 实现视频卡片（`CardBuilder`）的具体 UI 构建，并在点击时触发落地路由。
* 实现全屏深度视频播放与消费器（`VideoPlayerScreen`），支持播放/暂停控制、进度跳转、倍速调整（1.0x / 1.5x / 2.0x）、清晰度切换及点赞下载动作。
* 向 `pyro_render_hub` 注册标准 `ReaderBuilder`（`registerReader('video', ...)`）与详情路由（`registerRoute('video_detail', ...)`）。
* 在初始化时向 `pyro_render_hub` 与 `pyro_action_hub` 统一注册：
  ```dart
  VideoRenderer.register();
  ```

