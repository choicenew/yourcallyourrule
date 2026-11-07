# pyro_cloud_drive_ui

云盘设置与多网盘管理 UI 界面微包。

## 💡 核心职责

提供通用的 Flutter 云盘管理与同步状态 UI：
- `CloudSettingsPage`: 云盘设置主页面，展示已配置的网盘列表与端到端加密开关。
- `CloudSyncStatusWidget`: 展示网盘连接状态、上次同步时间与手动同步触发按钮。
- `EncryptionPasswordDialog`: 端到端加密密码设置与校验弹窗。
- 支持基于 `CloudServiceUIConfig` 动态生成配置表单，内置中英文 ARB 多语言支持 (`CloudDriveLocalizations`)。
