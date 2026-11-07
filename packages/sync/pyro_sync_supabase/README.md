# pyro_sync_supabase

Supabase 个人同步领域适配器微包（Sync Domain Layer）。
实现个人数据库同步契约，底层依赖最纯粹的基础设施包 `packages/infra/pyro_supabase`。

## ⚙️ 核心功能
* `SupabaseSyncConfigStore`：用户凭证 (Supabase URL, Anon Key, Service Role Key) 的持久化管理。
* `SupabaseSettingsPage`：基于 `package:material_ui/material_ui.dart` 构筑的用户凭证设置与 PostgREST 连通测试 UI 页面。
* `pushChanges` & `pullChanges`：个人增量数据的云端推拉通道。
* 自动向 `SyncHub.instance` 注册 `SyncServiceUIConfig`。
