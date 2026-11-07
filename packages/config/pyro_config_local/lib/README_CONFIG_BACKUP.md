# 配置备份还原功能实现说明

## 概述

本模块实现了基于`ConfigRepository`的配置数据备份和还原功能，参考了`cloud_sync`模块的实现方式，但专注于配置数据的管理。通过这些功能，应用可以将用户配置数据备份到本地文件或云端，并在需要时进行还原。

## 主要组件

### 1. ConfigBackupService

`ConfigBackupService`是配置备份还原功能的核心服务，负责：

- 将配置数据序列化并保存到文件
- 从备份文件中读取配置数据并还原
- 管理备份版本
- 提供备份文件的增删改查功能

### 2. ConfigCloudConverter

`ConfigCloudConverter`负责将配置数据转换为云同步兼容的格式，使配置数据可以与其他实体一起备份和还原。主要功能包括：

- 将配置数据转换为云同步格式
- 从云同步格式恢复配置数据
- 与`CloudDataConverter`集成（概念性实现）

### 3. ConfigBackupProvider

`ConfigBackupProvider`提供了在应用中方便使用配置备份服务的方式，通过Riverpod依赖注入框架提供：

- `ConfigBackupService`实例
- `ConfigRepository`实例

## 使用方法

### 备份配置

```dart
// 通过Provider获取服务实例
final backupService = ref.read(configBackupServiceProvider);

// 备份所有配置
final backupPath = await backupService.backupAllConfigs();

// 备份指定配置
final backupPath = await backupService.backupConfigs(['theme_config', 'user_preferences']);
```

### 还原配置

```dart
// 还原所有配置
await backupService.restoreAllConfigs(backupFilePath);

// 还原指定配置
await backupService.restoreConfigs(backupFilePath, keys: ['theme_config']);
```

### 管理备份版本

```dart
// 获取备份版本列表
final versions = await backupService.getBackupVersions();

// 删除备份版本
await backupService.deleteBackupVersion(backupFilePath);

// 清除所有备份
await backupService.clearAllBackups();
```

### 与云同步集成

```dart
// 创建转换器
final converter = ConfigCloudConverter(configRepository);

// 转换为云格式
final cloudData = await converter.convertToCloudFormat();

// 从云格式还原
await converter.restoreFromCloudFormat(cloudData);
```

## 适配现有配置

所有基于`ConfigRepository`的配置类都可以自动适配此备份还原机制，无需额外修改。这包括但不限于：

- 主题配置
- 用户偏好设置
- 自动更新配置
- 来电显示配置

## 注意事项

1. 备份文件默认保存在应用文档目录的`config_backups`子目录中
2. 备份版本信息保存在SharedPreferences中，键名为`config_backup_versions`
3. 备份文件使用JSON格式，可以方便地查看和编辑
4. 当前实现不包含加密功能，如需加密可参考`BackupEncryptionService`的实现