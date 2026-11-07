# pyro_render_novel

`pyro_render_novel` 是小说与图书类长文本内容的**专用具体渲染与交互消费实现包**。

## 目录结构与标准设计规范
严格遵循 Pyro 微包标准分层架构：
```
packages/pyro_render_novel/
  ├── lib/
  │   ├── pyro_render_novel.dart            # 统一根导出入口
  │   ├── l10n/
  │   │   └── intl_en.arb                   # 标准 ARB 国际化定义模板
  │   └── src/
  │       ├── novel_localizations.dart       # 可被主工程覆盖的语言接口与默认实现
  │       ├── novel_intents.dart             # 小说交互意图 (Read, Shelf, Translate)
  │       ├── novel_card.dart                # 多模态高颜值瀑布流卡片 Widget (大封面、作者头像、标签)
  │       ├── novel_action_provider.dart     # 小说动作交互中枢
  │       └── novel_renderer.dart            # 微包装配中枢
  └── test/
      └── pyro_render_novel_test.dart       # 单元测试与国际化覆盖验证
```

## 职责范围
* 实现小说卡片（`CardBuilder`）的具体 UI，支持封面、作者小头像与分类标签的动态瀑布流展现。
* 实现深层全屏小说阅读器（`NovelReaderScreen`），提供分页排版、字号调节、纯白/羊皮纸/暗夜多主题护眼切换与章节跳转。
* 在初始化时向 `pyro_render_hub` 与 `pyro_action_hub` 统一注册卡片、阅读器与详情路由：
  ```dart
  NovelRenderer.register();
  ```
