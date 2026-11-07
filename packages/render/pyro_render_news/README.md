# pyro_render_news

`pyro_render_news` 是新闻资讯类短文本内容的**专用具体渲染与交互消费实现包**。

## 目录结构与标准设计规范
严格遵循 Pyro 微包标准分层架构：
```
packages/pyro_render_news/
  ├── lib/
  │   ├── pyro_render_news.dart            # 统一根导出入口
  │   ├── l10n/
  │   │   └── intl_en.arb                   # 标准 ARB 国际化定义模板
  │   └── src/
  │       ├── news_localizations.dart       # 可被主工程覆盖的语言接口与默认实现
  │       ├── news_intents.dart             # 新闻交互意图 (Read, Share, OCR, Translate)
  │       ├── news_card.dart                # 多模态高颜值瀑布流卡片 Widget (配图封面、来源徽标、作者头像)
  │       ├── news_action_provider.dart     # 新闻动作交互中枢
  │       └── news_renderer.dart            # 微包装配中枢
  └── test/
      └── pyro_render_news_test.dart       # 单元测试与国际化覆盖验证
```

## 职责范围
* 实现新闻卡片（`CardBuilder`）的具体 UI，支持配图封面、发布源小徽标与作者头像的动态瀑布流展现，并在点击时触发落地路由。
* 实现新闻/资讯全屏深度阅读器（`NewsReaderScreen`），支持分类标签、来源作者信息、富文本正文排版、动态字号调节、链接复制与 OCR/翻译工具。
* 向 `pyro_render_hub` 注册标准 `ReaderBuilder`（`registerReader('news', ...)`）与详情路由（`registerRoute('news_detail', ...)`）。
* 在初始化时向 `pyro_render_hub` 与 `pyro_action_hub` 统一注册：
  ```dart
  NewsRenderer.register();
  ```

