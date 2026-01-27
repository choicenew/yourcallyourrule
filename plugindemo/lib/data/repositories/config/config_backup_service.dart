import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:plugindemo/data/repositories/config/config_cloud_converter.dart';
import 'package:plugindemo/data/repositories/config/config_repository.dart';

/// 配置备份还原服务
/// 负责将ConfigRepository中的配置数据进行备份和还原
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

  /// 初始化服务
  Future<void> initialize() async {
    if (_isInitialized) return;

    // 获取应用文档目录
    final appDocDir = await getApplicationDocumentsDirectory();
    _backupDirectory = Directory(path.join(appDocDir.path, 'config_backups'));

    // 创建备份目录（如果不存在）
    if (!await _backupDirectory.exists()) {
      await _backupDirectory.create(recursive: true);
    }

    // 初始化SharedPreferences
    _preferences = await SharedPreferences.getInstance();

    _isInitialized = true;
  }

  /// 确保服务已初始化
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError('ConfigBackupService未初始化，请先调用initialize()');
    }
  }

  /// 获取所有配置键
  Future<List<String>> getAllConfigKeys() async {
    _ensureInitialized();
    
    // 使用ConfigCloudConverter获取所有配置键，包括特定模块的配置键
    return await _cloudConverter.getAllConfigKeys();
  }

  /// 备份所有配置
  /// [destination] 可选的目标路径，如果为空则使用默认路径
  /// 返回备份文件路径
  Future<String> backupAllConfigs({String? destination}) async {
    _ensureInitialized();

    // 获取所有配置键
    final configKeys = await getAllConfigKeys();
    
    // 收集所有配置数据
    final Map<String, dynamic> allConfigs = {};
    for (final key in configKeys) {
      final config = await _configRepository.getConfig(key);
      if (config != null) {
        allConfigs[key] = config;
      }
    }

    // 序列化配置数据
    final backupData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'configs': allConfigs,
    };

    final jsonString = jsonEncode(backupData);

    // 创建备份文件
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupFile = File(destination ?? 
        path.join(_backupDirectory.path, 'config_backup_$timestamp.json'));
    
    await backupFile.writeAsString(jsonString);
    
    // 记录备份版本
    await _addBackupVersion(backupFile.path);
    
    return backupFile.path;
  }

  /// 备份指定配置
  /// [keys] 要备份的配置键列表
  /// [destination] 可选的目标路径，如果为空则使用默认路径
  /// 返回备份文件路径
  Future<String> backupConfigs(List<String> keys, {String? destination}) async {
    _ensureInitialized();
    
    // 收集指定的配置数据
    final Map<String, dynamic> selectedConfigs = {};
    for (final key in keys) {
      final config = await _configRepository.getConfig(key);
      if (config != null) {
        selectedConfigs[key] = config;
      }
    }

    // 序列化配置数据
    final backupData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'configs': selectedConfigs,
    };

    final jsonString = jsonEncode(backupData);

    // 创建备份文件
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupFile = File(destination ?? 
        path.join(_backupDirectory.path, 'config_backup_$timestamp.json'));
    
    await backupFile.writeAsString(jsonString);
    
    // 记录备份版本
    await _addBackupVersion(backupFile.path);
    
    return backupFile.path;
  }

  /// 从备份文件还原所有配置
  /// [source] 备份文件路径
  Future<void> restoreAllConfigs(String source) async {
    _ensureInitialized();
    
    final backupFile = File(source);
    if (!await backupFile.exists()) {
      throw FileSystemException('备份文件不存在', source);
    }
    
    try {
      final jsonString = await backupFile.readAsString();
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;
      
      final configs = backupData['configs'] as Map<String, dynamic>;
      
      // 还原所有配置
      for (final entry in configs.entries) {
        await _configRepository.saveConfig(
          entry.key, 
          entry.value as Map<String, dynamic>
        );
      }
    } catch (e) {
      debugPrint('还原配置失败: $e');
      rethrow;
    }
  }

  /// 从备份文件还原指定配置
  /// [source] 备份文件路径
  /// [keys] 要还原的配置键列表，如果为空则还原所有
  Future<void> restoreConfigs(String source, {List<String>? keys}) async {
    _ensureInitialized();
    
    final backupFile = File(source);
    if (!await backupFile.exists()) {
      throw FileSystemException('备份文件不存在', source);
    }
    
    try {
      final jsonString = await backupFile.readAsString();
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;
      
      final configs = backupData['configs'] as Map<String, dynamic>;
      
      // 如果指定了键，只还原这些键
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
        // 否则还原所有配置
        await restoreAllConfigs(source);
      }
    } catch (e) {
      debugPrint('还原配置失败: $e');
      rethrow;
    }
  }

  /// 获取备份版本列表
  Future<List<Map<String, dynamic>>> getBackupVersions() async {
    _ensureInitialized();

    final versionsJson = _preferences.getString(_configBackupVersionsKey);
    if (versionsJson != null) {
      final List<dynamic> list = jsonDecode(versionsJson);
      return list.cast<Map<String, dynamic>>();
    }
    return [];
  }

  /// 添加备份版本记录
  Future<void> _addBackupVersion(String filePath) async {
    final versions = await getBackupVersions();
    
    versions.add({
      'path': filePath,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'filename': path.basename(filePath),
    });
    
    await _preferences.setString(_configBackupVersionsKey, jsonEncode(versions));
  }

  /// 删除备份版本记录
  Future<void> deleteBackupVersion(String filePath) async {
    _ensureInitialized();
    
    final versions = await getBackupVersions();
    versions.removeWhere((version) => version['path'] == filePath);
    
    await _preferences.setString(_configBackupVersionsKey, jsonEncode(versions));
    
    // 删除备份文件
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// 清除所有备份
  Future<void> clearAllBackups() async {
    _ensureInitialized();
    
    final versions = await getBackupVersions();
    
    // 删除所有备份文件
    for (final version in versions) {
      final filePath = version['path'] as String;
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    
    // 清除版本记录
    await _preferences.remove(_configBackupVersionsKey);
  }
}