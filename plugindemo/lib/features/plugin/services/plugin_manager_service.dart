import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/core/repositories/plugin_repository.dart';
import 'package:plugindemo/data/repositories/plugin_repository_impl.dart';
import 'package:plugindemo/core/services/list_service.dart';
import 'package:plugindemo/core/services/universal_import_export_service.dart';
import 'package:plugindemo/data/repositories/config/config_repository.dart';
import 'package:plugindemo/features/plugin/services/plugin_manager_config.dart';

part 'plugin_manager_service.g.dart';

/// PluginManagerService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
PluginManagerService pluginManagerService(Ref ref) {
  final pluginRepository = ref.watch(pluginRepositoryProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  return PluginManagerService(pluginRepository, configRepository: configRepository);
}

class PluginManagerService extends ListService<PluginEntry, String> {
  final PluginRepository _repository;
  final UniversalImportExportService<PluginEntry> _importExportService;
  final PluginManagerConfig _config;

  PluginManagerService(
    this._repository, {
    required ConfigRepository configRepository,
  }) : _importExportService = UniversalImportExportService<PluginEntry>(
         _repository,
       ),
       _config = PluginManagerConfig(configRepository: configRepository),
       super(_repository);

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

  @override
  Future<List<PluginEntry>> getAll() async {
    return await _repository.getAll();
  }

  Future<PluginEntry?> getByUrl(String url) async {
    final plugins = await getAll();
    try {
      return plugins.firstWhere((entry) => entry.url == url);
    } catch (e) {
      return null;
    }
  }

  Future<List<PluginEntry>> getEnabledPlugins() async {
    final plugins = await getAll();
    return plugins.where((entry) => entry.isEnabled).toList();
  }

  Future<void> togglePluginStatus(PluginEntry entry, bool isEnabled) async {
    final updatedEntry = entry.copyWith(isEnabled: isEnabled);
    await _repository.update(updatedEntry);
  }

  static Future<Directory> getPluginsDirectory() async {
    final appSupportDirectory = await getApplicationSupportDirectory();
    final pluginsDirectory = Directory(
      join(appSupportDirectory.path, 'plugins'),
    );

    if (!pluginsDirectory.existsSync()) {
      pluginsDirectory.createSync(recursive: true);
    }

    return pluginsDirectory;
  }

  Future<String> getScriptPath(String pluginId) async {
    final directory = await getPluginsDirectory();
    return '${directory.path}/$pluginId.js';
  }

  Future<void> saveScriptToLocal(PluginEntry entry, String script) async {
    final scriptPath = await getScriptPath(entry.id);
    final scriptFile = File(scriptPath);
    await scriptFile.parent.create(recursive: true);
    await scriptFile.writeAsString(script);
  }

  static Map<String, dynamic> extractPluginInfo(String script) {
    final idRegex = RegExp(
      r"id:\s*['"
      "](.*?)['"
      "],?",
      multiLine: true,
    );
    final nameRegex = RegExp(
      r"name:\s*['"
      "](.*?)['"
      "],?",
      multiLine: true,
    );
    final versionRegex = RegExp(
      r"version:\s*['"
      "](.*?)['"
      "],?",
      multiLine: true,
    );
    final descriptionRegex = RegExp(
      r"description:\s*['"
      "](.*?)['"
      "],?",
      multiLine: true,
    );

    final idMatch = idRegex.firstMatch(script);
    final nameMatch = nameRegex.firstMatch(script);
    final versionMatch = versionRegex.firstMatch(script);
    final descriptionMatch = descriptionRegex.firstMatch(script);

    if (idMatch == null || nameMatch == null || versionMatch == null) {
      throw Exception('无法从脚本中提取插件信息');
    }

    return {
      'id': idMatch.group(1)!,
      'name': nameMatch.group(1)!,
      'version': versionMatch.group(1)!,
      'description': descriptionMatch?.group(1) ?? '',
    };
  }

  PluginEntry createPluginFromScript(String script, String url) {
    final pluginInfo = extractPluginInfo(script);
    return PluginEntry(
      id: pluginInfo['id'],
      name: pluginInfo['name'],
      url: url,
      version: pluginInfo['version'],
      description: pluginInfo['description'],
      isEnabled: true,
      pluginOrder: 0,
      isAutoUpdate: false,
    );
  }

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

  Future<void> addPlugin(PluginEntry entry) async {
    await _repository.save(entry);
  }

  Future<void> updatePlugin(PluginEntry entry) async {
    await _repository.update(entry);
  }

  Future<void> deletePlugin(PluginEntry entry) async {
    final scriptPath = await getScriptPath(entry.id);
    final scriptFile = File(scriptPath);
    if (await scriptFile.exists()) {
      await scriptFile.delete();
    }

    await _repository.delete(entry);
  }

  Future<PluginEntry?> getPluginById(String id) async {
    final plugins = await getAll();
    try {
      return plugins.firstWhere((entry) => entry.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<PluginEntry?> getPluginByUrl(String url) async {
    final plugins = await getAll();
    try {
      return plugins.firstWhere((entry) => entry.url == url);
    } catch (e) {
      return null;
    }
  }

  Future<void> enablePlugin(PluginEntry entry) async {
    final updatedEntry = entry.copyWith(isEnabled: true);
    await updatePlugin(updatedEntry);
  }

  Future<void> disablePlugin(PluginEntry entry) async {
    final updatedEntry = entry.copyWith(isEnabled: false);
    await updatePlugin(updatedEntry);
  }

  Future<PluginEntry?> addPluginFromUrl(String url) async {
    final existingPlugin = await getPluginByUrl(url);
    if (existingPlugin != null) {
      return existingPlugin;
    }

    try {
      final response = await HttpClient().getUrl(Uri.parse(url));
      final httpClientResponse = await response.close();
      final script = await utf8.decodeStream(httpClientResponse);

      final entry = createPluginFromScript(script, url);

      await saveScriptToLocal(entry, script);

      await addPlugin(entry);

      return entry;
    } catch (e) {
      debugPrint('添加插件失败: $e');
      return null;
    }
  }

  Future<PluginEntry?> addPluginFromLocal(String filePath) async {
    try {
      File file = File(filePath);
      if (!file.existsSync()) {
        throw const FileSystemException('文件不存在');
      }
      List<int> bytes = await file.readAsBytes();
      String script = utf8.decode(bytes);

      final entry = createPluginFromScript(script, '');

      await saveScriptToLocal(entry, script);

      await addPlugin(entry);

      return entry;
    } catch (e) {
      debugPrint('添加本地插件失败: $e');
      return null;
    }
  }

  Future<bool> updatePluginFromUrl(PluginEntry entry) async {
    if (entry.url.isEmpty) {
      return false;
    }

    try {
      final response = await HttpClient().getUrl(Uri.parse(entry.url));
      final httpClientResponse = await response.close();
      final script = await utf8.decodeStream(httpClientResponse);

      final remoteVersion = extractRemoteVersion(script);

      final updatedEntry = entry.copyWith(version: remoteVersion);
      await updatePlugin(updatedEntry);
      await saveScriptToLocal(updatedEntry, script);
      return true;
    } catch (e) {
      debugPrint('更新插件失败: $e');
      return false;
    }
  }

  Future<bool> autoUpdatePlugin(PluginEntry entry) async {
    if (entry.isAutoUpdate) {
      final updated = await updatePluginFromUrl(entry);
      return updated;
    }
    return false;
  }

  Future<void> updatePlugins() async {
    final entries = await getEnabledPlugins();
    for (final entry in entries) {
      if (entry.isAutoUpdate) {
        await autoUpdatePlugin(entry);
      }
    }
  }

  Future<void> toggleAllPluginsStatus(bool isEnabled) async {
    final plugins = await getAll();
    if (plugins.isEmpty) return;

    final updatedPlugins = plugins
        .map((plugin) => plugin.copyWith(isEnabled: isEnabled))
        .toList();

    await _repository.saveAll(updatedPlugins);
  }

  Future<List<PluginEntry>> importFromFile(String path) async {
    return await _importExportService.importFromFile(path);
  }

  Future<bool> exportToFile(String path) async {
    final data = await getAll();
    return await _importExportService.exportToFile(path, data);
  }
}
