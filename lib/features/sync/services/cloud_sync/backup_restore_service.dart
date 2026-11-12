import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/features/sync/domain/backup_config_entity.dart';
import 'package:yourcallyourrule/features/sync/domain/backup_version_entity.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_backup_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_import_export_service.dart';

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

  final BackupEncryptionService _encryptionService;
  final ConfigBackupService _configBackupService;
  final RuleImportExportService? _rulesImportExportService;

  RuleImportExportService get rulesImportExportService {
    if (_rulesImportExportService == null) {
      throw Exception('RuleImportExportService not provided');
    }
    return _rulesImportExportService!;
  }

  BackupRestoreService(
    this._encryptionService,
    this._configBackupService, {
    RuleImportExportService? rulesImportExportService,
  }) : _rulesImportExportService = rulesImportExportService;

  static const String _backupConfigKey = 'config_backup_config';
  static const String _backupVersionsKey = 'config_backup_versions';

  Future<BackupConfigEntity> getBackupConfig() async {
    await _ensureInitialized();

    final configJson = _preferences.getString(_backupConfigKey);
    if (configJson != null) {
      return BackupConfigEntity(
        keepAllVersions: false,
        deviceName: await _getDefaultDeviceName(),
        encryptionEnabled: await isEncryptionEnabled(),
      );
    }

    return BackupConfigEntity(
      keepAllVersions: false,
      deviceName: await _getDefaultDeviceName(),
      encryptionEnabled: await isEncryptionEnabled(),
    );
  }

  Future<void> updateBackupConfig(BackupConfigEntity config) async {
    await _ensureInitialized();

    if (config.encryptionEnabled != await isEncryptionEnabled()) {
      await setEncryptionEnabled(config.encryptionEnabled);
    }
  }

  Future<List<BackupVersionEntity>> getBackupVersions() async {
    await _ensureInitialized();

    final versionsJson = _preferences.getString(_backupVersionsKey);
    if (versionsJson != null) {
      final List<dynamic> list = jsonDecode(versionsJson);
      return list.map((json) => BackupVersionEntity.fromJson(json as Map<String, dynamic>)).toList();
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

  Future<void>? _initializeFuture;

  Future<void> initialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    _initializeFuture ??= _doInitialize(config);
    await _initializeFuture;
  }

  Future<void> _doInitialize(Map<String, dynamic> config) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    _backupDirectory = Directory(path.join(appDocDir.path, 'backups'));

    if (!await _backupDirectory.exists()) {
      await _backupDirectory.create(recursive: true);
    }

    _preferences = await SharedPreferences.getInstance();

    await _encryptionService.initialize();

    _isInitialized = true;
  }

  Future<bool> isConfigured() async {
    return _isInitialized;
  }

  Future<bool> isEncryptionEnabled() async {
    return await _encryptionService.isEncryptionEnabled();
  }

  Future<void> setEncryptionEnabled(bool enabled) async {
    await _encryptionService.setEncryptionEnabled(enabled);
  }

  Future<void> setEncryptionPassword(String password) async {
    await _encryptionService.setEncryptionPassword(password);
  }

  Future<bool> validateEncryptionPassword(String password) async {
    return await _encryptionService.validatePassword(password);
  }

  Future<void> clearEncryptionSettings() async {
    await _encryptionService.clearEncryptionSettings();
  }

  Future<String> backupRules(List<PhoneRuleEntity> rules, String destination) async {
    await _ensureInitialized();
    try {
      final db = LocalDatabase();

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

  Future<String> backupConfigs(String destination, {List<String>? configKeys}) async {
    await _ensureInitialized();
    try {
      final keys = (configKeys != null && configKeys.isNotEmpty)
          ? configKeys
          : await _configBackupService.getAllConfigKeys();

      final Map<String, dynamic> selectedConfigs = {};
      for (final key in keys) {
        final cfg = await _configBackupService.configRepository.getConfig(key);
        if (cfg != null) {
          selectedConfigs[key] = cfg;
        }
      }

      final backupData = {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'configs': selectedConfigs,
      };
      final jsonString = jsonEncode(backupData);

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

  Future<String> backupAll(String destination) async {
    await _ensureInitialized();

    try {
      final db = LocalDatabase();

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

      final Map<String, dynamic> settings = {};
      final allPrefs = _preferences.getKeys();
      for (final key in allPrefs) {
        if (_preferences.containsKey(key)) {
          settings[key] = _preferences.get(key);
        }
      }
      final secureItems = await _secureStorage.readAll();
      settings['secure_storage'] = secureItems;
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
        debugPrint('Failed to get ConfigRepository data: $e');
      }

      final jsonString = jsonEncode({
        'tables': dumpTables,
        'settings': settings,
        'created_at': DateTime.now().toIso8601String(),
        'device': await _getDefaultDeviceName(),
        'format': 'drift_db_all_v1',
      });

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

  Future<List<PhoneRuleEntity>> restoreRules(String source) async {
    await _ensureInitialized();

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
      await restoreDatabaseJson(source);
    }

    return const [];
  }

  Future<void> restoreConfigs(String source, {List<String>? configKeys}) async {
    await _ensureInitialized();
    await _configBackupService.restoreConfigs(source, keys: configKeys);
  }

  Future<void> restoreAll(String source) async {
    await _ensureInitialized();

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
    }

    if (parsed.containsKey('settings')) {
      final settings = parsed['settings'] as Map<String, dynamic>;
      await _restoreSettingsFromMap(settings);
    }
  }

  Future<String> prepareSettingsBackup() async {
    await _ensureInitialized();

    final allPrefs = _preferences.getKeys();
    final Map<String, dynamic> settings = {};

    for (final key in allPrefs) {
      if (_preferences.containsKey(key)) {
        final value = _preferences.get(key);
        settings[key] = value;
      }
    }

    final secureItems = await _secureStorage.readAll();
    settings['secure_storage'] = secureItems;

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
      debugPrint('Failed to get ConfigRepository data: $e');
    }

    final jsonString = jsonEncode(settings);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final tempFile = File(path.join(_backupDirectory.path, 'temp_settings_$timestamp.json'));

    if (await isEncryptionEnabled()) {
      final bytes = Uint8List.fromList(utf8.encode(jsonString));
      final encryptedBytes = await _encryptionService.encryptData(bytes);
      await tempFile.writeAsBytes(encryptedBytes);
    } else {
      await tempFile.writeAsString(jsonString);
    }

    return tempFile.path;
  }

  Future<String> backupSettings(String destination) async {
    await _ensureInitialized();

    final allPrefs = _preferences.getKeys();
    final Map<String, dynamic> settings = {};

    for (final key in allPrefs) {
      if (_preferences.containsKey(key)) {
        final value = _preferences.get(key);
        settings[key] = value;
      }
    }

    final secureItems = await _secureStorage.readAll();
    settings['secure_storage'] = secureItems;

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
      debugPrint('Failed to get ConfigRepository data: $e');
    }

    final jsonString = jsonEncode(settings);

    File backupFile;
    if (destination.isEmpty) {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      backupFile =
          File(path.join(_backupDirectory.path, 'settings_$timestamp.json'));
    } else {
      backupFile = File(destination);
    }

    if (await isEncryptionEnabled()) {
      final bytes = Uint8List.fromList(utf8.encode(jsonString));
      final encryptedBytes = await _encryptionService.encryptData(bytes);
      await backupFile.writeAsBytes(encryptedBytes);
    } else {
      await backupFile.writeAsString(jsonString);
    }

    await _addBackupVersion('settings', backupFile.path);

    return backupFile.path;
  }

  Future<bool> restoreSettings(String source) async {
    await _ensureInitialized();

    final backupFile = File(source);
    if (!await backupFile.exists()) {
      throw Exception('Backup file not found: $source');
    }

    String jsonString;

    try {
      if (await isEncryptionEnabled()) {
        final encryptedBytes = await backupFile.readAsBytes();

        try {
          final decryptedBytes =
              await _encryptionService.decryptData(encryptedBytes);
          jsonString = utf8.decode(decryptedBytes);
        } catch (e) {
          jsonString = await backupFile.readAsString();
        }
      } else {
        jsonString = await backupFile.readAsString();
      }

      final Map<String, dynamic> settings = jsonDecode(jsonString);

      await _preferences.clear();

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

      if (settings.containsKey('secure_storage')) {
        final Map<String, dynamic> secureItems = settings['secure_storage'];
        await _secureStorage.deleteAll();
        for (final entry in secureItems.entries) {
          await _secureStorage.write(key: entry.key, value: entry.value);
        }
      }

      if (settings.containsKey('config_repository_data')) {
        try {
          final configData = settings['config_repository_data'];
          
          if (configData is Map && configData.containsKey('configs')) {
            final configs = configData['configs'] as Map<String, dynamic>;
            
            for (final entry in configs.entries) {
              if (entry.value is Map<String, dynamic>) {
                await _configBackupService.configRepository.saveConfig(
                  entry.key, 
                  entry.value as Map<String, dynamic>
                );
              }
            }
          }
        } catch (e) {
          debugPrint('Failed to restore ConfigRepository data: $e');
        }
      }

      return true;
    } catch (e) {
      throw Exception('Failed to restore settings: ${e.toString()}');
    }
  }

  Future<bool> scheduleAutomaticBackup(
      Duration interval, String destination) async {
    await _ensureInitialized();

    await _preferences.setInt('backup_interval_ms', interval.inMilliseconds);
    await _preferences.setString('backup_destination', destination);
    await _preferences.setInt(
        'last_backup_time', DateTime.now().millisecondsSinceEpoch);

    return true;
  }

  Future<bool> cancelAutomaticBackup() async {
    await _ensureInitialized();

    await _preferences.remove('backup_interval_ms');
    await _preferences.remove('backup_destination');
    await _preferences.remove('last_backup_time');

    return true;
  }

  Future<List<String>> getAvailableBackups() async {
    await _ensureInitialized();

    final files = await _backupDirectory.list().toList();
    return files
        .whereType<File>()
        .map((file) => file.path)
        .where((path) => path.endsWith('.json'))
        .toList();
  }

  Future<String> selectBackupFile() async {
    await _ensureInitialized();

    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      dialogTitle: 'Select backup file',
    );

    if (result == null || result.files.isEmpty) {
      throw Exception('No file selected');
    }

    return result.files.first.path!;
  }

  Future<String> selectBackupDestination(Uint8List bytes) async {
    await _ensureInitialized();

    final result = await FilePicker.saveFile(
      dialogTitle: 'Save backup file',
      fileName: 'backup_${DateTime.now().millisecondsSinceEpoch}.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
      bytes: bytes,
    );

    if (result == null) {
      throw Exception('No destination selected');
    }

    return result;
  }

  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize({});
    }
  }

  Future<void> _addBackupVersion(String backupType, String filePath) async {
    await _ensureInitialized();

    final versions = await getBackupVersions();

    final newVersion = BackupVersionEntity(
      version: const Uuid().v4(),
      backupTime: DateTime.now(),
      deviceName: (await getBackupConfig()).deviceName,
      filePath: filePath,
      backupType: backupType,
    );

    versions.add(newVersion);

    final versionsJson = versions.map((v) => v.toJson()).toList();
    await _preferences.setString(_backupVersionsKey, jsonEncode(versionsJson));
  }

  String get serviceType => 'local';

  String get serviceName => 'Local Backup Service';

  Future<String> backupDatabaseSnapshot(String destination) async {
    await _ensureInitialized();
    try {
      final db = LocalDatabase();

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final tempSnapshotPath =
          path.join(_backupDirectory.path, 'db_$timestamp.sqlite');

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

  Future<void> restoreDatabaseSnapshot(String source) async {
    await _ensureInitialized();
    try {
      final db = LocalDatabase();

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
        } catch (_) {}
      }

      await File(tempRestorePath).writeAsBytes(dataBytes);
      final sanitizedRestore = tempRestorePath.replaceAll("'", "''");

      await db.transaction(() async {
        await db.customStatement("ATTACH DATABASE '$sanitizedRestore' AS source");

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

  Future<String> backupDatabaseJson(
    String destination, {
    List<String>? includeTables,
    List<String>? excludeTables,
  }) async {
    await _ensureInitialized();
    try {
      final db = LocalDatabase();

      final tableRows = await db.customSelect(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'moor_%' AND name NOT LIKE 'drift_%'",
      ).get();
      final allTables = tableRows
          .map((r) => (r.data['name'] as String).trim())
          .where((name) => name.isNotEmpty)
          .toList();

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
        'format': 'drift_db_json_v1',
      });

      File outputFile;
      if (destination.isNotEmpty) {
        outputFile = File(destination);
      } else {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        outputFile = File(path.join(_backupDirectory.path, 'dbjson_$timestamp.json'));
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

  Future<void> restoreDatabaseJson(
    String source, {
    List<String>? includeTables,
    List<String>? excludeTables,
    bool clearBeforeInsert = true,
  }) async {
    await _ensureInitialized();
    try {
      final db = LocalDatabase();

      final srcFile = File(source);
      if (!await srcFile.exists()) {
        throw Exception('Backup file not found: $source');
      }

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

      await _restoreTablesFromMap(tablesData,
          includeTables: includeTables,
          excludeTables: excludeTables,
          clearBeforeInsert: clearBeforeInsert);
    } catch (e) {
      throw Exception('Failed to restore database from JSON: $e');
    }
  }

  Future<void> _restoreTablesFromMap(
    Map<String, dynamic> tablesData, {
    List<String>? includeTables,
    List<String>? excludeTables,
    bool clearBeforeInsert = true,
  }) async {
    final db = LocalDatabase();

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
          row.forEach((k, v) {
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

  Future<void> _restoreSettingsFromMap(Map<String, dynamic> settings) async {
    await _preferences.clear();

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

    if (settings.containsKey('secure_storage')) {
      final Map<String, dynamic> secureItems = settings['secure_storage'] as Map<String, dynamic>;
      await _secureStorage.deleteAll();
      for (final entry in secureItems.entries) {
        await _secureStorage.write(key: entry.key, value: entry.value?.toString());
      }
    }

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
        debugPrint('Failed to restore ConfigRepository data: $e');
      }
    }
  }

  String _toSqlLiteral(Object? value) {
    if (value == null) return 'NULL';
    if (value is bool) return value ? '1' : '0';
    if (value is num) return value.toString();
    if (value is Uint8List) {
      final b64 = base64Encode(value);
      return '\'${_escapeSqlString(b64)}\'';
    }
    final s = value.toString();
    return '\'${_escapeSqlString(s)}\'';
  }

  String _escapeSqlString(String s) => s.replaceAll("'", "''");
}
