# pyro_cloud_drive_onedrive

Microsoft OneDrive Graph API 云盘驱动微包。

## 💡 核心职责

实现 `CloudDriveAdapter` 接口 (`OneDriveDriveAdapter`)，封装 Microsoft Graph API v1.0：
- 支持 MSAL / OAuth2 授权登录。
- 实现 `approot` 目录及普通云盘目录的文件读写、分块上传与 SHA256 校验。
- 零依赖 Hub，仅依赖 `pyro_cloud_drive_protocol`。
