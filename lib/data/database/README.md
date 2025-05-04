# 数据库设计说明

## 概述

本应用使用两个隔离的数据库系统：

1. **本地SQLite数据库**：存储所有用户数据，包括联系人、通话记录、标签和规则等。
2. **远程SQLite数据库**：存储私有号码数据，仅供查询和增量同步使用。

两个数据库完全隔离，确保私有号码数据不会被导出。

## 数据库结构

### 本地数据库表

1. **contacts**：存储联系人信息
   - id: 主键
   - phoneNumber: 电话号码
   - name: 联系人名称
   - avatar: 头像（可选）
   - note: 备注（可选）
   - labelIds: 标签ID列表（JSON格式）
   - isFavorite: 是否收藏
   - lastUpdated: 最后更新时间

2. **calls**：存储通话记录
   - id: 主键
   - phoneNumber: 电话号码
   - contactName: 联系人名称（可选）
   - callType: 通话类型（来电、去电、未接）
   - startTime: 通话开始时间
   - endTime: 通话结束时间（可选）
   - duration: 通话时长（秒）
   - isRead: 是否已读
   - simInfo: SIM卡信息（可选）
   - note: 通话备注（可选）
   - isMarked: 是否被标记
   - labelIds: 标签ID列表（JSON格式）

3. **labels**：存储标签信息
   - id: 主键
   - name: 标签名称（可选）
   - icon: 标签图标（可选）
   - phoneNumber: 电话号码
   - label: 标签文本内容
   - avatar: 头像（可选）
   - priority: 优先级
   - action: 动作
   - isEnabled: 是否启用

4. **rules**：存储规则信息
   - id: 主键
   - name: 规则名称
   - priority: 规则优先级
   - action: 规则动作
   - ruleType: 规则类型
   - isEnabled: 是否启用
   - pattern: 匹配模式（可选，用于正则规则）
   - phoneNumbers: 电话号码列表（JSON格式，用于黑白名单规则）

### 远程数据库表

1. **remote_numbers**：存储私有号码数据
   - id: 主键
   - name: 联系人名称（可选）
   - phoneNumber: 电话号码
   - label: 标签文本内容
   - priority: 优先级
   - action: 动作
   - account数量

2. **sync_records**：存储同步记录
   - id: 主键
   - lastSyncTime: 最后同步时间
   - syncType: 同步类型
   - status: 同步状态

## 数据库管理

### 数据库管理器

- **LocalDatabaseManager**：管理本地数据库的初始化、迁移和关闭。
- **RemoteDatabaseManager**：管理远程数据库的初始化、迁移和关闭。

### 数据源

- **LocalContactDataSource**：处理本地联系人数据的CRUD操作。
- **RemoteNumberDataSource**：处理远程号码数据的CRUD操作和同步。

### 数据库服务

- **DatabaseService**：管理数据库的初始化和提供数据源访问。

### 同步管理器

- **SyncManager**：处理本地和远程数据库之间的增量同步。

## 使用示例

### 初始化数据库

```dart
// 初始化数据库服务
final databaseService = DatabaseService();
await databaseService.initialize();
```

### 本地数据操作

```dart
// 获取所有联系人
final contacts = await databaseService.localContactDataSource.getAll();

// 添加联系人
final contactModel = ContactModel(
  id: '',  // 空ID将自动生成UUID
  phoneNumber: '+1234567890',
  name: '张三',
  lastUpdated: DateTime.now(),
);
await databaseService.localContactDataSource.insert(contactModel);
```

### 远程数据查询

```dart
// 查询远程号码信息
final syncManager = SyncManager();
await syncManager.initialize();

final remoteNumberInfo = await syncManager.getRemoteNumberInfo('+1234567890');
if (remoteNumberInfo != null) {
  print('标签: ${remoteNumberInfo['label']}');
  print('优先级: ${remoteNumberInfo['priority']}');
  print('动作: ${remoteNumberInfo['action']}');
}
```

### 同步远程数据

```dart
// 执行同步
final success = await syncManager.sync();
if (success) {
  print('同步成功，最后同步时间: ${syncManager.lastSyncTime}');
} else {
  print('同步失败');
}
```

## 注意事项

1. 远程数据库中的数据不能被用户导出，确保私有号码数据的安全性。
2. 本地数据库和远程数据库完全隔离，互不影响。
3. 远程数据库仅供查询和增量同步使用，不能被用户直接修改。
4. 同步操作应在网络连接良好的情况下进行，以确保数据的完整性。