import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:yourcallyourrule/common/error/logger.dart';

import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/universal_import_export_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_config.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';

/// 插件管理服务 - 负责数据库操作
/// 遵循单一职责原则，只负责插件的CRUD操作
class PluginManagerService extends ListService<PluginEntry, String> {
  final PluginRepository _repository;
  final UniversalImportExportService<PluginEntry> _importExportService;
  final PluginManagerConfig _config;

  // 构造函数统一到类顶部
  PluginManagerService(this._repository, {required ConfigRepository configRepository})
      : _importExportService =
            UniversalImportExportService<PluginEntry>(_repository),
        _config = PluginManagerConfig(configRepository: configRepository),
        super(_repository);

  // region 基础CRUD操作（保持与PhoneSubscriptionService一致的结构）
  @override
  Future<PluginEntry> addEntry(PluginEntry entry) => _repository.save(entry);

  @override
  Future<List<PluginEntry>> addEntries(List<PluginEntry> entries) =>
      _repository.saveAll(entries);

  @override
  Future<bool> removeEntry(PluginEntry entry) => _repository.delete(entry);

  @override
  Future<bool> removeEntryById(String id) => _repository.deleteById(id);

  @override
  Future<PluginEntry?> getById(String id) => _repository.getById(id);
  // endregion

  // region 业务方法（按功能分组排序，与LabelService模式一致）
  /// 获取所有插件
  @override
  Future<List<PluginEntry>> getAll() async {
    return await _repository.getAll();
  }

  /// 根据URL获取插件
  Future<PluginEntry?> getByUrl(String url) async {
    final plugins = await getAll();
    try {
      return plugins.firstWhere((entry) => entry.url == url);
    } catch (e) {
      return null;
    }
  }

  /// 获取已启用的插件
  Future<List<PluginEntry>> getEnabledPlugins() async {
    final plugins = await getAll();
    return plugins.where((entry) => entry.isEnabled).toList();
  }

  /// 切换插件状态（与PhoneSubscriptionService的enable/disable模式对齐）
  Future<void> togglePluginStatus(PluginEntry entry, bool isEnabled) async {
    final updatedEntry = entry.copyWith(isEnabled: isEnabled);
    await _repository.update(updatedEntry);
  }

  // region 文件操作方法（集中管理文件相关操作）
  /// 获取插件目录（保持与PhoneSubscriptionService类似的静态方法结构）
  static Future<Directory> getPluginsDirectory() async {
    final appSupportDirectory = await getApplicationSupportDirectory();
    final pluginsDirectory =
        Directory(join(appSupportDirectory.path, 'plugins'));

    // 如果 plugins 文件夹不存在，则创建它
    if (!pluginsDirectory.existsSync()) {
      pluginsDirectory.createSync(recursive: true);
    }

    return pluginsDirectory;
  }

  /// 获取插件脚本的本地文件路径
  Future<String> getScriptPath(String pluginId) async {
    final directory = await getPluginsDirectory();
    return '${directory.path}/$pluginId.js';
  }

  /// 保存脚本到本地
  Future<void> saveScriptToLocal(PluginEntry entry, String script) async {
    final scriptPath = await getScriptPath(entry.id);
    final scriptFile = File(scriptPath);
    await scriptFile.parent.create(recursive: true);
    await scriptFile.writeAsString(script);
  }
  // endregion

  // 从插件脚本中提取插件信息
  static Map<String, dynamic> extractPluginInfo(String script) {
    final idRegex = RegExp(r"id: '(.*?)',");
    final nameRegex = RegExp(r"name: '(.*?)',");
    final versionRegex = RegExp(r"version: '(.*?)',");

    final idMatch = idRegex.firstMatch(script);
    final nameMatch = nameRegex.firstMatch(script);
    final versionMatch = versionRegex.firstMatch(script);

    if (idMatch == null || nameMatch == null || versionMatch == null) {
      throw Exception('无法从脚本中提取插件信息');
    }

    return {
      'id': idMatch.group(1)!,
      'name': nameMatch.group(1)!,
      'version': versionMatch.group(1)!,
    };
  }

  // 从插件脚本中创建PluginEntry对象
  PluginEntry createPluginFromScript(String script, String url) {
    final pluginInfo = extractPluginInfo(script);
    return PluginEntry(
      id: pluginInfo['id'],
      name: pluginInfo['name'],
      url: url,
      version: pluginInfo['version'],
      isEnabled: true,
      pluginOrder: 0,
      isAutoUpdate: false,
    );
  }

  // 检查是否有更新版本
  bool isNewerVersion(String remoteVersion, String currentVersion) {
    return remoteVersion.compareTo(currentVersion) > 0;
  }

  String extractRemoteVersion(String script) {
    final versionRegex = RegExp(r"version: '(.*)',");
    final match = versionRegex.firstMatch(script);
    if (match != null && match.groupCount > 0) {
      return match.group(1)!;
    } else {
      throw Exception('无法从脚本中提取远程版本号');
    }
  }

  // 添加插件
  Future<void> addPlugin(PluginEntry entry) async {
    await _repository.save(entry);
  }

  // 更新插件
  Future<void> updatePlugin(PluginEntry entry) async {
    await _repository.update(entry);
  }

  // 删除插件
  Future<void> deletePlugin(PluginEntry entry) async {
    // 删除本地脚本文件
    final scriptPath = await getScriptPath(entry.id);
    final scriptFile = File(scriptPath);
    if (await scriptFile.exists()) {
      await scriptFile.delete();
    }

    // 从数据库中删除插件
    await _repository.delete(entry);
  }

  // 根据ID获取插件
  Future<PluginEntry?> getPluginById(String id) async {
    final plugins = await getAll();
    try {
      return plugins.firstWhere((entry) => entry.id == id);
    } catch (e) {
      return null;
    }
  }

  // 根据URL获取插件
  Future<PluginEntry?> getPluginByUrl(String url) async {
    final plugins = await getAll();
    try {
      return plugins.firstWhere((entry) => entry.url == url);
    } catch (e) {
      return null;
    }
  }

  // 启用插件
  Future<void> enablePlugin(PluginEntry entry) async {
    final updatedEntry = entry.copyWith(isEnabled: true);
    await updatePlugin(updatedEntry);
  }

  Future<void> disablePlugin(PluginEntry entry) async {
    final updatedEntry = entry.copyWith(isEnabled: false);
    await updatePlugin(updatedEntry);
  }

  // 从URL添加插件
  Future<PluginEntry?> addPluginFromUrl(String url) async {
    // 检查是否已存在相同URL的插件
    final existingPlugin = await getPluginByUrl(url);
    if (existingPlugin != null) {
      return existingPlugin;
    }

    try {
      final response = await HttpClient().getUrl(Uri.parse(url));
      final httpClientResponse = await response.close();
      final script = await utf8.decodeStream(httpClientResponse);

      // 从脚本中提取插件信息并创建插件对象
      final entry = createPluginFromScript(script, url);

      // 保存脚本到本地
      await saveScriptToLocal(entry, script);

      // 添加到数据库
      await addPlugin(entry);

      return entry;
    } catch (e) {
      AppLogger.error('添加插件失败', e);
      print('添加插件失败: $e');
      return null;
    }
  }

  // 从本地文件添加插件
  Future<PluginEntry?> addPluginFromLocal(String filePath) async {
    try {
      // 读取本地文件内容
      File file = File(filePath);
      if (!file.existsSync()) {
        throw const FileSystemException('文件不存在');
      }
      List<int> bytes = await file.readAsBytes();
      String script = utf8.decode(bytes);

      // 从脚本中提取插件信息并创建插件对象
      final entry = createPluginFromScript(script, '');

      // 保存脚本到本地
      await saveScriptToLocal(entry, script);

      // 添加到数据库
      await addPlugin(entry);

      return entry;
    } catch (e) {
      AppLogger.error('添加本地插件失败', e);
      print('添加本地插件失败: $e');
      return null;
    }
  }

  // 从URL更新插件
  Future<bool> updatePluginFromUrl(PluginEntry entry) async {
    if (entry.url.isEmpty) {
      return false;
    }

    try {
      final response = await HttpClient().getUrl(Uri.parse(entry.url));
      final httpClientResponse = await response.close();
      final script = await utf8.decodeStream(httpClientResponse);

      final remoteVersion = extractRemoteVersion(script);

      if (isNewerVersion(remoteVersion, entry.version)) {
        final updatedEntry = entry.copyWith(version: remoteVersion);
        await updatePlugin(updatedEntry);
        await saveScriptToLocal(updatedEntry, script);
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error('更新插件失败', e);
      print('更新插件失败: $e');
      return false;
    }
  }

  // 自动更新插件
  Future<bool> autoUpdatePlugin(PluginEntry entry) async {
    // 判断是否需要更新插件
    if (entry.isAutoUpdate) {
      // 执行插件更新操作
      final updated = await updatePluginFromUrl(entry);

      return updated;
    }
    return false;
  }

  // 自动更新所有启用的插件
  Future<void> updatePlugins() async {
    final entries = await getEnabledPlugins();
    for (final entry in entries) {
      if (entry.isAutoUpdate) {
        await autoUpdatePlugin(entry);
      }
    }
  }


  // 导入导出功能
  Future<List<PluginEntry>> importFromFile(String path) async {
    return await _importExportService.importFromFile(path);
  }

  Future<bool> exportToFile(String path) async {
    final data = await getAll();
    return await _importExportService.exportToFile(path, data);
  }
}

/*
// 设置默认的外部存储目录
Future<void> setDefaultStorageDirectory() async {
  final result = await FilePicker.platform.getDirectoryPath();
  if (result != null) {
    await _config.saveDefaultStorageDirectory(result);
  }
}

// 获取默认的外部存储目录
Future<String> getDefaultStorageDirectory() async {
  // 如果是 Android 平台，则使用 App 私有的 data 目录
  if (Platform.isAndroid) {
    final appDataDirectory = await getApplicationSupportDirectory();
    return appDataDirectory.path;
  }

  // 其他平台，使用用户选择的目录或 App Documents 目录
  final userSelectedDirectory = await _config.getDefaultStorageDirectory();

  if (userSelectedDirectory != null) {
    return userSelectedDirectory;
  }

  final appDocumentsDirectory = await getApplicationDocumentsDirectory();
  return appDocumentsDirectory.path;
}
*/