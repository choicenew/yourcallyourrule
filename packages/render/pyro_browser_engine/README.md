# pyro_browser_engine

网页端侧 Headless 浏览器 JS 注入桥接与选中文本提取引擎包。

## 💡 核心职责

1. **`BrowserJsBridge`**:
   - 包含网页核心正文 DOM 提取脚本 (`extractArticleScript`)。
   - 包含 WebView 选中文本监听脚本 (`selectionListenerScript`)。
   - 包含长按/右键菜单屏蔽与恢复脚本 (`suppressContextMenuScript` / `allowContextMenuScript`)。
2. **`BrowserEngineNotifier` (Riverpod 状态机)**:
   - 纯 Headless 状态机，解耦记录当前网页选中文本、提炼的正文内容、提取状态与划词翻译结果。
