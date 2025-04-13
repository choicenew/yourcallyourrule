import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:notification_manager/data/repositories/local_storage_repository_impl.dart';
import 'package:notification_manager/data/services/backup_encryption_service_impl.dart';
import 'package:notification_manager/domain/entities/backup_config_entity.dart';
import 'package:notification_manager/domain/entities/backup_version_entity.dart';
import 'package:notification_manager/domain/entities/notification_entity.dart';
import 'package:notification_manager/domain/entities/rule_entity.dart';
import 'package:notification_manager/domain/repositories/local_storage_repository.dart';
import 'package:notification_manager/domain/services/backup_encryption_service.dart';
import 'package:notification_manager/domain/services/backup_restore_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as path;

class BackupRestoreServiceImpl implements BackupRestoreService {
  late final Directory _backupDirectory;
  late final SharedPreferences _preferences;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _isInitialized = false;
  
  // Encryption service
  final BackupEncryptionService _encryptionService = BackupEncryptionServiceImpl();
  
  static const String _backupConfigKey = 'backup_config';
  static const String _backupVersionsKey = 'backup_versions';
  static const String _encryptionEnabledKey = 'backup_encryption_enabled';
  
  @override
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
  
  @override
  Future<void> updateBackupConfig(BackupConfigEntity config) async {
    _ensureInitialized();
    
    // Update encryption settings if changed
    if (config.encryptionEnabled != await isEncryptionEnabled()) {
      await setEncryptionEnabled(config.encryptionEnabled);
    }
    
    await _preferences.setString(_backupConfigKey, jsonEncode(config.toJson()));
  }
  
  @override
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
  
  @override
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
  
  @override
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
  
  @override
  Future<String> backupRules(List<RuleEntity> rules, String destination) async {
    _ensureInitialized();
    
    final rulesJson = rules.map((rule) => rule.toJson()).toList();
    final jsonString = jsonEncode(rulesJson);
    
    File backupFile;
    if (destination.isEmpty) {
      // Use default location if no destination provided
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      backupFile = File(path.join(_backupDirectory.path, 'rules_$timestamp.json'));
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
    await _addBackupVersion('rules', backupFile.path);
    
    return backupFile.path;
  }
  
  @override
  Future<List<RuleEntity>> restoreRules(String source) async {
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
          final decryptedBytes = await _encryptionService.decryptData(encryptedBytes);
          jsonString = utf8.decode(decryptedBytes);
        } catch (e) {
          // If decryption fails, try reading as plain text
          jsonString = await backupFile.readAsString();
        }
      } else {
        // Read as plain text
        jsonString = await backupFile.readAsString();
      }
      
      final List<dynamic> rulesJson = jsonDecode(jsonString);
      return rulesJson.map((json) => RuleEntity.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to restore rules: ${e.toString()}');
    }
  }
  
  @override
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
    
    final jsonString = jsonEncode(settings);
    
    File backupFile;
    if (destination.isEmpty) {
      // Use default location if no destination provided
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      backupFile = File(path.join(_backupDirectory.path, 'settings_$timestamp.json'));
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
  
  @override
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
          final decryptedBytes = await _encryptionService.decryptData(encryptedBytes);
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
        if (entry.key != 'secure_storage') {
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
      
      return true;
    } catch (e) {
      throw Exception('Failed to restore settings: ${e.toString()}');
    }
  }
  
  @override
  Future<String> backupNotificationHistory(String destination, {DateTime? startDate, DateTime? endDate}) async {
    _ensureInitialized();
    
    // Get instance of local storage repository
    final localStorageRepository = await _getLocalStorageRepository();
    
    // Fetch notifications from the repository based on date range
    final notifications = await localStorageRepository.getNotifications(
      startTime: startDate,
      endTime: endDate,
    );
    
    // Convert notifications to JSON
    final notificationsJson = notifications.map((notification) => notification.toJson()).toList();
    final jsonString = jsonEncode(notificationsJson);
    
    // Determine backup file path
    File backupFile;
    if (destination.isEmpty) {
      // Use default location if no destination provided
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      backupFile = File(path.join(_backupDirectory.path, 'notifications_$timestamp.json'));
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
    await _addBackupVersion('notifications', backupFile.path);
    
    return backupFile.path;
  }
  
  @override
  Future<bool> restoreNotificationHistory(String source) async {
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
          final decryptedBytes = await _encryptionService.decryptData(encryptedBytes);
          jsonString = utf8.decode(decryptedBytes);
        } catch (e) {
          // If decryption fails, try reading as plain text
          jsonString = await backupFile.readAsString();
        }
      } else {
        // Read as plain text
        jsonString = await backupFile.readAsString();
      }
      
      final List<dynamic> notificationsJson = jsonDecode(jsonString);
      
      // Restore notifications to repository
      final LocalStorageRepository repository = LocalStorageRepositoryImpl();
      await repository.initialize();
      
      // Clear existing notifications first
      await repository.clearAllNotifications();
      
      // Add restored notifications
      for (final json in notificationsJson) {
        await repository.saveNotification(NotificationEntity.fromJson(json));
      }
      
      return true;
    } catch (e) {
      throw Exception('Failed to restore notification history: ${e.toString()}');
    }
  }
  
  @override
  Future<bool> scheduleAutomaticBackup(Duration interval, String destination) async {
    _ensureInitialized();
    
    // Store backup schedule in preferences
    await _preferences.setInt('backup_interval_ms', interval.inMilliseconds);
    await _preferences.setString('backup_destination', destination);
    await _preferences.setInt('last_backup_time', DateTime.now().millisecondsSinceEpoch);
    
    // Note: Actual scheduling would require a background service or periodic task
    // which is beyond the scope of this implementation
    
    return true;
  }
  
  @override
  Future<bool> cancelAutomaticBackup() async {
    _ensureInitialized();
    
    // Remove backup schedule from preferences
    await _preferences.remove('backup_interval_ms');
    await _preferences.remove('backup_destination');
    await _preferences.remove('last_backup_time');
    
    return true;
  }
  
  @override
  Future<List<String>> getAvailableBackups() async {
    _ensureInitialized();
    
    final files = await _backupDirectory.list().toList();
    return files
        .whereType<File>()
        .map((file) => file.path)
        .where((path) => path.endsWith('.json'))
        .toList();
  }
  
  @override
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
  
  @override
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
      throw Exception('BackupRestoreService not initialized. Call initialize() first.');
    }
  }
  
  Future<LocalStorageRepository> _getLocalStorageRepository() async {
    final repository = LocalStorageRepositoryImpl();
    await repository.initialize();
    return repository;
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
  
  @override
  String get serviceType => 'local';
  
  @override
  String get serviceName => 'Local Backup Service';
}