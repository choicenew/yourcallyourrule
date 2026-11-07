# Pyro Sync 跨端同步与众包数据仲裁微包矩阵 (`packages/sync`)

`packages/sync` 是 Pyro 架构中负责**多端阅读进度、标记/笔记、三方同步协议 (Kosync/Suwayomi/Supabase/Cloudflare/Syncitron) 与众包投票仲裁**的云同步微包矩阵。

---

## 📁 目录与微包矩阵 (Package Matrix)

`packages/sync` 包含 9 个彻底解耦的专用 Package：

```text
packages/sync/
├── pyro_sync_protocol/            # [1] 纯抽象同步协议包 (SyncDataAdapter 接口与 JSON 映射)
├── pyro_sync_hub/                 # [2] 同步服务定位与注册中心 (SyncHub 单例)
├── pyro_sync_database/            # [3] 本地数据库变更监听与云端数据增量同步管理
├── pyro_sync_koreader/            # [4] KOReader (Kosync) 墨水屏阅读进度同步适配器
├── pyro_sync_suwayomi/            # [5] Suwayomi / Tachidesk 漫画服务器同步适配器
├── pyro_sync_supabase/            # [6] Supabase 云端 PostgreSQL + Realtime 实时长连接同步
├── pyro_sync_cloudflare/          # [7] Cloudflare Workers + D1 轻量化 Serverless 同步
├── pyro_sync_syncitron/           # [8] Syncitron 端到端离线状态离散转移记录同步
└── pyro_crowdsourcing_arbiter/    # [9] 众包源修正、用户投票与真值仲裁 DAO 引擎
```
