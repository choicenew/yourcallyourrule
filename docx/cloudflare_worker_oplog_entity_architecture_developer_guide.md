# Cloudflare Worker & OpLog 增量同步架构：双端强实体对强实体 (Entity-to-Entity) 开发者指南与技术复盘

本指南全面收录了 Your Call Your Rule 客户端（Flutter/Dart）与边缘计算服务端（Cloudflare Worker / D1 数据库）之间**基于 OpLog（操作日志队列）的分布式离线同步架构**、重构背后的**核心设计思考、踩坑复盘**，以及**双端强实体对强实体 (Entity-to-Entity)** 的生产级落地与运维指南。

---

## 一、 系统设计思考与架构演进复盘

### 1.1 核心痛点与历史债务
在重构前，APP 与 Cloudflare Worker 之间的交互存在严重的数据契约缺失（Schema Drift）：
* **乱象一：写死在逻辑内部的 `Map<String, dynamic>` 裸字符串**。
  Flutter 在生成验证报告（`reportForServer`）和构造同步 Payload 时，使用了大量的裸 `Map`，字段名全凭程序员手写（如 `'simState'`, `'isRoaming'`, `'isNumberMatch'`, `'finalRisk'`）。一旦拼错一个字母，编译器无法发现，导致云端数据默默失效。
* **乱象二：大小驼峰与下划线的命名撕裂**。
  Flutter ViewModel 使用小驼峰（`camelCase`），Cloudflare D1 数据库使用下划线（`snake_case`），中间由于缺少强类型契约，裸 JS 脚本到处进行手写转换，数据链路极其脆弱。

### 1.2 重构过程中的错误方向与踩坑复盘
在探索强类型化过程中，曾经走过两个致命的误区，在此予以深刻复盘：

* **❌ 踩坑一：盲目试图引入 RESTful / OpenAPI 点对点 API 替换同步网关**
  * **错误尝试**：设想用 OpenAPI 自动生成 `POST /api/v1/proposals/deletions` 这样的传统 REST CRUD 接口。
  * **致命后果**：彻底架空了 APP 的 `pending_operations` 离线队列和 `IncrementalSyncManager` 同步调度器。一旦用户断网，请求立刻失败；且 OpenAPI 生成器对 `POST /sync` 里面混杂着 `INSERT`、`UPDATE`、`PROPOSE_DELETION`、`VOTE_DELETION` 的多态联合数组（Union Payload）支持极其糟糕，会产出大量难以维护的胶水代码。
* **❌ 踩坑二：试图直接将 Drift 数据库生成类作为领域实体**
  * **错误尝试**：试图让 Flutter 端的领域层（Domain Layer）直接使用 Drift 自动生成的 `ActiveDeletionProposalData` 类。
  * **致命后果**：Drift 的生成类面向 SQLite 数据行，与 Freezed 生成的强实体对象存在类型断层（例如 SQLite 只能存 `String`，而领域模型需要 `ProposalStatus` 枚举）。两者分属不同的代码生成器，无法直接强行合并。

### 1.3 最终生产级解法：OpLog 队列 + 双端强实体 (Entity-to-Entity)
* **原则**：**绝对不动 `pending_operations` 离线队列，绝对不动 `POST /sync` 批处理网络接口**。
* **Flutter 端**：使用 Freezed 密封联合类 (`SyncPayload`) 封装多态操作；通过 `Extension` 扩展方法实现 Drift 生成类与领域实体的零损耗转换。
* **Worker 端**：升级为 TypeScript (`worker.ts`)，在入口处使用 `Zod` 的判别式联合类型 (`z.discriminatedUnion`) 做硬网关校验，非法 JSON 直接抛出 400 拒绝，彻底阻断脏数据污染 D1 数据库。

---

## 二、 4 大核心业务链路数据流图 (Data Pipeline Architecture)

整个系统中，Flutter APP 与 Cloudflare Worker 之间的所有交互精准收敛为以下 4 大业务链路：

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        Flutter ↔ Cloudflare Worker 4 大核心业务链路                    │
├────────────────────────────────────────────────────────────────────────────────────────┤
│ 链路 1：离线增量同步 (Sync Pipeline)     ➔ POST /sync (推送待办) & GET /sync (拉取增量)    │
│ 链路 2：国家离线数据包 (Country Dataset) ➔ GET /country-data?countryCode=CN            │
│ 链路 3：提议规则限制配置 (Proposal Limits)➔ GET /api/v1/config/proposal-limits         │
│ 链路 4：设备验证报告管理 (Verification)  ➔ GET/POST /api/verification-reports          │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

### 链路 1：离线增量同步管线 (`POST /sync` & `GET /sync`)
```
[UI / Service]
   │ 1. 提议删除 ➔ 创建强实体 ServerVerificationReport
   ▼
[ProposalDataSourceImpl]
   │ 2. 包装为强实体 SyncPayload.proposeDeletion(report: report)
   │ 3. 序列化为 JSON 写入 Drift 表: pending_operations
   ▼
[IncrementalSyncManager]
   │ 4. 离线队列打包 ➔ ApiService.pushChanges() ➔ POST /sync
   ▼
[Cloudflare Worker (TypeScript + Zod)]
   │ 5. Zod 网关硬校验: PushRequestSchema.safeParse(json) ➔ 不符合抛 400
   │ 6. Discriminated Union 解包 ➔ 自动推导为 ProposeDeletionOperation
   │ 7. env.DB.batch() 写入 D1 数据库 (op_log & deletion_proposals & verification_reports)
   ▼
[拉取增量: GET /sync]
   │ 8. Worker 从 op_log 导出包含聚合标签 (labels_json) 的增量变更
   │ 9. APP 收到后通过 SyncPayload.fromJson 解包 ➔ 写入本地 Drift ➔ UI 自动重绘
```

### 链路 2：国家离线数据包管线 (`GET /country-data`)
```
[CountrySelectionWidget] ➔ 用户勾选国家 (如 CN / US)
   │
   ▼
[CountryDataService] ➔ ApiService.getInitialDataForCountry('CN')
   │
   ▼
[Cloudflare Worker] ➔ GET /country-data?countryCode=CN
   │ 联表查询: SELECT r.* FROM remote_numbers r INNER JOIN number_countries nc...
   ▼
[Flutter 本地落盘] ➔ RemoteNumberDataSource.bulkInsertFromServer() 写入本地 Drift SQLite
```

### 链路 3：系统规则配额配置管线 (`GET /api/v1/config/proposal-limits`)
```
[APP 启动 / 提议前] ➔ ProposalLimitConfigService.syncConfig()
   │
   ▼
[Cloudflare Worker] ➔ GET /api/v1/config/proposal-limits
   │ 从 app_config 表拉取 proposal_limit_standard_user_limit (5), proposal_limit_vip_user_limit (20) 等
   ▼
[本地持久化] ➔ 写入 config_repository ➔ 动态覆盖本地硬编码默认值
```

### 链路 4：设备安全报告管理管线 (`GET/POST /api/verification-reports`)
```
[设备环境评估] ➔ analyzeProfile(VerificationInput) ➔ 输出 ServerVerificationReport
   │
   ▼
[云端归档] ➔ POST /api/verification-reports 存入 D1 verification_reports 表供审计
```

---

## 三、 数据一致性与“防脱层防断层”四重屏障

为了保证跨网络的 JSON 数据绝不断层，以及本地 Drift 数据库与云端 D1 数据库绝不脱层，架构中建立了 4 重硬核屏障：

### 屏障 1：Zod 强类型硬网关 (Schema Validation Guard)
* **原理**：在 Cloudflare Worker 入口处使用 `PushRequestSchema.safeParse(json)`。
* **效果**：如果 Flutter 发送的 JSON 缺少必填字段（如缺失 `finalRisk`）、Key 拼错或类型不符，Zod 网关**瞬间拒绝执行并返回 400 Bad Request**，打印定位错误 `operations.0.payload.report.finalRisk: Required`。**脏数据 100% 阻断在 D1 数据库之外**。

### 屏障 2：两阶段提交与原子回滚 (2-Phase Atomic Rollback)
* **推阶段 (Push)**：本地从 `pending_operations` 提取数据发给 Worker。Worker 采用 D1 `env.DB.batch()` 批处理事务。如果中途网络断连，Worker 事务自动回滚，客户端**不删除** `pending_operations`，下一次联网自动续发，数据 0 丢失。
* **拉阶段 (Pull)**：客户端从 Worker 拉取增量变更后，开启本地 Drift 事务写入 SQLite 并更新本地 `last_sync_seq_id`。若中途崩溃，本地事务自动回滚，下一次同步重新拉取同一批变更（**操作幂等性确保重复应用不损坏状态**）。

### 屏障 3：位点序列表与增量精准追踪 (`seq_id` / `since`)
* 云端 `op_log` 维护严格单调递增的自增序号或高精度时间戳。
* 本地只记录上一次同步成功的位点 `last_sync_seq_id`，带上 `since = last_sync_seq_id` 发起增量拉取，保证不漏报、不重报。

### 屏障 4：多标签众包权重合并与状态最终一致性 (Idempotent Consensus)
* 当多个设备对同一号码标记不同标签（如设备 A 标 `'推销'`，设备 B 标 `'客服'`，设备 C 标 `'推销'`）：
  - Worker 在内存和 D1 事务中归集 `labels_json = {"推销": 2, "客服": 1}`；
  - 自动算出票数最高者 `'推销'` 胜出并写入 `remote_numbers.label`；
  - 最终状态由规则确定性推导，多设备并发提交后数据库状态**100% 严格收敛一致**。

---

## 四、 项目文件地图 (Project File Map)

| 模块 | 文件路径 | 职责 |
| :--- | :--- | :--- |
| **Dart 验证报告** | `lib/features/deletion_proposer/models/server_verification_report.dart` | 强实体类，封装设备安全评估结果 |
| **Dart 多态 Payload**| `lib/features/deletion_proposal/domain/models/sync_payload.dart` | 强实体密封联合类，封装离线队列多态载荷 |
| **Dart 同步操作枚举**| `lib/data/models/sync/sync_operation_type.dart` | 强类型 Enum (`insert`, `update`, `proposeDeletion` 等) |
| **Dart 投票类型枚举**| `lib/features/deletion_proposal/domain/vote_type.dart` | 强类型 Enum (`agreeDelete`, `disagreeDelete`) |
| **Dart 数据源实现** | `lib/features/deletion_proposal/data/proposal_datasource_impl.dart` | 消除所有手写 Map 字面量，使用强实体与 Extension 桥接 |
| **Worker Zod Schema**| `test_worker/src/schema.ts` | 声明 TypeScript 强实体与 `z.discriminatedUnion` |
| **Worker TS 路由** | `test_worker/src/index.ts` | TypeScript Worker 网关与 D1 批处理事务 |
| **Worker 配置文件** | `test_worker/wrangler.json` | Wrangler CLI 配置文件（绑定 D1 与 Secrets） |
| **Worker 依赖配置** | `test_worker/package.json` | Node 项目配置（包含 `zod` 与 `typescript`） |
| **网页端打包产物** | `test_worker/_worker.bundle.js` | 利用 `esbuild` 编译的单文件 JS，供网页控制台直接贴入 |
| **单元测试套件** | `test/unit/strong_type_sync_payload_unit_test.dart` | 45 项全通过的 Dart 强实体序列化/离线队列测试 |
| **在线 E2E 联调** | `test/integration/live_cloudflare_worker_test.dart` | 针对 Cloudflare Worker 的在线真实 HTTP 联调与 400 拦截测试 |

---

## 五、 运维与部署操作手册 (SOP)

### 5.1 生产环境网页端（无 API Token 时）手动部署 SOP
如果您在生产账户中无法使用 Wrangler CLI 命令部署，可按以下 3 步在网页控制台完成上线：

1. **本地编译单文件 bundle (`_worker.bundle.js`)**：
   在终端进入 `test_worker` 目录运行：
   ```bash
   cd test_worker
   npx esbuild src/index.ts --bundle --outfile=_worker.bundle.js --format=esm --target=es2022
   ```
2. **复制打包产物**：
   用编辑器打开生成的 `test_worker/_worker.bundle.js` 文件，全选并复制全部内容。
3. **网页控制台贴入上线**：
   - 登录 Cloudflare Dashboard ➔ 进入您的生产 Worker ➔ 点击 **Edit Code**；
   - 清空编辑器原代码，粘贴刚才复制的 `_worker.bundle.js` 内容；
   - 点击右上角 **Save and Deploy** 按钮，10 秒内即刻生效。

### 5.2 开发/测试环境命令行 (`Wrangler CLI`) 自动部署 SOP
当在具有 API Token 的测试环境中：
```bash
# 1. 配置临时环境变量 (包含在 .gitignore 中，绝不提交 git)
set PATH=D:\VSCode-win32-x64-1.88.0\node-v24.16.0-win-x64;%PATH%
set CLOUDFLARE_API_TOKEN=<YOUR_CLOUDFLARE_API_TOKEN>
set CLOUDFLARE_ACCOUNT_ID=<YOUR_CLOUDFLARE_ACCOUNT_ID>

# 2. 一键自动部署上云
cd test_worker
npx wrangler deploy
```

### 5.3 自动化测试验证 SOP
在提交任何代码前，必须依次跑通以下命令：
```bash
# 1. 运行 Flutter 强实体与离线队列单元测试
D:\VSCode-win32-x64-1.88.0\flutter_windows_3.47.1-stable\flutter\bin\flutter.bat test test/unit/strong_type_sync_payload_unit_test.dart

# 2. 运行真实在线 Cloudflare Worker HTTP 端到端联调测试
D:\VSCode-win32-x64-1.88.0\flutter_windows_3.47.1-stable\flutter\bin\cache\dart-sdk\bin\dart.exe run test/integration/live_cloudflare_worker_test.dart
```
当测试输出 `All tests passed!` 并且 E2E 拦截断言成功后，方可进行生产上线。
