# `pyro_sync_contracts`：统一中介层架构方案

> **核心思想**：由用户提出的绝佳架构。业务包（如 Plugin）只负责把数据“丢”给协议层，完全不关心同步到哪里。协议层内部自动适配，既提供给网盘全量 JSON 的接口，又提供给未来数据库的行级增量接口。

---

## 一、架构定位：Router / Facade 模式

以前我们想让业务包去实现 `SyncableModule`，这会让业务包知道太多同步的细节（比如怎么转 JSON）。
现在的设计是：**业务包只提供最基础的数据源接口（DataSource Adapter）**，剩下的全由本包包装。

```mermaid
graph TD
    subgraph 业务层
        A[Plugin Package] -->|提供 DataAdapter| Contracts
        B[Reading History] -->|提供 DataAdapter| Contracts
    end

    subgraph pyro_sync_contracts (协议与中介层)
        Contracts[统一中介接口]
        Contracts -->|包装出 JSON 全量接口| J[Json Sync Protocol]
        Contracts -->|包装出行级增量接口| D[Database Row Protocol]
    end

    subgraph 消费者
        J -.-> |需要网盘合并| C[cloud_sync_package]
        D -.-> |需要实时单条更新| S[未来: supabase_sync]
    end
```

---

## 二、包结构与代码设计

### 2.1 业务包需要提供什么？（基础适配器）

在 `pyro_sync_contracts/lib/src/core/sync_adapter.dart` 中定义：

```dart
/// 所有想参与同步的业务包，只需要实现这个基础接口。
/// 它只关心本地数据存取，没有任何网络或 JSON 逻辑。
abstract class SyncDataAdapter<T> {
  String get moduleId;
  
  // 1. 全量读取（供网盘用）
  Future<List<T>> readAll();
  
  // 2. 全量覆盖（供网盘用）
  Future<void> overwriteAll(List<T> items);
  
  // 3. 增量监听（供云数据库用，返回新增或修改的记录流）
  Stream<T> watchChanges();
  
  // 4. 单条更新（供云数据库拉取数据后更新本地）
  Future<void> upsert(T item);
  
  // 序列化与反序列化
  Map<String, dynamic> toJson(T item);
  T fromJson(Map<String, dynamic> json);
}
```

### 2.2 协议层内部怎么做分发？（Wrapper 包装器）

协议包在拿到业务包给的 `SyncDataAdapter` 后，对外提供两套“马甲（Wrapper）”。

#### 马甲 A：供 `cloud_sync_package` 使用的 JSON 协议
文件：`lib/src/protocols/json_sync_protocol.dart`

```dart
class JsonSyncProtocol {
  final SyncDataAdapter _adapter;
  JsonSyncProtocol(this._adapter);

  // cloud_sync 只需要调用这个，就能拿到合并需要的 List<Map>
  Future<List<Map<String, dynamic>>> exportFullJson() async {
    final items = await _adapter.readAll();
    return items.map((e) => _adapter.toJson(e)).toList();
  }

  // cloud_sync 合并完差异后，调用这个覆盖本地
  Future<void> applyResolvedJson(List<Map<String, dynamic>> jsonList) async {
    final items = jsonList.map((e) => _adapter.fromJson(e)).toList();
    await _adapter.overwriteAll(items);
  }
}
```

#### 马甲 B：供未来云数据库使用的行级协议
文件：`lib/src/protocols/database_sync_protocol.dart`

```dart
class DatabaseSyncProtocol {
  final SyncDataAdapter _adapter;
  DatabaseSyncProtocol(this._adapter);

  // Supabase 只需要监听这个，就能把变更 push 给远端
  Stream<Map<String, dynamic>> get localChangeStream {
    return _adapter.watchChanges().map((e) => _adapter.toJson(e));
  }

  // Supabase 从云端拿到一条别人改的数据，调用这个存进本地
  Future<void> applyRemoteMutation(Map<String, dynamic> rowData) async {
    final item = _adapter.fromJson(rowData);
    await _adapter.upsert(item);
  }
}
```

### 2.3 注册中心（SyncRegistry）

```dart
class SyncRegistry {
  final Map<String, SyncDataAdapter> _adapters = {};

  // 业务包在主 APP 启动时，把自己的 Adapter 丢进来
  void register(SyncDataAdapter adapter) {
    _adapters[adapter.moduleId] = adapter;
  }

  // cloud_sync_package 从这里拿 JSON 马甲
  JsonSyncProtocol getJsonProtocol(String moduleId) {
    return JsonSyncProtocol(_adapters[moduleId]!);
  }

  // 未来的 Supabase 包从这里拿 Database 马甲
  DatabaseSyncProtocol getDatabaseProtocol(String moduleId) {
    return DatabaseSyncProtocol(_adapters[moduleId]!);
  }
}
```

---

## 三、这样做的好处（完全实现你的设想）

1. **业务包 0 感知**：`pyro_plugin_manager` 只知道自己写了一个 `readAll` 和 `upsert`，它根本不知道外面是网盘在调它，还是 Supabase 在调它。
2. **同时支持双引擎开启**：将来即使用户开启了 Supabase，由于 `cloud_sync_package` 拿的是 `JsonSyncProtocol`，Supabase 拿的是 `DatabaseSyncProtocol`，它们互不干扰。你可以让网盘做冷备份（一天一次），让 Supabase 做热同步（实时）。
3. **极简接入**：未来如果引入第三方包（如 `syncitron`），只需要在主项目写几行胶水代码，把 `DatabaseSyncProtocol` 对接给 `syncitron` 即可。
