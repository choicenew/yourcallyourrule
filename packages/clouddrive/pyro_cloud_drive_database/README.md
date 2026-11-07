# pyro_cloud_drive_database

云端增量同步、版本快照、影子账户同步与冲突解决引擎包。

## 💡 核心职责

1. **增量同步管理 (`IncrementalSyncManager`)**:
   - 自动配合 `SyncHub` 实现按业务模块（如藏书、笔记、设置）的 MD5 摘要比对与增量 JSON 导出/导入/同步。支持影子账户动态隔离路径 `/{appName}/{accountId}`。
2. **三方冲突解决器 (`SyncConflictResolver`)**:
   - 针对本地数据与云端远端数据的更新冲突，基于时间戳与版本号执行无损双向合并算法。
3. **备份与设备管理服务 (`BackupRestoreService`, `DeviceManagementService`)**:
   - 维护多设备节点与云端全局备份快照版本 (`BackupVersionEntity`)。
