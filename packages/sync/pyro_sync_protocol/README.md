# `pyro_sync_protocol`

这是一个高度解耦的、统一的同步中介与协议接口包。它的核心目的只有一个：**确保云盘文件同步（JSON 数据）和 云端数据库同步（Database 数据）各自获取它们所需要的数据格式，彼此互不干扰，完全解耦。**

也就是你说的：**“谁要什么自己拿什么东西”。** `cloud_sync_package`（云盘同步）从中拿到的是 JSON 数据，而未来的 `database_sync_package`（数据库同步，如 Firebase/Supabase）从中拿到的是 Database 行级数据。

---

## 💡 核心设计理念：严格的协议隔离

在以前的设计中，各种同步逻辑容易杂糅在一起。现在，我们通过 `pyro_sync_protocol` 进行了严格的拆分。

当一个业务包（例如 `pyro_plugin_manager`）想要接入同步时：
1. **只需要实现一个统一的适配器：`SyncDataAdapter<T>`**。
2. 该适配器内部**同时包含**了云盘同步需要的方法（全量读取、覆盖）和数据库同步需要的方法（流监听、增量更新）。

然后，`pyro_sync_protocol` 提供了两套**截然不同的协议**来提取这些数据：

### 1. `JsonSyncProtocol`（给 `cloud_sync_package` 用的）
- 它只负责提取 `readAll` 获取本地列表，并调用 `toJson` 把它变成 `List<Map<String, dynamic>>`。
- 它接收外部的 JSON 数据，并通过 `fromJson` 转为模型后，调用 `overwriteAll` 覆盖本地。
- **云盘同步包只能看见 JSON 数据，完全不知道底层是什么。**

### 2. `DatabaseSyncProtocol`（给 未来的数据库同步包 用的）
- 它只负责调用 `watchChanges` 监听本地数据的变化。
- 它接收远端数据库的单条变更，并调用 `upsert` 写入本地。
- **数据库同步包只能看见模型数据流或转换为数据库表结构的数据，不走文件级别的全量覆盖。**

---

## 🛠️ 接入指南：以插件模块（Plugin Package）为例

假设我们有一个插件管理包，它有一个插件实体类 `PluginModel`。要想让这个包同时支持 **网盘同步** 和 **云数据库同步**，只需要实现 `SyncDataAdapter` 并在 Hub 中注册即可：

### 实现统一的数据适配器 `SyncDataAdapter`

业务包只需要实现这**一个**适配器，把所有本地数据库（如 Isar/SQLite）的存取逻辑封装起来：

```dart
import 'package:pyro_sync_protocol/pyro_sync_protocol.dart';

// 1. 本地实体类
class PluginModel {
  final String id;
  final String name;
  final bool isEnabled;

  PluginModel({required this.id, required this.name, required this.isEnabled});
}

// 2. 实现一个统一的数据适配器
class PluginSyncAdapter implements SyncDataAdapter<PluginModel> {
  @override
  String get moduleId => 'plugin_manager'; // 模块唯一标识

  // ==================== [给云盘全量同步协议使用的接口] ====================
  
  @override
  Future<List<PluginModel>> readAll() async {
    // 从本地数据库读取所有数据
    return localDb.getAllPlugins(); 
  }

  @override
  Future<void> overwriteAll(List<dynamic> items) async {
    // 【注意】这里是 List<dynamic> 以支持泛型退化，业务层强转即可
    final models = List<PluginModel>.from(items);
    await localDb.clearAndInsertAll(models);
  }

  // ==================== [给云数据库增量同步协议使用的接口] ====================

  @override
  Stream<PluginModel> watchChanges() {
    // 监听本地数据库中插件的变更流（新增或修改时，数据库吐出最新的实体）
    return localDb.watchPluginChanges(); 
  }

  @override
  Future<void> upsert(PluginModel item) async {
    // 远程云端单条记录更新时，写入本地数据库（新增或修改）
    await localDb.putPlugin(item); 
  }

  // ==================== [通用的序列化与反序列化接口] ====================

  @override
  Map<String, dynamic> toJson(PluginModel item) {
    return {'id': item.id, 'name': item.name, 'isEnabled': item.isEnabled};
  }

  @override
  PluginModel fromJson(Map<String, dynamic> json) {
    return PluginModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isEnabled: json['isEnabled'] as bool,
    );
  }
}
```

业务包写完这个适配器后，它的任务就彻底结束了。它不需要知道自己的数据是去网盘了，还是去 Firebase 了。
