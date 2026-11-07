# pyro_sync_koreader

KOReader Kosync 阅读进度开源协议同步适配器微包。

## 💡 核心职责

实现 `SyncDataAdapter` 接口 (`KoReaderSyncAdapter`)，适配 KOReader 社区标准的 Kosync 异步阅读进度与书签同步协议：
- 支持指定 Kosync 服务器 URL、用户名与密钥 (`userKey`)。
- 允许 Pyro 阅读器与 KOReader 墨水屏设备/App 实现进度双向无缝对齐。
