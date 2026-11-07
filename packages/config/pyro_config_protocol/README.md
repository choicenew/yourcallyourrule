# 📜 PyroConfigProtocol - Pure Config Repository & Backup Contract Package

`pyro_config_protocol` 是基于 **Protocol-Hub-Driver 三层单向解耦规范** 打造的纯抽象配置仓库与快照负载契约微包。

零具体存储依赖（无 `shared_preferences`，无 `path_provider`），作为上层业务微包（`pyro_theme`、`pyro_l10n`）与底层存储引擎（`pyro_config_local`）、云端加密传输（`clouddrive`）之间的隔离标准。

---

## 🌟 核心接口与契约

1. **`ConfigRepository`**：纯抽象配置存储仓库接口 (`getConfig`, `saveConfig`, `removeConfig`, `getAllKeys`)。
2. **`ConfigBackupPayload`**：纯抽象解耦快照数据契约 (`toMap`, `fromMap`)。
