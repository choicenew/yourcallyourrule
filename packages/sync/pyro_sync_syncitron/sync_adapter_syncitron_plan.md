# Sync Adapter Syncitron 架构与执行计划

## 一、 包的定位与职责

`sync_adapter_syncitron` 是一个专门为 `syncitron` 引擎打造的**底层适配器包**。
它的唯一使命是：**充当“0 感知业务流”与“重型同步引擎”之间的物理隔离墙和翻译官。**
这个包完全独立，它将被 `pyro_sync_database` 引入作为幕后干脏活的引擎。

## 二、 核心架构：基于 Isar 的自清理过渡区 (Transition Zone)

因为 `syncitron` 强依赖本地数据库必须存在 `is_synced`、`op_id` 等同步元数据字段，而我们绝对不能污染业务包（如 `pyro_behavior_analytics`）的纯净数据库，所以本包的核心逻辑是建立一个微型的**过渡区数据库**。

### 1. 统一技术栈：Isar 引擎
为与应用生态保持一致，本包内部将使用 `isar_community` 来构建过渡区数据库，坚决不引入 SQLite 或 Hive 等多余依赖。

### 2. 构建 `ProtocolLocalStore implements LocalStore`
这是连接 `syncitron` 的核心类。
- **元数据专属存储**：它内部维护一个微型的 Isar 数据库，专门用来保存 `syncitron` 所需的游标（Cursor）和脏数据（Dirty Records）。
- **拦截上行（本地 -> 云端）**：它会监听 `SyncHub` 提供的 `watchChanges()`。一旦业务包有数据变更，立马把这条变更序列化后存入内部的 Isar 过渡区，供 `syncitron` 通过 `queryDirty()` 读取。
- **下发下行（云端 -> 本地）**：当 `syncitron` 拉下远端数据并要求写入时，它不直接写死业务表，而是调用 `SyncDataAdapter.upsert()` 让业务包自己去处理真正的落盘。

### 3. 生命周期与严苛的垃圾回收 (Garbage Collection)
过渡区必须遵循**即用即删**原则，以防止数据库无限膨胀：
- **成功上传即删**：当 `syncitron` 触发 `markAsSynced()` 确认某条上行脏数据已成功入库云端时，本包必须立即在底层的 Isar 过渡区中 `delete` 该记录。
- **结果**：在日常网络畅通时，这个 Isar 过渡区的大小几乎为零，只暂存“正在飞行中”或因断网积压的数据。

## 三、 执行步骤与输出

1. **配置环境**：新建独立 package，引入 `syncitron`、`isar_community` 和 `pyro_sync_protocol`。
2. **实现过渡区模型**：定义 Isar Collection（例如 `TransitionRecord`），包含 `payload`（序列化的业务数据）以及所有同步元数据。
3. **实现 LocalStore**：编写核心类完成 `queryDirty`、`markAsSynced` 等强制接口，并实现核心的垃圾回收删除逻辑。
4. **向外暴露**：向外部（也就是 `pyro_sync_database`）仅暴露出一个极其干净的工厂方法或初始化入口，完全隐藏内部复杂的 Isar 过渡区操作。
