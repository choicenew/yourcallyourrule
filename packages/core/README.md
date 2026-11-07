# Pyro Core 通用基础设施微包矩阵 (`packages/core`)

`packages/core` 是 Pyro 架构中的**通用核心基础设施**领域矩阵，提供从 Isolate 副线程调度、数据库 CRUD、源提取协议、翻译调度、TTS 朗读、元数据刮削到 Cloudflare 过白等底层基础能力。

---

## 📁 目录与微包矩阵 (Package Matrix)

`packages/core` 包含 10 个彻底物理解耦的专用 Package：

```text
packages/core/
├── pyro_worker_protocol/        # [1] 多线程 Isolate Worker 线程池与并发任务调度中枢
├── pyro_database/               # [2] 泛化大一统媒体 Isar 本地数据库与 CRUD 引擎
├── pyro_fetch_protocol/         # [3] 源提取与源执行器抽象协议 (含 WiFi 传书服务器)
├── pyro_api_translate/          # [4] API 机器翻译调度器 (集成 20+ 翻译 API 与熔断重试)
├── pyro_atmosphere/             # [5] 动态阅读氛围感主题与音效服务
├── pyro_hetu_script_engine/     # [6] 河图 (Hetu Script) 动态脚本运行时引擎与 Bindings
├── pyro_cloudflare_proxy/       # [7] Cloudflare 5秒盾过白 Cookie 缓存与 HTTP 代理客户端
├── pyro_metadata_service/       # [8] 图书与媒体元数据自动化刮削、匹配与清洗中枢
├── pyro_tts/                    # [9] 系统原生与 Azure 神经网络 TTS 语音朗读调度器
└── pyro_wasm_cc/                # [10] 繁简中文无损转换引擎
```
