import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import 'config_cloud_converter.dart';
import 'config_repository.dart';

/// 配置备份还原服务
/// 负责将 ConfigRepository 中的配置数据导出为本地磁盘 JSON 快照或还原
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
  ConfigCloudConverter get cloudConverter => _cloudConverter;

  /// 初始化服务
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
      throw StateError('ConfigBackupService 未初始化，请先调用 initialize()');
    }
  }

  /// 获取底层感知到的全量配置 Key 列表
  Future<List<String>> getAllConfigKeys() async {
    return await _cloudConverter.getAllConfigKeys();
  }

  /// 导出备份 Payload Map（零文件 I/O，可直接传递给 clouddrive 等第三方加密云盘组件）
  Future<Map<String, dynamic>> exportBackupPayload({List<String>? keys}) async {
    return await _cloudConverter.convertToCloudFormat(configKeys: keys);
  }

  /// 从 Payload Map 恢复配置
  Future<void> importBackupPayload(Map<String, dynamic> payload, {List<String>? keys}) async {
    await _cloudConverter.restoreFromCloudFormat(payload, configKeys: keys);
  }

  /// 备份全量配置导出到本地磁盘 `.json` 文件
  Future<String> backupAllConfigs({String? destination}) async {
    _ensureInitialized();

    final payload = await exportBackupPayload();
    final jsonString = jsonEncode(payload);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupFile = File(
      destination ??
          path.join(_backupDirectory.path, 'config_backup_$timestamp.json'),
    );

    await backupFile.writeAsString(jsonString);
    await _addBackupVersion(backupFile.path);

    return backupFile.path;
  }

  /// 备份指定配置导出到本地磁盘 `.json` 文件
  Future<String> backupConfigs(List<String> keys, {String? destination}) async {
    _ensureInitialized();

    final payload = await exportBackupPayload(keys: keys);
    final jsonString = jsonEncode(payload);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupFile = File(
      destination ??
          path.join(_backupDirectory.path, 'config_backup_$timestamp.json'),
    );

    await backupFile.writeAsString(jsonString);
    await _addBackupVersion(backupFile.path);

    return backupFile.path;
  }

  /// 从本地 `.json` 备份文件还原所有配置
  Future<void> restoreAllConfigs(String source) async {
    _ensureInitialized();

    final backupFile = File(source);
    if (!await backupFile.exists()) {
      throw FileSystemException('备份文件不存在', source);
    }

    try {
      final jsonString = await backupFile.readAsString();
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;
      await importBackupPayload(backupData);
    } catch (e) {
      debugPrint('还原配置失败: $e');
      rethrow;
    }
  }

  /// 从本地 `.json` 备份文件还原指定配置
  Future<void> restoreConfigs(String source, {List<String>? keys}) async {
    _ensureInitialized();

    final backupFile = File(source);
    if (!await backupFile.exists()) {
      throw FileSystemException('备份文件不存在', source);
    }

    try {
      final jsonString = await backupFile.readAsString();
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;
      await importBackupPayload(backupData, keys: keys);
    } catch (e) {
      debugPrint('还原配置失败: $e');
      rethrow;
    }
  }

  /// 获取历史备份版本列表
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

    await _preferences.setString(
      _configBackupVersionsKey,
      jsonEncode(versions),
    );
  }

  Future<void> deleteBackupVersion(String filePath) async {
    _ensureInitialized();

    final versions = await getBackupVersions();
    versions.removeWhere((version) => version['path'] == filePath);

    await _preferences.setString(
      _configBackupVersionsKey,
      jsonEncode(versions),
    );

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
