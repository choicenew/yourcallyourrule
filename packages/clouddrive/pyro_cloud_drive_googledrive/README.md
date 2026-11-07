# pyro_cloud_drive_googledrive

Google Drive REST API 云盘驱动微包。

## 💡 核心职责

实现 `CloudDriveAdapter` 接口 (`GoogleDriveAdapter`)，封装 Google Drive v3 REST API：
- 支持 OAuth2 令牌授权与自动刷新。
- 实现 App Data / Drive 文件的上传、下载、CRUD 与 MD5 校验。
- 零依赖 Hub，仅依赖 `pyro_cloud_drive_protocol`。
