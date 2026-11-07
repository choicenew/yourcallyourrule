# `pyro_sync_hub`

这是一个全局统一的同步数据适配器注册与分发中心（Registry & Router）。它是一个纯 Dart 单例包，起着“交通枢纽”的作用。

在 `pyro_sync_protocol` 中，我们定义了各种适配器接口和协议。而在 `pyro_sync_hub` 中，我们负责把它们**管理起来**，并根据不同的消费者（Cloud Sync 或是 Database Sync），把正确的数据协议交出去。

---

## 🚦 Hub 的职责：“各取所需”的中心站

正如架构设计所要求的：**“谁要什么自己拿什么东西”。** `SyncHub` 就是实现这一目标的场所。

1. **业务包（生产者）** 把自己的 `SyncDataAdapter` 注册到 Hub。
2. **云盘同步包（消费者 1）** 找 Hub 索要 `JsonSyncProtocol`，从而拿到 JSON 格式的数据进行打包上传。
3. **数据库同步包（消费者 2）** 找 Hub 索要 `DatabaseSyncProtocol`，从而拿到本地数据库流监听器和增量更新方法。

---

## 🛠️ 使用指南

### 1. 业务包：注册适配器

业务包在系统启动或初始化时，将自己的同步数据适配器（已实现 JSON 与 DB 所需接口）注册到 `SyncHub` 中：

```dart
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'package:pyro_plugin_manager/plugin_sync_adapter.dart'; // 示例业务包适配器

// 在应用启动或依赖注入模块初始化时注册
void initPluginSync() {
  SyncHub.instance.register(PluginSyncAdapter());
}
```

### 2. 云盘同步包：消费 JSON 协议

像 `cloud_sync_package` 这种全量文件同步的消费者，它们不关心增量，只关心 JSON 数据。它们向 Hub 请求 JSON 协议：

```dart
import 'package:pyro_sync_hub/pyro_sync_hub.dart';

// 云盘同步：获取 JSON 协议
final jsonProto = SyncHub.instance.getJsonProtocol('plugin_manager');

// 1. 获取全量本地 JSON 数据准备打包上传
List<Map<String, dynamic>> localJson = await jsonProto.exportFullJson();

// 2. 从云端下载合并 JSON 数据后，覆盖回本地
await jsonProto.importFullJson(mergedJsonData);
```

### 3. 数据库同步包：消费 Database 协议

如果未来我们开发了 `pyro_sync_database` 包（例如接 Firebase、Supabase），它向 Hub 请求 Database 协议：

```dart
import 'package:pyro_sync_hub/pyro_sync_hub.dart';

// 云端数据库同步：获取 Database 协议
final dbProto = SyncHub.instance.getDatabaseProtocol('plugin_manager');

// 1. 监听本地数据变更，推送到云数据库
dbProto.localChangeStream.listen((model) {
  // 把模型转换并 push 到 Firebase 等
});

// 2. 从云数据库收到远端更新时，写入本地
await dbProto.upsertFromRemote(remoteModelData);
```

通过这种设计，`pyro_sync_hub` 彻底隔离了业务模型、JSON 文件同步和云端数据库同步，做到了完美的“谁要什么自己拿什么东西”。
