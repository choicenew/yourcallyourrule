---
name: oplog-cloudflare-entity-sync
description: 离线优先分布式 OpLog 同步引擎与 Cloudflare Worker 双端强实体对强实体 (Entity-to-Entity) 开发规范。涵盖 Dart 密封联合类、Drift 本地队列桥接、TypeScript+Zod 判别式联合网关拦截、esbuild 网页部署打包及完整网络联调测试 SOP。
---

# 离线优先 OpLog 同步引擎与 Cloudflare Worker 双端强实体开发规范 (Entity-to-Entity Sync Standard)

本指南规范了 Your Call Your Rule 客户端与 Cloudflare Worker / D1 数据库之间基于 **OpLog（操作日志队列）** 的分布式离线增量同步架构及其**双端强实体对强实体 (Entity-to-Entity)** 开发标准。

---

## 1. 核心架构与铁律规范 (Core Principles & Strict Rules)

### 1.1 架构核心模式
* **离线优先 (Offline-First)**：所有写操作必须先序列化为强实体，写入本地 Drift SQLite 的 `pending_operations` 队列表中，绝不直接阻塞等待网络点对点 API。
* **批量异步批处理网关**：网络层固定通过 `POST /sync` 发送批处理操作数组 (`operations`)，保留统一的操作包壳：`OperationEnvelope = { id, entityId, operation, payload, timestamp }`。
* **双端强实体对齐 (Entity-to-Entity)**：
  - **Flutter 端**：禁绝手写 `Map<String, dynamic>`，100% 使用 Freezed 生成的 `Union Class` 密封类（`SyncPayload`）。
  - **Worker 端**：禁绝裸 JS 对象属性读取（如 `payload.report.finalRisk`），100% 使用 TypeScript 与 Zod 的 `z.discriminatedUnion` 判别式联合类型做网关校验。

### 1.2 铁律禁忌 (Strict Prohibitions)
1. **严禁架空离线队列**：严禁把逻辑修改为普通 RESTful 点对点 API，破坏 `pending_operations` 和 `IncrementalSyncManager`。
2. **严禁手写魔术字符串**：所有的操作名称 (`'PROPOSE_DELETION'`, `'VOTE_DELETION'`, `'INSERT'`, `'UPDATE'`) 必须统一收敛为强类型 Enum（`SyncOperationType`）。
3. **严禁脏数据入库**：Worker 端必须在网关层使用 Zod `safeParse`，遇到字段缺失或类型错误直接抛出 400 拒绝，绝对不允许未校验数据写进 Cloudflare D1 数据库。

---

## 2. Flutter (Dart) 端强实体规范

### 2.1 强实体 Payload 密封联合类范式 (`SyncPayload`)

所有通过网络和本地队列流转的操作载荷，必须定义为 Freezed 密封联合类：

```dart
// lib/features/deletion_proposal/domain/models/sync_payload.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposer/models/server_verification_report.dart';

part 'sync_payload.freezed.dart';
part 'sync_payload.g.dart';

@freezed
sealed class SyncPayload with _$SyncPayload {
  const factory SyncPayload.numberUpdate({
    required String phoneNumber,
    required String label,
    required int action,
    int? count,
    String? countryIsoCode,
  }) = NumberUpdatePayload;

  const factory SyncPayload.proposeDeletion({
    required ServerVerificationReport report,
    required String timestamp,
  }) = ProposeDeletionPayload;

  const factory SyncPayload.voteDeletion({
    required String voteType,
    Map<String, dynamic>? additionalData,
    required String timestamp,
  }) = VoteDeletionPayload;

  factory SyncPayload.fromJson(Map<String, dynamic> json) => _$SyncPayloadFromJson(json);
}
```

### 2.2 Drift 本地数据库与领域实体的 Extension 桥接规范

为了消除数据源层（`ProposalDataSourceImpl`）手写 Map 字面量，使用 Extension 桥接 Drift 生成的 `Data` 类与领域模型：

```dart
// 1. 将 Drift 自动生成的 ActiveDeletionProposalData 转为领域实体 Proposal
extension ActiveDeletionProposalDataX on ActiveDeletionProposalData {
  Proposal toDomainProposal() {
    return Proposal(
      phoneNumber: phoneNumber,
      proposalStartTime: DateTime.parse(proposalStartTime),
      status: ProposalStatus.fromString(status),
      highestRiskLevel: RiskLevel.fromString(highestRiskLevel),
      proposalCount: proposalCount,
      verifiedOwnerCount: verifiedOwnerCount,
      lastUpdated: DateTime.parse(lastUpdated),
      verificationReportJson: verificationReportJson,
      labelsJson: null,
    );
  }
}

// 2. 将 Drift 自动生成的 PendingOperationData 转为传输 Map
extension PendingOperationDataX on PendingOperationData {
  Map<String, dynamic> toOperationMap() {
    return {
      'id': id,
      'entityId': entityId,
      'operation': operation,
      'payload': payload != null ? jsonDecode(payload!) : null,
      'timestamp': timestamp,
    };
  }
}
```

---

## 3. Cloudflare Worker (TS) 端强实体网关规范

### 3.1 Zod 判别式联合类型定义 (`schema.ts`)

```typescript
import { z } from 'zod';

export const ServerVerificationReportSchema = z.object({
  simState: z.string(),
  finalRisk: z.enum(['Verified', 'Low', 'Medium', 'High']),
  deviceId: z.string().optional(),
  isRoaming: z.boolean().default(false),
  simCountry: z.string().nullable().optional(),
  ipCountry: z.string().nullable().optional(),
  isNumberMatch: z.boolean().default(false),
  riskScore: z.number().optional(),
});

export const SyncOperationSchema = z.discriminatedUnion('operation', [
  z.object({
    id: z.string(),
    entityId: z.string(),
    operation: z.literal('INSERT'),
    payload: z.object({
      phoneNumber: z.string(),
      label: z.string().optional(),
      priority: z.number().default(0),
      action: z.union([z.number(), z.string()]).default(1),
    }),
    timestamp: z.string(),
  }),
  z.object({
    id: z.string(),
    entityId: z.string(),
    operation: z.literal('PROPOSE_DELETION'),
    payload: z.object({
      report: ServerVerificationReportSchema,
      timestamp: z.string(),
    }),
    timestamp: z.string(),
  }),
  // ... 其他操作枚举变体
]);

export const PushRequestSchema = z.object({
  operations: z.array(SyncOperationSchema),
  sourceDeviceId: z.string(),
});
```

### 3.2 Worker 强类型网关处理范式 (`index.ts`)

```typescript
async function handlePush(request: Request, env: Env): Promise<Response> {
  const rawJson = await request.json();

  // 1. 硬网关校验：若解析失败直接抛出 400，脏数据绝不进库
  const parseResult = PushRequestSchema.safeParse(rawJson);
  if (!parseResult.success) {
    return jsonResponse({
      error: 'Schema Mismatch',
      details: parseResult.error.format()
    }, 400);
  }

  const { operations, sourceDeviceId } = parseResult.data;
  const dbStmts: D1PreparedStatement[] = [];

  for (const op of operations) {
    // 2. TypeScript 判别式联合类型自动分发 (100% 静态类型安全)
    if (op.operation === 'PROPOSE_DELETION') {
      const report = op.payload.report; // 强类型对象，包含 report.finalRisk, report.isNumberMatch
      dbStmts.push(
        env.DB.prepare('INSERT INTO verification_reports (phone_number, report_data, uploaded_at, device_id) VALUES (?, ?, ?, ?)')
          .bind(op.entityId, JSON.stringify(report), op.timestamp, sourceDeviceId)
      );
    }
  }

  if (dbStmts.length > 0) {
    await env.DB.batch(dbStmts);
  }
  return jsonResponse({ success: true, message: 'Operations processed via Zod TypeScript Worker.' });
}
```

---

## 4. 打包部署与测试 SOP

### 4.1 网页控制台单文件打包 SOP (`esbuild`)
对于没有配置环境 API Token 的生产账号，通过 `esbuild` 将 TypeScript + Zod 代码打包成一个独立的纯 JS 文件，便于在 Cloudflare 网页编辑器中一键贴入部署：

```bash
cd test_worker
npx esbuild src/index.ts --bundle --outfile=_worker.bundle.js --format=esm --target=es2022
```
打包后直接复制 `_worker.bundle.js` 内的完整代码，粘贴至 Cloudflare 网页控制台（`Workers & Pages` ➔ `Edit Code`）并点击 **Save and Deploy**。

### 4.2 Wrangler CLI 一键命令行部署 SOP
在配置了 `CLOUDFLARE_API_TOKEN` 和 `CLOUDFLARE_ACCOUNT_ID` 的开发环境中：
```bash
set PATH=D:\VSCode-win32-x64-1.88.0\node-v24.16.0-win-x64;%PATH%
set CLOUDFLARE_API_TOKEN=your_api_token
set CLOUDFLARE_ACCOUNT_ID=your_account_id
cd test_worker
npx wrangler deploy
```

### 4.3 三层验证 SOP (Testing SOP)
1. **第一层：Dart 往返双向测试 (`flutter test`)**
   运行 `flutter test test/unit/strong_type_sync_payload_unit_test.dart`，验证强实体在 Flutter 对象 ➔ JSON ➔ Drift 数据库之间 100% 无损还原。
2. **第二层：网络线上 HTTP 联调测试 (`dart run`)**
   运行 `dart run test/integration/live_cloudflare_worker_test.dart`，发送合法 `PROPOSE_DELETION` 和 `INSERT` 报文，断言响应为 `200 OK` 且返回 `{"success": true}`。
3. **第三层：网关防御拦截测试**
   故意发送缺失必填字段（如缺失 `finalRisk`）的非法 JSON，断言 Worker 抛出 `400 Bad Request` 并显示结构定位 `Required`。
