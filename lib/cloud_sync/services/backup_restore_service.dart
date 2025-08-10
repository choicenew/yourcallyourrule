import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/cloud_sync/entities/backup_config_entity.dart';
import 'package:yourcallyourrule/cloud_sync/entities/backup_version_entity.dart';
import 'package:yourcallyourrule/cloud_sync/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/data/repositories/config/config_backup_service.dart';

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
  final RuleImportExportService _ruleImportExportService;
  final ConfigBackupService _configBackupService;

  BackupRestoreService(
    this._encryptionService,
    this._ruleImportExportService,
    this._configBackupService,
  );

  // Encryption service initialization

  static const String _backupConfigKey = 'backup_config';
  static const String _backupVersionsKey = 'backup_versions';

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

    // Initialize rule import/export service

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

    final file = await _ruleImportExportService.exportRulePackage(
        destination.isNotEmpty
            ? destination
            : path.join(_backupDirectory.path,
                'rules_${DateTime.now().millisecondsSinceEpoch}.json'),
        includeLabels: false,
        includeLocations: false,
        includeConfigs: false);

    await _addBackupVersion('rules', file.path);
    return file.path;
  }
  
  /// 备份配置数据
  /// [destination] 备份文件路径，如果为空则使用默认路径
  /// [configKeys] 要备份的配置键列表，如果为空则备份所有配置
  Future<String> backupConfigs(String destination, {List<String>? configKeys}) async {
    _ensureInitialized();
    
    final file = await _ruleImportExportService.exportRulePackage(
        destination.isNotEmpty
            ? destination
            : path.join(_backupDirectory.path,
                'configs_${DateTime.now().millisecondsSinceEpoch}.json'),
        includeLabels: false,
        includeLocations: false,
        includeRules: false,
        includeConfigs: true,
        configKeys: configKeys);

    await _addBackupVersion('configs', file.path);
    return file.path;
  }
  
  /// 备份所有数据（规则、标签、位置和配置）
  Future<String> backupAll(String destination) async {
    _ensureInitialized();
    
    final file = await _ruleImportExportService.exportRulePackage(
        destination.isNotEmpty
            ? destination
            : path.join(_backupDirectory.path,
                'all_${DateTime.now().millisecondsSinceEpoch}.json'),
        includeLabels: true,
        includeLocations: true,
        includeConfigs: true);

    await _addBackupVersion('all', file.path);
    return file.path;
  }

  Future<List<RuleBase>> restoreRules(String source) async {
    _ensureInitialized();
    await _ruleImportExportService.importRulePackage(
      File(source),
      importRules: true,
      importLabels: false,
      importLocations: false,
      importConfigs: false
    );
    return _ruleImportExportService.storage.loadRules();
  }
  
  /// 还原配置数据
  /// [source] 备份文件路径
  /// [configKeys] 要还原的配置键列表，如果为空则还原所有配置
  Future<void> restoreConfigs(String source, {List<String>? configKeys}) async {
    _ensureInitialized();
    await _ruleImportExportService.importRulePackage(
      File(source),
      importRules: false,
      importLabels: false,
      importLocations: false,
      importConfigs: true,
      configKeys: configKeys
    );
  }
  
  /// 还原所有数据（规则、标签、位置和配置）
  Future<void> restoreAll(String source) async {
    _ensureInitialized();
    await _ruleImportExportService.importRulePackage(
      File(source),
      importRules: true,
      importLabels: true,
      importLocations: true,
      importConfigs: true
    );
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
      version: DateTime.now().millisecondsSinceEpoch.toString(),
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
}
