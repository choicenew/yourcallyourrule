# pyro_metadata_service

媒体元数据自动化刮削、智能比对与字段合并调度引擎包。

## 💡 核心职责

1. **元数据自动化调度器 (`MetadataOrchestrator`)**: 自动扫描待补全条目，匹配插件，执行外网 API 搜刮（如 OpenLibrary）。
2. **智能比对与置信度打分 (`MetadataMatcher`)**: 基于书名、作者、年份与 ISBN/DOI 进行综合置信度评分，避免误匹配。
3. **元数据清洗与无损合并**: 配合 `pyro_worker_protocol` 在后台 Isolate 副线程中清洗数据 (`MetadataCleanerTask`) 并与本地原元数据合并 (`MetadataMerger`)。
