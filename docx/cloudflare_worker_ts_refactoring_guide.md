# Cloudflare Worker 升级 TypeScript + Zod 强实体架构重构复盘与部署指南

本指南详细记载了 Flutter 客户端与 Cloudflare Worker 之间实现 **双端强实体对强实体 (Entity-to-Entity)** 架构的全套开发逻辑、踩坑复盘、正确实施步骤，以及针对**生产环境网页端**的手动部署流程。

---

## 一、 本次开发逻辑与踩坑复盘

### 1. 核心业务与痛点分析
* **业务模型**：我们的系统不是普通的 CRUD 点对点 API，而是一个基于 **分布式操作日志 (Operation Log, OpLog)** 的增量同步架构。Flutter 端离线产生操作（`INSERT`、`UPDATE`、`PROPOSE_DELETION`），存储在本地 Drift 数据库的 `pending_operations` 表中，随后通过 `POST /sync` 批量发送给 Worker，再由 Worker 在 D1 数据库中进行原子计算与聚合（例如多标签众包投票）。
* **核心痛点**：过去的代码在拼装、发送和接收 JSON 数据时，**完全依赖手写 `Map` 和硬编码字符串**（如 `'PROPOSE_DELETION'`、`payload.report.finalRisk`）。这导致极易出现拼写错误，且一旦两端字段名不一致（如 Dart 的驼峰与 D1 的下划线混用），整个同步链路就会静默断层。

### 2. 踩坑与错误方向复盘
* **❌ 错误方向一：盲目使用 OpenAPI / TypeSpec 替换 API**
  * **踩坑过程**：最初设想通过 OpenAPI 自动生成点对点接口代码（如 `api.proposeDeletion(request)`）。
  * **致命缺陷**：这直接**架空了 `pending_operations` 离线队列和增量同步器 `IncrementalSyncManager`**。由于 OpenAPI 对“多态数组（Polymorphic Array）”支持极差，无法处理 `POST /sync` 中混杂着多种 `operation` 和 `payload` 的复杂同步包，会导致离线优先架构全线崩溃。
* **❌ 错误方向二：试图全自动映射 Drift 本地数据到实体**
  * **踩坑过程**：尝试直接用生成的实体类读写本地 Drift 数据库。
  * **致命缺陷**：Drift 的生成类（如 `ActiveDeletionProposalData`）与 Freezed 强实体生成类分属不同体系，不能直接连通，导致编译报错。
  * **正确解法**：通过 `Extension` 扩展方法，将 Drift 的原生行数据安全桥接到领域实体（Domain Entity）上。

### 3. 最终正确方案：基于 Zod 与密封类的强类型解析
1. **Flutter 端**：不改动 `pending_operations` 队列与网络层，使用 Freezed 的 `Union Class` 封装多态 `SyncPayload`，确保入库和序列化时的类型安全。
2. **Worker 端**：引入 TypeScript 与 Zod。在入口处使用 `z.discriminatedUnion`（判别式联合类型）对发来的 JSON 进行强制解包。如果不符合强实体结构，直接抛出 `400 Bad Request`，从而将脏数据拦截在 D1 数据库之外。

---

## 二、 生产环境纯网页端部署操作步骤

由于您无法提供生产账户的 API Token，无法使用 Wrangler 命令行自动部署。但**完全可以在 Cloudflare 网页端全手动替换并上线**。

请严格按照以下步骤操作：

### 1. 准备前提
* 由于 Cloudflare 网页编辑器只支持运行打包后的单文件纯 JS（无法直接贴入 `.ts` 和多文件项目），您必须在本地将刚刚编写的 TypeScript + Zod 代码**打包成一个兼容的纯 JavaScript 文件 (`_worker.bundle.js`)**。

### 2. 本地执行打包 (生成 `_worker.bundle.js`)
在终端中进入您刚才的 `test_worker` 目录，执行打包命令：

```bash
cd test_worker
npx esbuild src/index.ts --bundle --outfile=_worker.bundle.js --format=esm --target=es2022
```

执行完毕后，您会在 `test_worker` 目录下得到一个名为 **`_worker.bundle.js`** 的文件。这个文件内联了所有相关的 TypeScript 代码、Zod 校验库及其依赖。

### 3. 网页端替换与部署
1. 登录您的 Cloudflare 控制台 (https://dash.cloudflare.com)。
2. 在左侧菜单栏选择 **"Workers & Pages"**，点击您现有的生产 Worker（假设叫 `yourcallyourrule-worker`）。
3. 点击右上角的 **"Edit Code" (编辑代码)** 按钮进入网页版代码编辑器。
4. 在左侧文件树中选中 `worker.js` (或者 `index.js`，即您的入口文件)。
5. **清空**右侧代码编辑区里的所有旧代码。
6. 使用文本编辑器（如 VS Code 或记事本）打开您在第二步中生成的 **`_worker.bundle.js`** 文件，**全选并复制**里面的所有代码。
7. 将代码**粘贴**到 Cloudflare 网页编辑器中。
8. 确保页面右侧的环境变量/D1 绑定（Bindings）不变。
9. 点击编辑器右上角的 **"Save and Deploy" (保存并部署)**。

### 4. 验证部署
上线后，您可以在浏览器或通过手机 App 触发任意一次同步请求。您应该可以在 Cloudflare 网页的 "Logs" (日志) 面板中看到类似 `"message": "Operations processed via Zod TypeScript Worker."` 的成功日志输出，即代表新版强实体网关在生产环境部署成功并生效。
