# pyro_cloud_drive_hetu

河图 (Hetu Script) 动态云盘绑定微包。

## 💡 核心职责

将 `CloudDriveHub` 云盘操作导出为 Hetu 动态脚本绑定 (`CloudDriveBinding`)：
- 在 Hetu 脚本 (`cloud_drive.ht`) 中暴露云盘文件的读取、写入、同步与连接状态检查。
- 允许外部插件或热更新脚本通过 Hetu Script 操纵云盘。
