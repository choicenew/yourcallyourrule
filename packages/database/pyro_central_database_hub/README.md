# pyro_central_database_hub

系统中央数据库运行时注册与调度中枢（Hub Layer）。
维护单例 `CentralDatabaseHub.instance`，管理 CentralDatabaseAdapter 的运行时注册与路由调度。
绝对禁止使用 `sync` 前缀。
