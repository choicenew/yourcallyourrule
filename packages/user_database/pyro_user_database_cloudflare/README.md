# pyro_sync_cloudflare

Cloudflare 个人同步领域适配器微包（Sync Domain Layer）。
实现 `SyncDataAdapter<Map<String, dynamic>>` 抽象接口，底层依赖最纯粹的基础设施包 `packages/infra/pyro_cloudflare`。

## ⚙️ 核心功能
* `CloudflareSyncConfigStore`：用户凭证 (Worker URL, API Key, Device ID) 的持久化管理。
* `CloudflareSettingsWidget`：基于 `package:material_ui/material_ui.dart` 构筑的用户凭证设置与网络测试 UI 卡片。
* `pushOperations` & `pullLatest`：个人增量数据的云端推拉通道。
* 自动向 `SyncHub.instance` 注册 `SyncServiceUIConfig`。
