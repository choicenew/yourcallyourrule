# pyro_render_audio

`pyro_render_audio` 是音频音乐与播客有声书的**专用具体渲染与交互消费实现包**。

## 目录结构与标准设计规范
严格遵循 Pyro 微包标准分层架构：
```
packages/pyro_render_audio/
  ├── lib/
  │   ├── pyro_render_audio.dart            # 统一根导出入口
  │   ├── l10n/
  │   │   └── intl_en.arb                   # 标准 ARB 国际化定义模板
  │   └── src/
  │       ├── audio_localizations.dart       # 可被主工程覆盖的语言接口与默认实现
  │       ├── audio_intents.dart             # 音频交互意图 (Play, Like, Download)
  │       ├── audio_card.dart                # 纯数据驱动的自适应音频卡片 Widget
  │       ├── audio_action_provider.dart     # 音频动作交互中枢
  │       └── audio_renderer.dart            # 微包装配中枢
  └── test/
      └── pyro_render_audio_test.dart       # 单元测试与国际化覆盖验证
```

## 职责范围
* 实现音频卡片（`CardBuilder`）的具体 UI 构建，并在点击时触发落地路由。
* 实现全屏深度音频/播客播放与消费器（`AudioPlayerScreen`），支持唱片旋转视效、播放/暂停控制、进度调节、上一曲/下一曲切换、倍速调整及一键点赞。
* 向 `pyro_render_hub` 注册标准 `ReaderBuilder`（`registerReader('audio', ...)`）与详情路由（`registerRoute('audio_detail', ...)`）。
* 在初始化时向 `pyro_render_hub` 与 `pyro_action_hub` 统一注册：
  ```dart
  AudioRenderer.register();
  ```

