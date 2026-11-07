# pyro_cloud_drive_webdav

WebDAV 协议通用云盘驱动微包。

## 💡 核心职责

实现 `CloudDriveAdapter` 接口 (`WebDavDriveAdapter`)，支持坚果云、Nextcloud、OwnCloud 及各种自建 WebDAV 服务：
- 支持 HTTP Basic Auth 与 Digest 认证。
- 实现 PROPFIND 目录查询、MKCOL 目录创建、PUT/GET 文件流传输与 ETag 校验。
- 零依赖 Hub，仅依赖 `pyro_cloud_drive_protocol`。
