# pyro_database

泛化大一统媒体本地 Isar 数据库与 CRUD 数据源引擎包。

## 💡 核心职责

1. **`IsarMediaDatasource`**: 跨模态本地数据库 CRUD 操作引擎。
2. **多模态全属性检索 (`searchMedia`)**: 支持针对音乐、图书、漫画、小说、视频、论文等多媒介全属性（标题、作者/歌手、标签、专辑）的高性能模糊匹配。
3. **媒体 Schema**: 定义大一统媒体模型与书架数据结构 (`IsarMediaObject`, `IsarBookSchema`)。
