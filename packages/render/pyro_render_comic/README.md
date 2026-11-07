# pyro_render_comic

`pyro_render_comic` 是漫画、条漫与画集类图像视觉内容的**专用具体渲染与交互消费实现包**。

## 目录结构与标准设计规范
严格遵循 Pyro 微包标准分层架构：
```
packages/pyro_render_comic/
  ├── lib/
  │   ├── pyro_render_comic.dart            # 统一根导出入口
  │   ├── l10n/
  │   │   └── intl_en.arb                   # 标准 ARB 国际化定义模板
  │   └── src/
  │       ├── comic_localizations.dart       # 可被主工程覆盖的语言接口与默认实现
  │       ├── comic_intents.dart             # 漫画交互意图 (Read, Shelf, OCR, Translate)
  │       ├── comic_card.dart                # 多模态高颜值瀑布流卡片 Widget (大纵向封面、作者头像、标签)
  │       ├── comic_action_provider.dart     # 漫画动作交互中枢
  │       └── comic_renderer.dart            # 微包装配中枢
  └── test/
      └── pyro_render_comic_test.dart       # 单元测试与国际化覆盖验证
```

## 职责范围
* 实现漫画卡片（`CardBuilder`）的具体 UI，支持高比海报、作者小头像与分类标签的动态瀑布流展现，并在点击时触发落地路由。
* 实现全屏深度漫画阅读器（`ComicReaderScreen`），支持沉浸阅读、连续卷轴/单页翻页模式切换、多级缩放、双语气泡 OCR 提取与翻译。
* 向 `pyro_render_hub` 注册标准 `ReaderBuilder`（`registerReader('comic', ...)`）与详情路由（`registerRoute('comic_detail', ...)`）。
* 在初始化时向 `pyro_render_hub` 与 `pyro_action_hub` 统一注册：
  ```dart
  ComicRenderer.register();
  ```

