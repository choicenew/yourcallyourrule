# sync_adapter_syncitron

`sync_adapter_syncitron` 是一个专门为 `syncitron` 同步引擎打造的底层适配器包。

## 职责定位

- **翻译官**：连接 0-感知的业务数据流与需要同步元数据的 `syncitron` 引擎。
- **过渡区物理隔离**：内部使用 `isar_community` 维护一个微型的“过渡区（Transition Zone）”数据库，不污染业务数据库。
- **自清理 (GC)**：日常网络畅通时，过渡区中已同步的数据会在 `markAsSynced` 时被物理删除，防无限膨胀。

## 使用指南

### 1. 注册 Isar Schema
在应用程序初始化 Isar 时，必须包含该适配器提供的 Schemas：

```dart
import 'package:sync_adapter_syncitron/sync_adapter_syncitron.dart';

final isar = await Isar.open([
  ...yourBusinessSchemas,
  ...SyncitronAdapter.schemas, // 注入过渡区所需要的 Schema
]);
```

### 2. 创建本地存储适配器
使用工厂方法基于打开的 Isar 实例创建 `ProtocolLocalStore`：

```dart
final localStore = await SyncitronAdapter.createLocalStore(isar: isar);
```

这个本地存储实例直接作为 `syncitron.LocalStore` 传入 `SyncEngine` 即可，随后管理器会在注册表时自动建立变更监听。
