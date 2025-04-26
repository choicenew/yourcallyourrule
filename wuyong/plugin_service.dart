import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yaml/yaml.dart';

import '../../../core/entities/plugin/plugin_entry.dart';
import '../../../core/repositories/plugin_repository.dart';
import '../../../core/services/list_service.dart';
import '../../../core/services/plugin_webview_service.dart';
import '../../../core/services/universal_import_export_service.dart';
import '../../../utils/update_interval.dart';

class PluginService extends ListService<PluginEntry, String> {
  final Logger _logger = Logger('PluginService');
  final PluginRepository _repository;
  final PluginWebViewService _webViewService;
  final UniversalImportExportService<PluginEntry> _importExportService;
  final PhoneNumberUtil _phoneNumberUtil;
  
  // 已加载的插件缓存
  final Map<String, bool> _loadedPlugins = {};
  
  // 插件本地存储路径
  late final String _pluginsDirectory;
  bool _isInitialized = false;

  PluginService(this._repository, this._webViewService)
      : _importExportService = UniversalImportExportService<PluginEntry>(_repository),
        _phoneNumberUtil = PhoneNumberUtil.instance,
        super(_repository);

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // 初始化WebView服务
    await _webViewService.initializeWebView();
    
    // 创建插件目录
    final appDir = await getApplicationDocumentsDirectory();
    _pluginsDirectory = '${appDir.path}/plugins';
    final directory = Directory(_pluginsDirectory);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    
    // 加载启用的插件
    await _loadEnabledPlugins();
    
    _isInitialized = true;
  }

  Future<void> _loadEnabledPlugins() async {
    final plugins = await getEnabledPlugins();
    
    for (final plugin in plugins) {
      try {
        await loadPlugin(plugin.id);
      } catch (e) {
        _logger.severe('Failed to load plugin ${plugin.name}: $e');
      }
    }
  }

  Future<List<PluginEntry>> getEnabledPlugins() async {
    final allPlugins = await getAll();
    return allPlugins.where((plugin) => plugin.enabled).toList()
      ..sort((a, b) => a.pluginOrder.compareTo(b.pluginOrder));
  }

  @override
  Future<List<PluginEntry>> getAll() async {
    final plugins = await _repository.getAll();
    return plugins;
  }

  Future<PluginEntry> addPlugin(PluginEntry entry) async {
    return await _repository.save(entry);
  }

  Future<PluginEntry> updatePlugin(PluginEntry entry) async {
    return await _repository.save(entry);
  }

  Future<bool> deletePlugin(String id) async {
    // 先卸载插件
    await unloadPlugin(id);
    
    // 删除本地文件
    await _deletePluginFile(id);
    
    // 从数据库中删除
    return await _repository.deleteById(id);
  }

  Future<void> _deletePluginFile(String pluginId) async {
    final file = File('$_pluginsDirectory/$pluginId.js');
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<Map<String, dynamic>> getPluginStatus(String pluginId) async {
    final plugin = await _repository.getById(pluginId);
    return {
      'isActive': plugin?.enabled ?? false,
      'isLoaded': _loadedPlugins[pluginId] ?? false,
      'lastUpdated': DateTime.now().toIso8601String(),
    };
  }

  Future<List<PluginEntry>> importFromFile(String path) async {
    return await _importExportService.importFromFile(path);
  }

  Future<bool> exportToFile(String path) async {
    final data = await getAll();
    return await _importExportService.exportToFile(path, data);
  }

  // 加载插件
  Future<void> loadPlugin(String pluginId) async {
    if (_loadedPlugins[pluginId] == true) {
      return;
    }
    
    final plugin = await _repository.getById(pluginId);
    if (plugin == null) {
      throw Exception('Plugin not found: $pluginId');
    }
    
    if (!plugin.enabled) {
      throw Exception('Cannot load disabled plugin: ${plugin.name}');
    }
    
    // 检查本地文件是否存在
    final scriptFile = File('$_pluginsDirectory/$pluginId.js');
    if (!await scriptFile.exists()) {
      // 下载插件脚本
      await _downloadPluginScript(plugin);
    }
    
    // 读取脚本内容
    final scriptContent = await scriptFile.readAsString();
    
    // 加载到WebView
    await _webViewService.loadPlugin(pluginId, scriptContent);
    
    _loadedPlugins[pluginId] = true;
  }

  // 卸载插件
  Future<void> unloadPlugin(String pluginId) async {
    await _webViewService.unloadPlugin(pluginId);
    _loadedPlugins.remove(pluginId);
  }

  // 下载插件脚本
  Future<void> _downloadPluginScript(PluginEntry plugin) async {
    try {
      final response = await http.get(Uri.parse(plugin.url));
      
      if (response.statusCode != 200) {
        throw Exception('Failed to download plugin script: ${response.statusCode}');
      }
      
      final script = utf8.decode(response.bodyBytes);
      
      // 提取远程版本
      final remoteVersion = _extractRemoteVersion(script);
      
      // 保存脚本到本地
      await _saveScriptToLocal(plugin.id, script);
      
      // 如果版本不同，更新数据库中的版本
      if (remoteVersion != plugin.version) {
        final updatedPlugin = plugin.copyWith(version: remoteVersion);
        await updatePlugin(updatedPlugin);
      }
    } catch (e) {
      _logger.severe('Error downloading plugin script: $e');
      throw Exception('Failed to download plugin: ${e.toString()}');
    }
  }

  // 保存脚本到本地
  Future<void> _saveScriptToLocal(String pluginId, String script) async {
    final file = File('$_pluginsDirectory/$pluginId.js');
    await file.writeAsString(script);
  }

  // 提取远程版本
  String _extractRemoteVersion(String script) {
    final versionRegex = RegExp(r'version: [''"](.*)[''"]\s*,');
    final match = versionRegex.firstMatch(script);
    if (match != null && match.groupCount > 0) {
      return match.group(1)!;
    } else {
      return '1.0.0'; // 默认版本
    }
  }
  // 检查是否有更新版本
  bool _isNewerVersion(String remoteVersion, String currentVersion) {
    return remoteVersion.compareTo(currentVersion) > 0;
  }

  // 检查并更新所有插件
  Future<void> checkAndUpdatePlugins() async {
    final plugins = await getAll();
    final autoUpdatePlugins = plugins.where((p) => p.isAutoUpdate).toList();
    
    for (final plugin in autoUpdatePlugins) {
      try {
        await _checkAndUpdatePlugin(plugin);
      } catch (e) {
        _logger.warning('Failed to update plugin ${plugin.name}: $e');
      }
    }
  }

  // 检查并更新单个插件
  Future<bool> _checkAndUpdatePlugin(PluginEntry plugin) async {
    try {
      final response = await http.get(Uri.parse(plugin.url));
      
      if (response.statusCode != 200) {
        throw Exception('Failed to get plugin update info: ${response.statusCode}');
      }
      
      final script = utf8.decode(response.bodyBytes);
      final remoteVersion = _extractRemoteVersion(script);
      
      // 检查是否有更新版本
      if (_isNewerVersion(remoteVersion, plugin.version)) {
        // 如果插件已加载，先卸载
        if (_loadedPlugins[plugin.id] == true) {
          await unloadPlugin(plugin.id);
        }
        
        // 保存最新的脚本到本地
        await _saveScriptToLocal(plugin.id, script);
        
        // 更新数据库中插件的版本号
        final updatedPlugin = plugin.copyWith(version: remoteVersion);
        await updatePlugin(updatedPlugin);
        
        // 如果插件是启用状态，重新加载
        if (plugin.enabled) {
          await loadPlugin(plugin.id);
        }
        
        return true;
      }
      
      return false;
    } catch (e) {
      _logger.severe('Error checking plugin update: $e');
      throw Exception('Failed to check plugin update: ${e.toString()}');
    }
  }

  // 启用插件
  Future<void> enablePlugin(String pluginId) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin == null) {
      throw Exception('Plugin not found: $pluginId');
    }
    
    if (plugin.enabled) return;
    
    final updatedPlugin = plugin.copyWith(enabled: true);
    await updatePlugin(updatedPlugin);
    
    // 加载插件
    await loadPlugin(pluginId);
  }

  // 禁用插件
  Future<void> disablePlugin(String pluginId) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin == null) {
      throw Exception('Plugin not found: $pluginId');
    }
    
    if (!plugin.enabled) return;
    
    final updatedPlugin = plugin.copyWith(enabled: false);
    await updatePlugin(updatedPlugin);
    
    // 卸载插件
    await unloadPlugin(pluginId);
  }

  // 更新插件顺序
  Future<void> updatePluginOrder(String pluginId, int newOrder) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin == null) {
      throw Exception('Plugin not found: $pluginId');
    }
    
    final updatedPlugin = plugin.copyWith(pluginOrder: newOrder);
    await updatePlugin(updatedPlugin);
  }

  // 设置自动更新
  Future<void> setAutoUpdate(String pluginId, bool autoUpdate) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin == null) {
      throw Exception('Plugin not found: $pluginId');
    }
    
    final updatedPlugin = plugin.copyWith(isAutoUpdate: autoUpdate);
    await updatePlugin(updatedPlugin);
  }

  // 调用插件查询
  Future<Map<String, dynamic>?> callPlugin(
    String pluginId,
    String phoneNumber,
  ) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    if (_loadedPlugins[pluginId] != true) {
      await loadPlugin(pluginId);
    }
    
    return await _webViewService.callPlugin(
      pluginId,
      phoneNumber,
      nationalNumber,
      e164Number,
    );
  }

  // 并发调用多个插件
  Future<Map<String, Map<String, dynamic>?>> callPlugins(
    String phoneNumber,
    List<String>? pluginIds,
  ) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    // 如果未指定插件ID，使用所有启用的插件
    final enabledPlugins = pluginIds ?? 
        (await getEnabledPlugins()).map((p) => p.id).toList();
    
    if (enabledPlugins.isEmpty) {
      return {};
    }
    
    // 解析电话号码
    final parsedNumber = _phoneNumberUtil.parse(phoneNumber, null);
    final nationalNumber = _phoneNumberUtil.getNationalSignificantNumber(parsedNumber);
    final e164Number = _phoneNumberUtil.format(parsedNumber, PhoneNumberFormat.E164);
    
    // 创建并发查询
    final futures = <String, Future<Map<String, dynamic>?>>{};
    
    for (final pluginId in enabledPlugins) {
      if (_loadedPlugins[pluginId] != true) {
        try {
          await loadPlugin(pluginId);
        } catch (e) {
          _logger.warning('Failed to load plugin $pluginId: $e');
          continue;
        }
      }
      
      futures[pluginId] = _webViewService.callPlugin(
        pluginId,
        phoneNumber,
        nationalNumber,
        e164Number,
      ).catchError((e) {
        _logger.warning('Error calling plugin $pluginId: $e');
        return null;
      });
    }
    
    // 等待所有查询完成
    final results = <String, Map<String, dynamic>?>{};
    for (final entry in futures.entries) {
      try {
        results[entry.key] = await entry.value;
      } catch (e) {
        _logger.warning('Error processing plugin ${entry.key} result: $e');
        results[entry.key] = null;
      }
    }
    
    return results;
  }

  // 根据URL获取插件
  Future<PluginEntry?> getPluginByUrl(String url) async {
    final plugins = await getAll();
    return plugins.firstWhere(
      (plugin) => plugin.url == url,
      orElse: () => null as PluginEntry, // 这里需要显式转换为null
    );
  }

  @override
  void dispose() {
    _webViewService.dispose();
    super.dispose();
  }
}