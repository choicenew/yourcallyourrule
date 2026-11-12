import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yourcallyourrule/features/config/data/repositories/config_cloud_converter.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

part 'config_backup_service.g.dart';

@Riverpod(keepAlive: true)
ConfigBackupService configBackupService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  final service = ConfigBackupService(configRepository);
  service.initialize();
  return service;
}

class ConfigBackupService {
  final ConfigRepository _configRepository;
  late final Directory _backupDirectory;
  late final SharedPreferences _preferences;
  late final ConfigCloudConverter _cloudConverter;
  bool _isInitialized = false;

  static const String _configBackupVersionsKey = 'config_backup_versions';

  ConfigBackupService(this._configRepository) {
    _cloudConverter = ConfigCloudConverter(_configRepository);
  }

  ConfigRepository get configRepository => _configRepository;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final appDocDir = await getApplicationDocumentsDirectory();
    _backupDirectory = Directory(path.join(appDocDir.path, 'config_backups'));

    if (!await _backupDirectory.exists()) {
      await _backupDirectory.create(recursive: true);
    }

    _preferences = await SharedPreferences.getInstance();

    _isInitialized = true;
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError('ConfigBackupService not initialized');
    }
  }

  Future<List<String>> getAllConfigKeys() async {
    _ensureInitialized();
    return await _cloudConverter.getAllConfigKeys();
  }

  Future<String> backupAllConfigs({String? destination}) async {
    _ensureInitialized();

    final configKeys = await getAllConfigKeys();
    
    final Map<String, dynamic> allConfigs = {};
    for (final key in configKeys) {
      final config = await _configRepository.getConfig(key);
      if (config != null) {
        allConfigs[key] = config;
      }
    }

    final backupData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'configs': allConfigs,
    };

    final jsonString = jsonEncode(backupData);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupFile = File(destination ?? 
        path.join(_backupDirectory.path, 'config_backup_$timestamp.json'));
    
    await backupFile.writeAsString(jsonString);
    
    await _addBackupVersion(backupFile.path);
    
    return backupFile.path;
  }

  Future<String> backupConfigs(List<String> keys, {String? destination}) async {
    _ensureInitialized();
    
    final Map<String, dynamic> selectedConfigs = {};
    for (final key in keys) {
      final config = await _configRepository.getConfig(key);
      if (config != null) {
        selectedConfigs[key] = config;
      }
    }

    final backupData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'configs': selectedConfigs,
    };

    final jsonString = jsonEncode(backupData);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupFile = File(destination ?? 
        path.join(_backupDirectory.path, 'config_backup_$timestamp.json'));
    
    await backupFile.writeAsString(jsonString);
    
    await _addBackupVersion(backupFile.path);
    
    return backupFile.path;
  }

  Future<void> restoreAllConfigs(String source) async {
    _ensureInitialized();
    
    final backupFile = File(source);
    if (!await backupFile.exists()) {
      throw FileSystemException('Backup file not found', source);
    }
    
    try {
      final jsonString = await backupFile.readAsString();
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;
      
      final configs = backupData['configs'] as Map<String, dynamic>;
      
      for (final entry in configs.entries) {
        await _configRepository.saveConfig(
          entry.key, 
          entry.value as Map<String, dynamic>
        );
      }
    } catch (e) {
      debugPrint('Restore config failed: $e');
      rethrow;
    }
  }

  Future<void> restoreConfigs(String source, {List<String>? keys}) async {
    _ensureInitialized();
    
    final backupFile = File(source);
    if (!await backupFile.exists()) {
      throw FileSystemException('Backup file not found', source);
    }
    
    try {
      final jsonString = await backupFile.readAsString();
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;
      
      final configs = backupData['configs'] as Map<String, dynamic>;
      
      if (keys != null && keys.isNotEmpty) {
        for (final key in keys) {
          if (configs.containsKey(key)) {
            await _configRepository.saveConfig(
              key, 
              configs[key] as Map<String, dynamic>
            );
          }
        }
      } else {
        await restoreAllConfigs(source);
      }
    } catch (e) {
      debugPrint('Restore config failed: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getBackupVersions() async {
    _ensureInitialized();

    final versionsJson = _preferences.getString(_configBackupVersionsKey);
    if (versionsJson != null) {
      final List<dynamic> list = jsonDecode(versionsJson);
      return list.cast<Map<String, dynamic>>();
    }
    return [];
  }

  Future<void> _addBackupVersion(String filePath) async {
    final versions = await getBackupVersions();
    
    versions.add({
      'path': filePath,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'filename': path.basename(filePath),
    });
    
    await _preferences.setString(_configBackupVersionsKey, jsonEncode(versions));
  }

  Future<void> deleteBackupVersion(String filePath) async {
    _ensureInitialized();
    
    final versions = await getBackupVersions();
    versions.removeWhere((version) => version['path'] == filePath);
    
    await _preferences.setString(_configBackupVersionsKey, jsonEncode(versions));
    
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> clearAllBackups() async {
    _ensureInitialized();
    
    final versions = await getBackupVersions();
    
    for (final version in versions) {
      final filePath = version['path'] as String;
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    
    await _preferences.remove(_configBackupVersionsKey);
  }
}
