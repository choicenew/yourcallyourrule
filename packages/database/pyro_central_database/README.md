# pyro_central_database

系统中央数据库真实物理驱动包（Driver Layer）。
实现 `CentralDatabaseAdapter`，直接调用最底层物理 SDK `packages/infra/pyro_cloudflare` (D1) 或 `packages/infra/pyro_supabase` (Postgres)，负责系统公共规则、配置与公告数据的同步与发布。
绝对剥离 `sync` 概念。
