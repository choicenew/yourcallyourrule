# Config Package

Configuration backup and storage package for Flutter applications.

## Features

- 💾 Configuration storage using SharedPreferences
- 🔄 Configuration backup and restore
- 🎯 Riverpod 3 integration

## Installation

```yaml
dependencies:
  config_package:
    path: ../path/to/config_package
```

## Usage

```dart
import 'package:config_package/config_package.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Use config repository
final configRepo = ref.watch(configRepositoryProvider);
await configRepo.saveConfig('my_key', {'value': 'data'});
final config = await configRepo.getConfig('my_key');

// Use backup service
final backupService = ref.watch(configBackupServiceProvider);
await backupService.initialize();
final backupPath = await backupService.backupAllConfigs();
await backupService.restoreConfigs(backupPath);
```

## API

### ConfigRepository

- `getConfig(String key)` - Get configuration by key
- `saveConfig(String key, Map<String, dynamic> config)` - Save configuration
- `removeConfig(String key)` - Remove configuration

### ConfigBackupService

- `backupAllConfigs()` - Backup all configurations
- `restoreConfigs(String source, {List<String>? keys})` - Restore configurations

## Requirements

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0
- flutter_riverpod: ^3.0.3
