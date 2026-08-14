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

### 如何创建自己的插件？

创建插件比您想象的要简单，即使没有编程背景也可以完成：

1.  在浏览器中打开您想作为数据源的网站（例如，任何一个号码查询网站）。
2.  打开浏览器的开发者工具（通常是 `Ctrl`+`Shift`+`I`），复制网页的源代码。
3.  将 **网页源代码**、`/plugins` 目录下的 **`template.js` 模板** 以及 **任意一个已有的插件文件作为示例** 一同提供给 AI（如 ChatGPT, Gemini 等）。
4.  指示 AI ：“请根据这个网页源码和模板，参考这个示例，帮我创建一个用于解析号码信息的插件。”

AI 通常能够理解您的需求并生成可用的插件代码。

## 贡献与支持

我们欢迎并鼓励社区用户为项目做出贡献。

*   **提交插件**：如果您创建了新的、实用的插件，请通过 Pull Request 分享给我们。
*   **反馈问题**：通过 [Issues](https://github.com/choicenew/yourcallrule/issues) 报告错误或提出功能建议。
*   **国际化 (i18n)**：应用的界面翻译主要由 AI 完成，可能存在不准确之处。如果您发现任何翻译错误，欢迎提出修改。
    *   **翻译流程**：我们使用 `l10n.yaml` 配合 Firebase Studio 进行 ARB 文件的翻译。您可以在任意一个新的 Flutter 项目中，将 `tool/translate.dart` 文件放入相应目录，配置好 API 后即可对 ARB 文件进行翻译。

## 免责声明

*   **非专业开发**：本应用由个人开发者业余时间维护，更新可能不规律。
*   **数据来源**：应用不内置任何号码数据库，所有数据均需用户通过订阅链接或自定义插件提供。
