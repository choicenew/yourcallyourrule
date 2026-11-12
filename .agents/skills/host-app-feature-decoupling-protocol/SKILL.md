---
name: host-app-feature-decoupling-protocol
description: 现代 Dart/Flutter 架构下主 App (lib/features/) 功能模块解耦、微包零横向依赖、AppCoordinator / Connectors 数据交换层中转与自律工程准则。
---

# 主 App 与多包架构解耦交互标准化协议 (Package Architecture & Feature Decoupling Protocol)

本协议是项目最高的工程架构宪章，所有 AI Agent 与开发者必须 100% 严格恪守执行。

---

## 一、 架构分层与零横向依赖铁律

### 1. 业务微包层 (Packages Level) —— 平行解耦
- 所有的底层微包 (`@device`, `@sync`, `@user_database`, `@clouddrive`, `@database`) 处于完全平行的同一层级；
- **零横向依赖铁律**：微包与微包之间绝对禁止发生任何形式的直接 `import` 或硬编码耦合（例如：`@clouddrive` 绝不依赖 `@device` 或 `@sync`，`@database` 绝不依赖 `@clouddrive`）；
- 微包只关心本包内的协议 (Protocol)、中枢 (Hub) 和驱动 (Driver)。

### 2. 主 App 功能模块层 (`lib/features/`) —— 隔离孤岛
- **Feature 零横向依赖铁律**：`lib/features/feature_a/` 绝对禁止直接 `import` `lib/features/feature_b/` 的任何代码；
- 每一个 Feature 都是一个独立的孤岛，它不需要也不应该感知其他 Feature 的存在。

### 3. 主 App 数据交换层 (`AppCoordinator` & `Connectors`) —— 唯一中转站
- **所有跨模块数据交换与事件通知，必须 100% 通过主 App 交换层（`AppCoordinator` / `Connectors`）进行中转与事件派发**；
- 当 Feature 需要广播状态变化时，调用 `ref.read(appCoordinatorProvider).emit('event_name', payload)`；
- 当 Feature 需要监听其他模块状态时，订阅 `ref.read(appCoordinatorProvider).on('event_name', callback)`；
- 主 App 充当唯一的“中枢胶水层 (Mediator / Orchestrator)”，在运行时将 `@sync` 的冲突解决逻辑或 `@device` 的 `DeviceNode` 注入并绑定给相应服务。

---

## 二、 严格工程自律与校验 SOP 铁律

### 1. 严禁未经许可频繁运行 `flutter analyze`
- 在没有将 Log 日志清单中涉及的所有报错文件 100% 彻底修改完成之前，**严禁中途运行任何 `flutter analyze` 命令**；
- 绝不浪费开发者的时间、精力和系统内存。

### 2. 严禁滥用全局 `build_runner`
- 未得到用户明确许可前，**严禁使用全局 `build_runner build`** 扫描全工程几千个文件；
- 只能对确有变更需求的单文件/单目录进行精准局部构建。

### 3. “死代码 (Dead Code)”外科手术拯救原则
- 绝不能一看到编译报错里的 `Dead Code` 就盲目删代码；
- 99% 的 Dead Code 是由于上一轮正则表达式或脚本替换破坏了分号 `;` 或花括号 `}` 导致语法截断造成的；
- 必须做外科手术式的精细语法补全（补齐 `;` 和 `}`），拯救原本正常的业务逻辑。

---

## 三、 特性模块 (`lib/features/sync/`) 重构装配规范

1. **零手写重复 ORM**：删除主 App 中手写重复的本地 ORM 数据源，统一通过 `getEntityStore<T>(ref)` 或直接消费微包 Hub；
2. **零手写重复设备模型**：统一使用 `@device`（`pyro_device_master_slave_protocol`）提供的强类型 `DeviceNode`，严禁在主 App 内自建 `DeviceEntity` 类；
3. **云盘与同步逻辑委派**：`lib/features/sync/` 仅作为包装卡片与 UI 容器，将实际云盘同步全量委托给 `@clouddrive`（`CloudDriveHub.instance`），增量同步委托给 `@sync`（`SyncHub.instance`）。
