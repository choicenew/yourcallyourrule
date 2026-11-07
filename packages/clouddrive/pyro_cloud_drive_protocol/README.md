# pyro_cloud_drive_protocol

云盘底层统一抽象契约与数据结构定义包。

## 💡 核心职责

作为 `packages/clouddrive` 领域的纯抽象契约包（仅依赖 `flutter`）：

1. **`CloudDriveAdapter` 驱动抽象接口**:
   - 规定所有具体云盘驱动（WebDAV, OneDrive, GoogleDrive 等）必须实现的统一 CRUD 与文件同步接口：`connect()`, `disconnect()`, `listFiles()`, `uploadFile()`, `downloadFile()`, `readFile()`, `writeFile()`, `fileExists()`, `deleteFile()`, `getRemoteFileHash()`。
2. **基础数据模型与元数据配置**:
   - `CloudFileItem`: 远端网盘文件项模型（路径、名称、大小、最后修改时间、Hash/ETag、是否为目录）。
   - `CloudDriveCredentials`: 网盘身份认证凭证载体。
   - `CloudServiceUIConfig`: 用于 UI 自动渲染网盘配置表单的字段元数据描述模型 (`CloudConfigFieldSpec`)。
