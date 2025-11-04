import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/cloud_sync/entities/backup_config_entity.dart';
import 'package:yourcallyourrule/cloud_sync/entities/backup_version_entity.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/data/repositories/config/config_backup_service.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';

import 'backup_encryption_service.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as path;

class BackupRestoreService {
  late final Directory _backupDirectory;
  late final SharedPreferences _preferences;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _isInitialized = false;

  // Service dependencies
  final BackupEncryptionService _encryptionService;
  final ConfigBackupService _configBackupService;

  BackupRestoreService(
    this._encryptionService,
    this._configBackupService,
  );

  // Encryption service initialization

  static const String _backupConfigKey = 'config_backup_config';
  static const String _backupVersionsKey = 'config_backup_versions';

  Future<BackupConfigEntity> getBackupConfig() async {
    _ensureInitialized();

    final configJson = _preferences.getString(_backupConfigKey);
    if (configJson != null) {
      return BackupConfigEntity.fromJson(jsonDecode(configJson));
    }

    // Return default config
    return BackupConfigEntity(
      keepAllVersions: false,
      deviceName: await _getDefaultDeviceName(),
      localBackupPath: (await getApplicationDocumentsDirectory()).path,
      encryptionEnabled: await isEncryptionEnabled(),
    );
  }

  Future<void> updateBackupConfig(BackupConfigEntity config) async {
    _ensureInitialized();

    // Update encryption settings if changed
    if (config.encryptionEnabled != await isEncryptionEnabled()) {
      await setEncryptionEnabled(config.encryptionEnabled);
    }

    await _preferences.setString(_backupConfigKey, jsonEncode(config.toJson()));
  }

  Future<List<BackupVersionEntity>> getBackupVersions() async {
    _ensureInitialized();

    final versionsJson = _preferences.getString(_backupVersionsKey);
    if (versionsJson != null) {
      final List<dynamic> list = jsonDecode(versionsJson);
      return list.map((json) => BackupVersionEntity.fromJson(json)).toList();
    }
    return [];
  }

  Future<String> _getDefaultDeviceName() async {
    try {
      if (Platform.isAndroid) {
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        return deviceInfo.model;
      } else if (Platform.isIOS) {
        final deviceInfo = await DeviceInfoPlugin().iosInfo;
        return deviceInfo.name;
      }
    } catch (e) {
      debugPrint('Error getting device name: $e');
    }
    return 'Unknown Device';
  }

  Future<void> initialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;

    // Get application documents directory
    final appDocDir = await getApplicationDocumentsDirectory();
    _backupDirectory = Directory(path.join(appDocDir.path, 'backups'));

    // Create backup directory if it doesn't exist
    if (!await _backupDirectory.exists()) {
      await _backupDirectory.create(recursive: true);
    }

    // Initialize shared preferences
    _preferences = await SharedPreferences.getInstance();

    // Initialize encryption service
    await _encryptionService.initialize();

    _isInitialized = true;
  }

  Future<bool> isConfigured() async {
    return _isInitialized;
  }

  /// Check if backup encryption is enabled

  Future<bool> isEncryptionEnabled() async {
    return await _encryptionService.isEncryptionEnabled();
  }

  /// Enable or disable backup encryption

  Future<void> setEncryptionEnabled(bool enabled) async {
    await _encryptionService.setEncryptionEnabled(enabled);
  }

  /// Set encryption password

  Future<void> setEncryptionPassword(String password) async {
    await _encryptionService.setEncryptionPassword(password);
  }

  /// Validate encryption password

  Future<bool> validateEncryptionPassword(String password) async {
    return await _encryptionService.validatePassword(password);
  }

  /// Clear encryption settings

  Future<void> clearEncryptionSettings() async {
    await _encryptionService.clearEncryptionSettings();
  }

  Future<String> backupRules(List<RuleBase> rules, String destination) async {
    _ensureInitialized();
    try {
      final db = DatabaseService().localDatabase;

      // 自动枚举所有包含 "rule" 的业务表
      final tableRows = await db.customSelect(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'moor_%' AND name NOT LIKE 'drift_%' AND LOWER(name) LIKE '%rule%'",
      ).get();
      final ruleTables = tableRows
          .map((r) => (r.data['name'] as String).trim())
          .where((name) => name.isNotEmpty)
          .toList()
        ..sort();

      final Map<String, List<Map<String, dynamic>>> dump = {};
      for (final table in ruleTables) {
        final rows = await db.customSelect('SELECT * FROM $table').get();
        final List<Map<String, dynamic>> list = [];
        for (final row in rows) {
          final Map<String, dynamic> jsonRow = {};
          row.data.forEach((key, value) {
            if (value is Uint8List) {
              jsonRow[key] = base64Encode(value);
            } else if (value is bool) {
              jsonRow[key] = value ? 1 : 0;
            } else {
              jsonRow[key] = value;
            }
          });
          list.add(jsonRow);
        }
        dump[table] = list;
      }

      final jsonString = jsonEncode({
        'tables': dump,
        'created_at': DateTime.now().toIso8601String(),
        'device': await _getDefaultDeviceName(),
        'format': 'drift_rule_json_v1',
      });

      File outputFile;
      if (destination.isNotEmpty) {
        outputFile = File(destination);
      } else {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        outputFile = File(path.join(_backupDirectory.path, 'rules_$timestamp.json'));
      }

      if (await isEncryptionEnabled()) {
        final bytes = Uint8List.fromList(utf8.encode(jsonString));
        final encrypted = await _encryptionService.encryptData(bytes);
        await outputFile.writeAsBytes(encrypted);
      } else {
        await outputFile.writeAsString(jsonString);
      }

      await _addBackupVersion('rules', outputFile.path);
      return outputFile.path;
    } catch (e) {
      throw Exception('Failed to backup rule tables: $e');
    }
  }
  
  /// 备份配置数据
  /// [destination] 备份文件路径，如果为空则使用默认路径
  /// [configKeys] 要备份的配置键列表，如果为空则备份所有配置
  Future<String> backupConfigs(String destination, {List<String>? configKeys}) async {
    _ensureInitialized();
    try {
      // 收集配置键
      final keys = (configKeys != null && configKeys.isNotEmpty)
          ? configKeys
          : await _configBackupService.getAllConfigKeys();

      // 读取配置数据
      final Map<String, dynamic> selectedConfigs = {};
      for (final key in keys) {
        final cfg = await _configBackupService.configRepository.getConfig(key);
        if (cfg != null) {
          selectedConfigs[key] = cfg;
        }
      }

      // 组装备份 JSON
      final backupData = {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'configs': selectedConfigs,
      };
      final jsonString = jsonEncode(backupData);

      // 输出文件（支持加密）
      File outputFile;
      if (destination.isNotEmpty) {
        outputFile = File(destination);
      } else {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        outputFile = File(path.join(_backupDirectory.path, 'configs_$timestamp.json'));
      }

      if (await isEncryptionEnabled()) {
        final bytes = Uint8List.fromList(utf8.encode(jsonString));
        final encrypted = await _encryptionService.encryptData(bytes);
        await outputFile.writeAsBytes(encrypted);
      } else {
        await outputFile.writeAsString(jsonString);
      }

      await _addBackupVersion('configs', outputFile.path);
      return outputFile.path;
    } catch (e) {
      throw Exception('Failed to backup configs: $e');
    }
  }
  
  /// 备份所有数据（数据库表 + 应用设置 + 配置仓库）
  /// 返回生成的备份文件路径（单一文件，支持加密）
  Future<String> backupAll(String destination) async {
    _ensureInitialized();

    try {
      final db = DatabaseService().localDatabase;

      // 1) 导出所有业务表为 JSON（自动枚举）
      final tableRows = await db.customSelect(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'moor_%' AND name NOT LIKE 'drift_%'",
      ).get();
      final allTables = tableRows
          .map((r) => (r.data['name'] as String).trim())
          .where((name) => name.isNotEmpty)
          .toList()
        ..sort();

      final Map<String, List<Map<String, dynamic>>> dumpTables = {};
      for (final table in allTables) {
        final rows = await db.customSelect('SELECT * FROM $table').get();
        final List<Map<String, dynamic>> list = [];
        for (final row in rows) {
          final Map<String, dynamic> jsonRow = {};
          row.data.forEach((key, value) {
            if (value is Uint8List) {
              jsonRow[key] = base64Encode(value);
            } else if (value is bool) {
              jsonRow[key] = value ? 1 : 0;
            } else {
              jsonRow[key] = value;
            }
          });
          list.add(jsonRow);
        }
        dumpTables[table] = list;
      }

      // 2) 导出设置（SharedPreferences + SecureStorage + ConfigRepository）
      final Map<String, dynamic> settings = {};
      // SharedPreferences
      final allPrefs = _preferences.getKeys();
      for (final key in allPrefs) {
        if (_preferences.containsKey(key)) {
          settings[key] = _preferences.get(key);
        }
      }
      // Secure Storage
      final secureItems = await _secureStorage.readAll();
      settings['secure_storage'] = secureItems;
      // ConfigRepository 数据
      try {
        final configBackupPath = await _configBackupService.backupAllConfigs();
        final configBackupFile = File(configBackupPath);
        if (await configBackupFile.exists()) {
          final configBackupContent = await configBackupFile.readAsString();
          final configData = jsonDecode(configBackupContent);
          settings['config_repository_data'] = configData;
          await configBackupFile.delete();
        }
      } catch (e) {
        debugPrint('获取ConfigRepository配置数据失败: $e');
      }

      // 3) 组装总 JSON
      final jsonString = jsonEncode({
        'tables': dumpTables,
        'settings': settings,
        'created_at': DateTime.now().toIso8601String(),
        'device': await _getDefaultDeviceName(),
        'format': 'drift_db_all_v1',
      });

      // 4) 输出文件（支持加密）
      File outputFile;
      if (destination.isNotEmpty) {
        outputFile = File(destination);
      } else {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        outputFile = File(path.join(_backupDirectory.path, 'all_$timestamp.json'));
      }

      if (await isEncryptionEnabled()) {
        final bytes = Uint8List.fromList(utf8.encode(jsonString));
        final encrypted = await _encryptionService.encryptData(bytes);
        await outputFile.writeAsBytes(encrypted);
      } else {
        await outputFile.writeAsString(jsonString);
      }

      await _addBackupVersion('all', outputFile.path);
      return outputFile.path;
    } catch (e) {
      throw Exception('Failed to backup all data: $e');
    }
  }

  Future<List<RuleBase>> restoreRules(String source) async {
    _ensureInitialized();

    // 读取文件，若为综合备份则仅恢复 tables 部分；否则按纯 tables JSON 处理
    final file = File(source);
    if (!await file.exists()) {
      throw Exception('Backup file not found: $source');
    }

    String jsonString;
    final rawBytes = await file.readAsBytes();
    if (await isEncryptionEnabled()) {
      try {
        final decrypted = await _encryptionService.decryptData(rawBytes);
        jsonString = utf8.decode(decrypted);
      } catch (_) {
        jsonString = utf8.decode(rawBytes);
      }
    } else {
      jsonString = utf8.decode(rawBytes);
    }

    Map<String, dynamic> parsed;
    try {
      parsed = jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Invalid backup format: $e');
    }

    if (parsed.containsKey('tables')) {
      final tablesData = parsed['tables'] as Map<String, dynamic>;
      await _restoreTablesFromMap(tablesData);
    } else {
      // 兼容旧的仅表 JSON：直接写入
      await restoreDatabaseJson(source);
    }

    // 为避免手动枚举具体规则类型，这里返回空列表；
    // UI 使用数量时可通过数据库统计，而不是依赖具体实体列表。
    return const [];
  }
  
  /// 还原配置数据
  /// [source] 备份文件路径
  /// [configKeys] 要还原的配置键列表，如果为空则还原所有配置
  Future<void> restoreConfigs(String source, {List<String>? configKeys}) async {
    _ensureInitialized();
    await _configBackupService.restoreConfigs(source, keys: configKeys);
  }
  
  /// 还原所有数据（规则、标签、位置和配置）
  Future<void> restoreAll(String source) async {
    _ensureInitialized();

    final file = File(source);
    if (!await file.exists()) {
      throw Exception('Backup file not found: $source');
    }

    String jsonString;
    final rawBytes = await file.readAsBytes();
    if (await isEncryptionEnabled()) {
      try {
        final decrypted = await _encryptionService.decryptData(rawBytes);
        jsonString = utf8.decode(decrypted);
      } catch (_) {
        jsonString = utf8.decode(rawBytes);
      }
    } else {
      jsonString = utf8.decode(rawBytes);
    }

    Map<String, dynamic> parsed;
    try {
      parsed = jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Invalid backup format: $e');
    }

    // 先还原数据库表
    if (parsed.containsKey('tables')) {
      final tablesData = parsed['tables'] as Map<String, dynamic>;
      await _restoreTablesFromMap(tablesData);
    }

    // 再还原设置（SharedPreferences + SecureStorage + ConfigRepository）
    if (parsed.containsKey('settings')) {
      final settings = parsed['settings'] as Map<String, dynamic>;
      await _restoreSettingsFromMap(settings);
    }
  }

  /// 准备设置备份数据，返回临时文件路径
  Future<String> prepareSettingsBackup() async {
    _ensureInitialized();

    // Get all shared preferences
    final allPrefs = _preferences.getKeys();
    final Map<String, dynamic> settings = {};

    for (final key in allPrefs) {
      if (_preferences.containsKey(key)) {
        final value = _preferences.get(key);
        settings[key] = value;
      }
    }

    // Get secure storage items
    final secureItems = await _secureStorage.readAll();
    settings['secure_storage'] = secureItems;

    // 获取ConfigRepository中的配置数据
    try {
      // 使用ConfigBackupService备份所有配置到临时文件
      final configBackupPath = await _configBackupService.backupAllConfigs();
      final configBackupFile = File(configBackupPath);
      
      // 读取配置备份文件内容
      if (await configBackupFile.exists()) {
        final configBackupContent = await configBackupFile.readAsString();
        final configData = jsonDecode(configBackupContent);
        
        // 将配置数据添加到设置中
        settings['config_repository_data'] = configData;
        
        // 删除临时配置备份文件
        await configBackupFile.delete();
      }
    } catch (e) {
      debugPrint('获取ConfigRepository配置数据失败: $e');
      // 即使获取配置数据失败，也继续备份其他设置
    }

    final jsonString = jsonEncode(settings);

    // Create a temporary file
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final tempFile = File(path.join(_backupDirectory.path, 'temp_settings_$timestamp.json'));

    // Check if encryption is enabled
    if (await isEncryptionEnabled()) {
      // Convert string to bytes
      final bytes = Uint8List.fromList(utf8.encode(jsonString));

      // Encrypt the data
      final encryptedBytes = await _encryptionService.encryptData(bytes);

      // Write encrypted data to file
      await tempFile.writeAsBytes(encryptedBytes);
    } else {
      // Write unencrypted data
      await tempFile.writeAsString(jsonString);
    }

    return tempFile.path;
  }

  /// 备份设置到指定路径
  /// 注意：在Android和iOS平台上，应该使用prepareSettingsBackup方法获取数据，
  /// 然后使用FilePicker.platform.saveFile方法并提供bytes参数
  Future<String> backupSettings(String destination) async {
    _ensureInitialized();

    // Get all shared preferences
    final allPrefs = _preferences.getKeys();
    final Map<String, dynamic> settings = {};

    for (final key in allPrefs) {
      if (_preferences.containsKey(key)) {
        final value = _preferences.get(key);
        settings[key] = value;
      }
    }

    // Get secure storage items
    final secureItems = await _secureStorage.readAll();
    settings['secure_storage'] = secureItems;

    // 获取ConfigRepository中的配置数据
    try {
      // 使用ConfigBackupService备份所有配置到临时文件
      final configBackupPath = await _configBackupService.backupAllConfigs();
      final configBackupFile = File(configBackupPath);
      
      // 读取配置备份文件内容
      if (await configBackupFile.exists()) {
        final configBackupContent = await configBackupFile.readAsString();
        final configData = jsonDecode(configBackupContent);
        
        // 将配置数据添加到设置中
        settings['config_repository_data'] = configData;
        
        // 删除临时配置备份文件
        await configBackupFile.delete();
      }
    } catch (e) {
      debugPrint('获取ConfigRepository配置数据失败: $e');
      // 即使获取配置数据失败，也继续备份其他设置
    }

    final jsonString = jsonEncode(settings);

    File backupFile;
    if (destination.isEmpty) {
      // Use default location if no destination provided
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      backupFile =
          File(path.join(_backupDirectory.path, 'settings_$timestamp.json'));
    } else {
      backupFile = File(destination);
    }

    // Check if encryption is enabled
    if (await isEncryptionEnabled()) {
      // Convert string to bytes
      final bytes = Uint8List.fromList(utf8.encode(jsonString));

      // Encrypt the data
      final encryptedBytes = await _encryptionService.encryptData(bytes);

      // Write encrypted data to file
      await backupFile.writeAsBytes(encryptedBytes);
    } else {
      // Write unencrypted data
      await backupFile.writeAsString(jsonString);
    }

    // Add to backup versions
    await _addBackupVersion('settings', backupFile.path);

    return backupFile.path;
  }

  Future<bool> restoreSettings(String source) async {
    _ensureInitialized();

    final backupFile = File(source);
    if (!await backupFile.exists()) {
      throw Exception('Backup file not found: $source');
    }

    String jsonString;

    try {
      // Try to read as encrypted data first
      if (await isEncryptionEnabled()) {
        final encryptedBytes = await backupFile.readAsBytes();

        try {
          // Try to decrypt the data
          final decryptedBytes =
              await _encryptionService.decryptData(encryptedBytes);
          jsonString = utf8.decode(decryptedBytes);
        } catch (e) {
          // If decryption fails, try reading as plain text
          jsonString = await backupFile.readAsString();
        }
      } else {
        // Read as plain text
        jsonString = await backupFile.readAsString();
      }

      final Map<String, dynamic> settings = jsonDecode(jsonString);

      // Clear existing preferences
      await _preferences.clear();

      // Restore shared preferences
      for (final entry in settings.entries) {
        if (entry.key != 'secure_storage' && entry.key != 'config_repository_data') {
          final value = entry.value;
          if (value is String) {
            await _preferences.setString(entry.key, value);
          } else if (value is bool) {
            await _preferences.setBool(entry.key, value);
          } else if (value is int) {
            await _preferences.setInt(entry.key, value);
          } else if (value is double) {
            await _preferences.setDouble(entry.key, value);
          } else if (value is List<String>) {
            await _preferences.setStringList(entry.key, value);
          }
        }
      }

      // Restore secure storage
      if (settings.containsKey('secure_storage')) {
        final Map<String, dynamic> secureItems = settings['secure_storage'];
        await _secureStorage.deleteAll();
        for (final entry in secureItems.entries) {
          await _secureStorage.write(key: entry.key, value: entry.value);
        }
      }

      // 还原ConfigRepository中的配置数据
      if (settings.containsKey('config_repository_data')) {
        try {
          final configData = settings['config_repository_data'];
          
          // 如果配置数据包含configs字段，说明是通过ConfigBackupService备份的
          if (configData is Map && configData.containsKey('configs')) {
            final configs = configData['configs'] as Map<String, dynamic>;
            
            // 遍历所有配置并还原
            for (final entry in configs.entries) {
              if (entry.value is Map<String, dynamic>) {
                await _configBackupService.configRepository.saveConfig(
                  entry.key, 
                  entry.value as Map<String, dynamic>
                );
              }
            }
            
            debugPrint('成功还原ConfigRepository配置数据');
          }
        } catch (e) {
          debugPrint('还原ConfigRepository配置数据失败: $e');
          // 即使还原配置数据失败，也继续还原其他设置
        }
      }

      return true;
    } catch (e) {
      throw Exception('Failed to restore settings: ${e.toString()}');
    }
  }

  Future<bool> scheduleAutomaticBackup(
      Duration interval, String destination) async {
    _ensureInitialized();

    // Store backup schedule in preferences
    await _preferences.setInt('backup_interval_ms', interval.inMilliseconds);
    await _preferences.setString('backup_destination', destination);
    await _preferences.setInt(
        'last_backup_time', DateTime.now().millisecondsSinceEpoch);

    // Note: Actual scheduling would require a background service or periodic task
    // which is beyond the scope of this implementation

    return true;
  }

  Future<bool> cancelAutomaticBackup() async {
    _ensureInitialized();

    // Remove backup schedule from preferences
    await _preferences.remove('backup_interval_ms');
    await _preferences.remove('backup_destination');
    await _preferences.remove('last_backup_time');

    return true;
  }

  Future<List<String>> getAvailableBackups() async {
    _ensureInitialized();

    final files = await _backupDirectory.list().toList();
    return files
        .whereType<File>()
        .map((file) => file.path)
        .where((path) => path.endsWith('.json'))
        .toList();
  }

  Future<String> selectBackupFile() async {
    _ensureInitialized();

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      dialogTitle: 'Select backup file',
    );

    if (result == null || result.files.isEmpty) {
      throw Exception('No file selected');
    }

    return result.files.first.path!;
  }

  Future<String> selectBackupDestination() async {
    _ensureInitialized();

    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Save backup file',
      fileName: 'backup_${DateTime.now().millisecondsSinceEpoch}.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null) {
      throw Exception('No destination selected');
    }

    return result;
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception(
          'BackupRestoreService not initialized. Call initialize() first.');
    }
  }


  /// Add a backup version to the history
  Future<void> _addBackupVersion(String backupType, String filePath) async {
    _ensureInitialized();

    // Get current backup versions
    final versions = await getBackupVersions();

    // Create new backup version
    final newVersion = BackupVersionEntity(
      version: const Uuid().v4(),
      backupTime: DateTime.now(),
      deviceName: (await getBackupConfig()).deviceName,
      filePath: filePath,
      backupType: backupType,
    );

    // Add to list
    versions.add(newVersion);

    // Save updated list
    final versionsJson = versions.map((v) => v.toJson()).toList();
    await _preferences.setString(_backupVersionsKey, jsonEncode(versionsJson));
  }

  String get serviceType => 'local';

  String get serviceName => 'Local Backup Service';

  /// 数据库级快照备份（导出整个 SQLite 数据库文件）
  /// - 使用 VACUUM INTO 生成一致性快照
  /// - 根据加密配置选择明文或加密输出
  Future<String> backupDatabaseSnapshot(String destination) async {
    _ensureInitialized();
    try {
      final db = DatabaseService().localDatabase;

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempSnapshotPath =
          path.join(_backupDirectory.path, 'db_$timestamp.sqlite');

      // 使用 VACUUM INTO 生成快照（避免直接复制打开的数据库文件）
      final sanitizedTmp = tempSnapshotPath.replaceAll("'", "''");
      await db.customStatement("VACUUM INTO '$sanitizedTmp'");

      File finalFile;
      if (destination.isEmpty) {
        finalFile = File(path.join(
            _backupDirectory.path,
            await isEncryptionEnabled()
                ? 'db_$timestamp.enc'
                : 'db_$timestamp.sqlite'));
      } else {
        finalFile = File(destination);
      }

      if (await isEncryptionEnabled()) {
        final snapshotBytes = await File(tempSnapshotPath).readAsBytes();
        final encryptedBytes = await _encryptionService.encryptData(snapshotBytes);
        await finalFile.writeAsBytes(encryptedBytes);
        await File(tempSnapshotPath).delete();
      } else {
        await File(tempSnapshotPath).copy(finalFile.path);
        await File(tempSnapshotPath).delete();
      }

      await _addBackupVersion('db_snapshot', finalFile.path);
      return finalFile.path;
    } catch (e) {
      throw Exception('Failed to backup database: $e');
    }
  }

  /// 从数据库快照还原（不直接替换主库文件，避免破坏单例连接）
  /// - 解密（如启用）到临时文件
  /// - ATTACH 临时库为 source，将各表 DELETE 后 INSERT INTO SELECT 拷贝
  Future<void> restoreDatabaseSnapshot(String source) async {
    _ensureInitialized();
    try {
      final db = DatabaseService().localDatabase;

      final srcFile = File(source);
      if (!await srcFile.exists()) {
        throw Exception('Backup file not found: $source');
      }

      final tempRestorePath = path.join(
          _backupDirectory.path, 'restore_${DateTime.now().millisecondsSinceEpoch}.sqlite');

      Uint8List dataBytes = await srcFile.readAsBytes();
      if (await isEncryptionEnabled()) {
        try {
          dataBytes = await _encryptionService.decryptData(dataBytes);
        } catch (_) {
          // 如果解密失败，按明文处理备用
        }
      }

      await File(tempRestorePath).writeAsBytes(dataBytes);
      final sanitizedRestore = tempRestorePath.replaceAll("'", "''");

      await db.transaction(() async {
        await db.customStatement("ATTACH DATABASE '$sanitizedRestore' AS source");

        // 自动枚举 source 与 main 的共有业务表
        final srcTablesRows = await db.customSelect(
          "SELECT name FROM source.sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'moor_%' AND name NOT LIKE 'drift_%'",
        ).get();
        final mainTablesRows = await db.customSelect(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'moor_%' AND name NOT LIKE 'drift_%'",
        ).get();

        final srcTables = srcTablesRows
            .map((r) => (r.data['name'] as String).trim())
            .where((name) => name.isNotEmpty)
            .toSet();
        final mainTables = mainTablesRows
            .map((r) => (r.data['name'] as String).trim())
            .where((name) => name.isNotEmpty)
            .toSet();

        final commonTables = srcTables.intersection(mainTables).toList()..sort();

        for (final table in commonTables) {
          final safeTable = table.replaceAll('"', '""');

          // 获取列交集，避免 schema 差异导致失败
          final dstInfo = await db.customSelect("PRAGMA table_info(\"$safeTable\")").get();
          final srcInfo = await db.customSelect("PRAGMA source.table_info(\"$safeTable\")").get();
          final dstCols = dstInfo.map((r) => r.data['name'] as String).toSet();
          final srcCols = srcInfo.map((r) => r.data['name'] as String).toSet();
          final cols = dstCols.intersection(srcCols).toList()..sort();

          if (cols.isEmpty) {
            continue;
          }

          final colsSql = cols.map((c) => '"${c.replaceAll('"', '""')}"').join(', ');

          await db.customStatement('DELETE FROM "$safeTable"');
          await db.customStatement(
              'INSERT INTO "$safeTable" ($colsSql) SELECT $colsSql FROM source."$safeTable"');
        }

        await db.customStatement("DETACH DATABASE source");
      });

      await File(tempRestorePath).delete();
    } catch (e) {
      throw Exception('Failed to restore database snapshot: $e');
    }
  }

  /// 通用 JSON 备份：自动枚举所有业务表并导出为 JSON
  /// - 无需逐表手写映射
  /// - 可选 includeTables / excludeTables 过滤
  /// - 根据加密开关输出明文或加密文件
  Future<String> backupDatabaseJson(
    String destination, {
    List<String>? includeTables,
    List<String>? excludeTables,
  }) async {
    _ensureInitialized();
    try {
      final db = DatabaseService().localDatabase;

      // 列出所有非系统表
      final tableRows = await db.customSelect(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'moor_%' AND name NOT LIKE 'drift_%'",
      ).get();
      final allTables = tableRows
          .map((r) => (r.data['name'] as String).trim())
          .where((name) => name.isNotEmpty)
          .toList();

      // 过滤 include / exclude
      final Set<String> include = includeTables == null
          ? allTables.toSet()
          : allTables.where((t) => includeTables.contains(t)).toSet();
      final Set<String> exclude = (excludeTables ?? const <String>[]).toSet();
      final tables = include.difference(exclude).toList()..sort();

      final Map<String, List<Map<String, dynamic>>> dump = {};

      for (final table in tables) {
        final rows = await db.customSelect('SELECT * FROM $table').get();
        final List<Map<String, dynamic>> list = [];

        for (final row in rows) {
          final Map<String, dynamic> jsonRow = {};
          row.data.forEach((key, value) {
            if (value is Uint8List) {
              // BLOB 转 Base64，确保 JSON 可序列化
              jsonRow[key] = base64Encode(value);
            } else if (value is bool) {
              // 布尔统一为 0/1，保持与表中 int 存储一致性
              jsonRow[key] = value ? 1 : 0;
            } else {
              jsonRow[key] = value;
            }
          });
          list.add(jsonRow);
        }

        dump[table] = list;
      }

      final jsonString = jsonEncode({
        'tables': dump,
        'created_at': DateTime.now().toIso8601String(),
        'device': await _getDefaultDeviceName(),
        'format': 'drift_db_json_v1',
      });

      File outputFile;
      if (destination.isEmpty) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        outputFile = File(path.join(_backupDirectory.path, 'dbjson_$timestamp.json'));
      } else {
        outputFile = File(destination);
      }

      if (await isEncryptionEnabled()) {
        final bytes = Uint8List.fromList(utf8.encode(jsonString));
        final encrypted = await _encryptionService.encryptData(bytes);
        await outputFile.writeAsBytes(encrypted);
      } else {
        await outputFile.writeAsString(jsonString);
      }

      await _addBackupVersion('db_json', outputFile.path);
      return outputFile.path;
    } catch (e) {
      throw Exception('Failed to backup database as JSON: $e');
    }
  }

  /// 通用 JSON 还原：读取 JSON 并逐表插入
  /// - 支持 includeTables / excludeTables 过滤
  /// - 支持 clearBeforeInsert 先清表后插入
  Future<void> restoreDatabaseJson(
    String source, {
    List<String>? includeTables,
    List<String>? excludeTables,
    bool clearBeforeInsert = true,
  }) async {
    _ensureInitialized();
    try {
      final db = DatabaseService().localDatabase;

      final srcFile = File(source);
      if (!await srcFile.exists()) {
        throw Exception('Backup file not found: $source');
      }

      // 读取并解密（如开启加密）
      String jsonString;
      final rawBytes = await srcFile.readAsBytes();
      if (await isEncryptionEnabled()) {
        try {
          final decrypted = await _encryptionService.decryptData(rawBytes);
          jsonString = utf8.decode(decrypted);
        } catch (_) {
          jsonString = utf8.decode(rawBytes);
        }
      } else {
        jsonString = utf8.decode(rawBytes);
      }

      final parsed = jsonDecode(jsonString);
      if (parsed is! Map<String, dynamic> || !parsed.containsKey('tables')) {
        throw Exception('Invalid JSON backup format: missing tables');
      }
      final Map<String, dynamic> tablesData = parsed['tables'] as Map<String, dynamic>;

      // 列出数据库当前所有非系统表（用于校验与列名获取）
      final tableRows = await db.customSelect(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'moor_%' AND name NOT LIKE 'drift_%'",
      ).get();
      final existingTables = tableRows
          .map((r) => (r.data['name'] as String).trim())
          .where((name) => name.isNotEmpty)
          .toSet();

      // 过滤 include / exclude
      final Set<String> include = includeTables == null
          ? tablesData.keys.toSet()
          : tablesData.keys.where((t) => includeTables.contains(t)).toSet();
      final Set<String> exclude = (excludeTables ?? const <String>[]).toSet();
      final restoreTables = include.difference(exclude).toList()..sort();

      await _restoreTablesFromMap(tablesData,
          includeTables: includeTables,
          excludeTables: excludeTables,
          clearBeforeInsert: clearBeforeInsert);
    } catch (e) {
      throw Exception('Failed to restore database from JSON: $e');
    }
  }

  /// 从 Map 数据还原表到当前数据库（自动枚举列与表）
  Future<void> _restoreTablesFromMap(
    Map<String, dynamic> tablesData, {
    List<String>? includeTables,
    List<String>? excludeTables,
    bool clearBeforeInsert = true,
  }) async {
    final db = DatabaseService().localDatabase;

    // 列出现有库所有非系统表
    final tableRows = await db.customSelect(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'moor_%' AND name NOT LIKE 'drift_%'",
    ).get();
    final existingTables = tableRows
        .map((r) => (r.data['name'] as String).trim())
        .where((name) => name.isNotEmpty)
        .toSet();

    final Set<String> include = includeTables == null
        ? tablesData.keys.map((e) => e.toString()).toSet()
        : tablesData.keys.where((t) => includeTables.contains(t)).map((e) => e.toString()).toSet();
    final Set<String> exclude = (excludeTables ?? const <String>[]).toSet();
    final restoreTables = include.difference(exclude).toList()..sort();

    await db.transaction(() async {
      for (final table in restoreTables) {
        if (!existingTables.contains(table)) {
          continue;
        }

        final dynamic value = tablesData[table];
        if (value is! List) {
          continue;
        }

        final pragmaRows = await db
            .customSelect("PRAGMA table_info('${table.replaceAll("'", "''")}')")
            .get();
        final columns = pragmaRows
            .map((r) => r.data['name'] as String)
            .where((c) => c.isNotEmpty)
            .toList();
        final columnSet = columns.toSet();

        if (clearBeforeInsert) {
          await db.customStatement('DELETE FROM $table');
        }

        for (final row in value) {
          if (row is! Map) {
            continue;
          }

          final Map<String, Object?> filtered = {};
          (row as Map).forEach((k, v) {
            final key = k.toString();
            if (columnSet.contains(key)) {
              filtered[key] = v;
            }
          });

          if (filtered.isEmpty) {
            continue;
          }

          final colsSql = filtered.keys.map((k) => '"${k.replaceAll('"', '""')}"').join(', ');
          final valuesSql = filtered.values.map((v) => _toSqlLiteral(v)).join(', ');
          final insertSql = 'INSERT INTO $table ($colsSql) VALUES ($valuesSql)';
          await db.customStatement(insertSql);
        }
      }
    });
  }

  /// 从 Map 还原 SharedPreferences + SecureStorage + ConfigRepository
  Future<void> _restoreSettingsFromMap(Map<String, dynamic> settings) async {
    // 清空现有偏好
    await _preferences.clear();

    // 恢复 SharedPreferences
    for (final entry in settings.entries) {
      if (entry.key != 'secure_storage' && entry.key != 'config_repository_data') {
        final value = entry.value;
        if (value is String) {
          await _preferences.setString(entry.key, value);
        } else if (value is bool) {
          await _preferences.setBool(entry.key, value);
        } else if (value is int) {
          await _preferences.setInt(entry.key, value);
        } else if (value is double) {
          await _preferences.setDouble(entry.key, value);
        } else if (value is List) {
          final list = value.map((e) => e.toString()).toList();
          await _preferences.setStringList(entry.key, list);
        }
      }
    }

    // 恢复 SecureStorage
    if (settings.containsKey('secure_storage')) {
      final Map<String, dynamic> secureItems = settings['secure_storage'] as Map<String, dynamic>;
      await _secureStorage.deleteAll();
      for (final entry in secureItems.entries) {
        await _secureStorage.write(key: entry.key, value: entry.value?.toString());
      }
    }

    // 恢复 ConfigRepository
    if (settings.containsKey('config_repository_data')) {
      try {
        final configData = settings['config_repository_data'];
        if (configData is Map && configData.containsKey('configs')) {
          final configs = configData['configs'] as Map<String, dynamic>;
          for (final entry in configs.entries) {
            if (entry.value is Map<String, dynamic>) {
              await _configBackupService.configRepository.saveConfig(
                entry.key,
                entry.value as Map<String, dynamic>,
              );
            }
          }
        }
      } catch (e) {
        debugPrint('还原ConfigRepository配置数据失败: $e');
      }
    }
  }

  /// 将任意值转换为 SQL 字面量（安全处理引号与 NULL）
  String _toSqlLiteral(Object? value) {
    if (value == null) return 'NULL';
    if (value is bool) return value ? '1' : '0';
    if (value is num) return value.toString();
    if (value is Uint8List) {
      // BLOB 以 Base64 文本存储；恢复时原库列类型若为 BLOB，SQLite 会尝试按文本插入。
      // 绝大多数业务表未使用 BLOB，这里保持通用性。
      final b64 = base64Encode(value);
      return '\'${_escapeSqlString(b64)}\'';
    }
    final s = value.toString();
    return '\'${_escapeSqlString(s)}\'';
  }

  /// 转义 SQL 字符串中的单引号
  String _escapeSqlString(String s) => s.replaceAll("'", "''");
}
