# pyro_supabase

纯粹的最底层 Supabase 物理基础设施 Client SDK（物理基础设施层 Layer 1）。
零上层业务、零 Sync 概念、零杂质。

## 📦 包含模块

* `SupabaseConfig`：Supabase 基础凭证与 JWT Authorization Header 构建器。
* `SupabaseDatabaseClient`：PostgreSQL PostgREST API 底层 SELECT、INSERT、UPSERT 与 RPC 存储过程调用。
* `SupabaseStorageClient`：Storage 储物桶纯文件流上传 (`upload`)、下载 (`download`) 与批量删除 (`remove`)。
* `SupabaseRealtimeClient`：WebSocket 实时长连接频道 URI 构建器。
