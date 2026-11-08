# pyro_cloudflare

纯粹的最底层 Cloudflare 物理基础设施 Client SDK（物理基础设施层 Layer 1）。
零上层业务、零 Sync 概念、零杂质。

## 📦 包含模块

* `CloudflareConfig`：Cloudflare Worker/API 统一凭证与 Header 构建器。
* `CloudflareD1Client`：D1 关系型数据库底层 REST API，支持单条 `query` 与事务批处理 `batch`。
* `CloudflareR2Client`：R2 对象存储纯文件字节流 `putObject`、`getObject` 与 `deleteObject`。
* `CloudflareKVClient`：KV 极速键值存储 `get` / `put` / `delete`。
* `CloudflareWorkerClient`：支持发向任意自定义 Worker 路由的 `get` / `post` 交互底座。
