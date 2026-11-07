# Pyro CloudDrive 多云盘与增量同步微包矩阵 (`packages/clouddrive`)

`packages/clouddrive` 是 Pyro 架构中负责**多云盘存储、端到端 AES-256 加密、影子账户隔离与增量数据同步**的通用领域矩阵。

---

## 📁 目录与微包矩阵 (Package Matrix)

`packages/clouddrive` 包含 9 个彻底物理解耦的专用 Package：

```text
packages/clouddrive/
├── pyro_cloud_drive_protocol/      # [1] 纯抽象云盘接口与数据模型 (CloudDriveAdapter, CloudFileItem)
├── pyro_cloud_drive_hub/           # [2] 服务定位器中枢 (CloudDriveHub / 影子账户物理隔离路径合成)
├── pyro_cloud_drive_crypto/        # [3] AES-256-CBC 端到端加密与 Worker 多线程 Isolate 解耦
├── pyro_cloud_drive_database/      # [4] 增量 JSON 同步、MD5 校验、冲突解决与快照恢复
├── pyro_cloud_drive_googledrive/   # [5] Google Drive REST API v3 驱动微包
├── pyro_cloud_drive_onedrive/      # [6] Microsoft OneDrive Graph API v1.0 驱动微包
├── pyro_cloud_drive_webdav/        # [7] WebDAV (坚果云 / Nextcloud / 自建) 协议驱动微包
├── pyro_cloud_drive_hetu/          # [8] 河图 (Hetu Script) 动态云盘绑定
└── pyro_cloud_drive_ui/            # [9] 通用云盘设置与加密弹窗 UI (Riverpod + L10n)
```

---

## 🏗️ 架构特点

1. **Protocol-Hub-Driver 彻底解耦**:
   - 底层驱动 (`googledrive`, `onedrive`, `webdav`) 零 Hub 依赖，仅依赖 `protocol`。
2. **影子账户云端物理隔离**:
   - `CloudDriveHub` 自动结合宿主 App 名称与当前影子账户 ID，智能计算云端隔离路径 `/{appName}/{accountId}`。
3. **端到端隐私安全 (E2EE)**:
   - `pyro_cloud_drive_crypto` 结合 AES-256-CBC 与后台 Isolate，对同步数据进行硬核带校验和加密。
