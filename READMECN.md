# YourCallYourRule: 您的通话与短信规则，由您掌控

**YourCallYourRule** 是一款功能强大且高度可定制的安卓应用，旨在让您完全控制来电和短信。您可以根据电话号码、关键字等创建个性化的拦截规则。

- **Telegram 频道：** https://t.me/yourcallyourrule
- **Telegram 群组：** https://t.me/+GHoPy6xwQEU1ZThh
- **Google Play 测试版：** https://play.google.com/apps/testing/com.yours.yourcallyourrule
- **Google Play 链接：** https://play.google.com/store/apps/details?id=com.yours.yourcallyourrule

> **注意**：由于 Google Play 的政策限制，商店版本不包含短信过滤功能。如果您需要此功能，请从本仓库的 [Releases](https://github.com/choicenew/yourcallrule/releases) 页面下载相应版本。请注意，两种版本的应用无法同时安装。

## 核心功能

*   **黑白名单管理**：轻松创建允许和阻止的号码列表。
*   **规则导入/导出**：方便地备份和分享您的拦截规则。
*   **在线规则订阅**：通过提供订阅链接，获取在线更新的骚扰号码数据库。
*   **正则表达式支持**：使用正则表达式定义复杂的拦截逻辑。
*   **STIR/SHAKEN 集成**：利用 STIR/SHAKEN 技术增强来电显示验证（目前支持北美等部分地区）。
*   **SIM 卡识别**：根据接收来电的 SIM 卡应用不同规则。
*   **灵活的拦截操作**：可选择挂断、静音或接听后立即挂断。
*   **隐私与数据控制**：所有数据均在本地管理，应用本身不包含在线数据库，确保您的隐私安全。
*   **云端备份与恢复**：支持通过 WebDAV、Google Drive 和 OneDrive 备份和恢复您的配置。

## 插件系统

`YourCallYourRule` 的核心优势之一是其强大的插件系统，允许您通过抓取网页数据来识别陌生号码。

*   **插件目录**：所有官方和社区贡献的插件都位于本仓库的 `/plugins` 目录下。
*   **模板文件**：在 `/plugins` 目录中，我们提供了一个 `template.js` 文件，您可以基于此模板来开发自己的插件。
*   **更新状态**：请注意，目前只有 `/plugins` 目录下的插件是最新且经过维护的。

### 如何创建与测试自己的插件？（AI 自动化测试工作流）

无需安装或运行 Android 模拟器，即可轻松开发并测试插件：

1. **下载/打开 `plugindemo`**：使用本仓库中的独立 `plugindemo` 示例工程，其中包含了全套插件服务与本地无模拟器测试工具。
2. **AI 自动化 Skill (`SKILL.md`)**：将目标查询网页源码（或 API 文档）与 [plugindemo/SKILL.md](file:///C:/Users/Ngokel/Desktop/en/test/github/yourcallyourrulemixhistory/plugindemo/SKILL.md) 技能文档一同提供给 AI（如 Cursor, ChatGPT, Gemini, Claude 等）。
3. **全自动编写与单元测试**：AI 将严格遵照 `SKILL.md` 中的标准 SOP，自动选择最新的 API 模版（`Chinese_API.js` 等）或非 API 纯正则 HTML 模版（`Chinese.js`, `Universal_Regex_API_HTML_CN.js` 等）编写脚本，并直接在本地 QuickJS 环境中运行单测与自愈校验。

## 贡献与支持

我们欢迎并鼓励社区用户为项目做出贡献。

*   **提交插件**：如果您创建了新的、实用的插件，请通过 Pull Request 分享给我们。
*   **反馈问题**：通过 [Issues](https://github.com/choicenew/yourcallrule/issues) 报告错误或提出功能建议。
*   **国际化 (i18n)**：应用的界面翻译主要由 AI 完成，可能存在不准确之处。如果您发现任何翻译错误，欢迎提出修改。
    *   **翻译流程**：我们使用 `l10n.yaml` 配合 Firebase Studio 进行 ARB 文件的翻译。您可以在任意一个新的 Flutter 项目中，将 `tool/translate.dart` 文件放入相应目录，配置好 API 后即可对 ARB 文件进行翻译。

## 免责声明

*   **非专业开发**：本应用由个人开发者业余时间维护，更新可能不规律。
*   **数据来源**：应用不内置任何号码数据库，所有数据均需用户通过订阅链接或自定义插件提供。
