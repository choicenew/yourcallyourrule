# pyro_sync_database

`pyro_sync_database` 是 Pyro 同步体系中的**具体同步执行包（消费者层）**。它致力于作为增量同步（实时同步）的通用消费者，实现本地业务数据与云端数据库（如 Supabase、Appwrite 或自定义后端）的高效增量同步。

## 架构定位与设计哲学

在整个同步架构中，本包严格遵守 **Protocol & Hub 分离原则**：
1. **底座契约层（`pyro_sync_protocol`）**保持绝对的纯洁性，只定义通用的 `SyncDataAdapter<T>` 接口，不关心也不涉及任何具体的同步网络和数据库逻辑。
2. **中介路由层（`pyro_sync_hub`）**充当注册路由器，只负责适配器的注册与交换。
3. **本包（`pyro_sync_database`）**作为消费者，从 `SyncHub` 拿到原始的 `SyncDataAdapter` 之后，在包内部将其包装为适用于行级/增量实时同步的 `DatabaseSyncProtocol`，实现真正的“零侵入性”。

---

## 核心组件

### 1. `DatabaseSyncProtocol<T>`
行级增量协议包装器。负责接收 `SyncDataAdapter<T>` 并暴露以下接口：
* `localChangeStream`：监听本地数据的变更，并将其自动转换为 JSON Map 流，便于推送到云端。
* `applyRemoteMutation`：将云端接收到的单条突变/更新数据反序列化为实体并写入本地。

### 2. `DatabaseSyncManager`
数据库同步管理器，提供全局统一的协调器：
* `startSyncingModule`：自动监听本地指定模块的变化，并通过传入的回调函数实时同步到云端数据库。
* `applyRemoteChange`：将云端数据库发生的变更或推送实时更新回本地存储。
* `stopSyncingModule`：停止特定模块的同步监听。

---

## 快速使用

```dart
import 'package:pyro_sync_database/pyro_sync_database.dart';

// 1. 初始化管理器
final syncManager = DatabaseSyncManager();

// 2. 开启模块的实时上行同步（本地 -> 云端）
syncManager.startSyncingModule<Todo>(
  'todo_module',
  onPushToCloud: (data) async {
    // 调用您的云端 API (例如 Supabase) 执行 upsert
    await supabase.from('todos').upsert(data);
  },
);

// 3. 当云端实时通道监听到变更时（云端 -> 本地）
supabase.channel('todos_realtime').onPostgresChanges(
  event: PostgresChangeEvent.all,
  callback: (payload) async {
    final newRow = payload.newRecord;
    await syncManager.applyRemoteChange<Todo>('todo_module', newRow);
  },
).subscribe();
```
