# pyro_render_paper

`pyro_render_paper` 是学术文献与论文研究出版物的**专用具体渲染与交互消费实现包**。

## 目录结构与标准设计规范
严格遵循 Pyro 微包标准分层架构，杜绝单文件混杂：
```
packages/pyro_render_paper/
  ├── lib/
  │   ├── pyro_render_paper.dart            # 统一根导出入口
  │   ├── l10n/
  │   │   └── intl_en.arb                   # 标准 ARB 国际化定义模板
  │   └── src/
  │       ├── paper_localizations.dart       # 可被主工程动态覆盖的国际化接口与默认 English 实现
  │       ├── paper_intents.dart             # 学术意图全集 (Read, Share, Push, Cite, OCR, Translate)
  │       ├── paper_action_provider.dart     # 标准 ActionProvider 交互中枢
  │       ├── paper_card.dart                # 纯数据驱动的自适应学术卡片 Widget
  │       └── paper_renderer.dart            # 微包生命周期装配中枢
  └── test/
      └── pyro_render_paper_test.dart       # 单元测试与国际化覆盖验证
```

## 职责范围
* 实现学术文献卡片（`CardBuilder`）的具体 UI 构建与点击自闭环。
* 实现学术文献详情路由与全屏阅读器（`PaperReaderScreen`），支持摘要、作者元数据、关键词标签、分节学术正文及 BibTeX 一键导出复制。
* 向 `pyro_render_hub` 注册标准 `ReaderBuilder`（`registerReader('paper', ...)`）与详情路由（`registerRoute('paper_detail', ...)`）。
* 在应用启动时向 `pyro_render_hub` 与 `pyro_action_hub` 统一注册：
  ```dart
  PaperRenderer.register();
  ```


## 动作意图全集与零耦合推送
* 实现了 `PaperActionProvider` 并注册到 `ActionHub`。
* 动作清单包含：
  * **阅读详情 (`PaperReadIntent`)**：权重 100。
  * **分享文献 (`PaperShareIntent`)**：权重 60。
  * **中立推送 / 收藏 (`PaperPushIntent`)**：权重 50，通过标准事件广播文献 ID 与元数据，外部通道插件（如 Zotero、WebDAV 等）或 `pyro_push_hub` 可自由订阅，微包自身绝不耦合具体服务。
  * **引文导出 (`PaperCitationExportIntent`)**：权重 40，导出 BibTeX / RIS。
  * **OCR 文本公式提取 (`PaperOCRIntent`)**：权重 30。
  * **AI 智能翻译与引擎翻译 (`PaperTranslateAIIntent` / `PaperTranslateEngineIntent`)**：权重 20。

## 国际化架构与主包覆盖机制
* 本包提供 `PaperLocalizations` 抽象接口与默认英文实现；
* 主工程（如 `pyro_magma`）拥有最终翻译权，可通过全局注入或标准 `LocalizationsDelegate` 随时彻底覆盖本微包的全部文案：
  ```dart
  PaperLocalizations.setCustomInstance(MyCustomPaperLocalizations());
  ```

## 纯数据驱动视觉准则
* 卡片渲染完全基于上游供给的元数据字典，绝不硬编码假定含有特定协议标识（如 DOI、Open Access 等），有标签按原样渲染，无标签自适应紧凑排版。
