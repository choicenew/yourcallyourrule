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
import 'package:yaml/yaml.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/%E5%BA%9F%E5%BC%83/plugin_web_service.dart';
import 'package:yourcallyourrule/utils/update_interval.dart';

class PluginManager extends ListService<PluginEntry, String> {
  final PluginRepository _repository;
  final PluginWebService _webService;
  
  PluginManager(this._repository, this._webService) : super(_repository);

  // 初始化
  Future<void> initialize() async {
    await _webService.initializeWebView();
    await loadAllEnabledPlugins();
  }
  
  // 加载所有启用的插件
  Future<void> loadAllEnabledPlugins() async {
    final enabledPlugins = await _repository.getEnabled();
    for (final plugin in enabledPlugins) {
      await loadPlugin(plugin);
    }
  }
  
  // 加载单个插件
  Future<void> loadPlugin(PluginEntry plugin) async {
    try {
      await _webService.loadPluginScript(plugin);
    } catch (e) {
      print('Error loading plugin ${plugin.id}: $e');
    }
  }
  
  // 切换自动更新
  Future<void> toggleAutoUpdate(String pluginId, bool isAutoUpdate) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin != null) {
      final updated = plugin.copyWith(isAutoUpdate: isAutoUpdate);
      await _repository.save(updated);
      await _repository.updateAutoUpdate(pluginId, isAutoUpdate);
    }
  }

  // 更新插件顺序
  Future<void> updatePluginOrder(String pluginId, int newOrder) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin != null) {
      final updated = plugin.copyWith(pluginOrder: newOrder);
      await _repository.save(updated);
      await _sortPlugins();
    }
  }

  // 批量启用/禁用插件
  Future<void> bulkEnablePlugins(List<String> pluginIds, bool enable) async {
    final plugins = await _repository.getAll();
    for (final plugin in plugins.where((p) => pluginIds.contains(p.id))) {
      await _repository.save(plugin.copyWith(enabled: enable));
      await _repository.setEnabled(plugin.id, enable);
      
      // 如果启用，则加载插件
      if (enable) {
        await loadPlugin(plugin);
      }
    }
  }
  
  // 排序插件
  Future<void> _sortPlugins() async {
    await _repository.getAllSorted(orderBy: 'pluginOrder');
  }
  
  // 添加插件（从URL）
  Future<PluginEntry?> addPluginFromUrl(String url) async {
    // 检查是否已存在相同URL的插件
    final existingPlugin = await _repository.getByUrl(url);
    if (existingPlugin != null) {
      return existingPlugin;
    }
    
    return await loadPluginFromUrl(url);
  }
  
  // 从URL加载插件
  Future<PluginEntry> loadPluginFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode != 200) {
      throw Exception('Failed to load plugin from URL: ${response.statusCode}');
    }
    
    final script = utf8.decode(response.bodyBytes);
    
    // 提取插件信息
    final pluginInfo = PluginWebService.extractPluginInfo(script);
    
    // 创建插件实体
    final plugin = PluginEntry(
      id: pluginInfo['id']!,
      name: pluginInfo['name']!,
      url: url,
      version: pluginInfo['version']!,
      enabled: true,
      pluginOrder: 0,
    );
    
    // 保存脚本到本地
    await _webService.saveScriptToLocal(plugin, script);
    
    // 保存插件信息到数据库
    await _repository.save(plugin);
    
    // 加载插件
    await loadPlugin(plugin);
    
    return plugin;
  }
  
  // 添加插件（从本地文件）
  Future<PluginEntry> addPluginFromLocal(String filePath) async {
    // 读取脚本内容
    final file = File(filePath);
    if (!await file.exists()) {
      throw FileSystemException('文件不存在');
    }
    
    final script = await file.readAsString();
    
    // 提取插件信息
    final pluginInfo = PluginWebService.extractPluginInfo(script);
    
    // 创建插件实体
    final plugin = PluginEntry(
      id: pluginInfo['id']!,
      name: pluginInfo['name']!,
      url: '',
      version: pluginInfo['version']!,
      enabled: true,
      pluginOrder: 0,
    );
    
    // 保存脚本到本地
    await _webService.saveScriptToLocal(plugin, script);
    
    // 保存到数据库
    await _repository.save(plugin);
    
    // 加载插件
    await loadPlugin(plugin);
    
    return plugin;
  }
  
  // 删除插件
  Future<bool> deletePlugin(String pluginId) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin != null) {
      // 删除本地脚本文件
      final scriptPath = await _getPluginScriptPath(plugin.id);
      final scriptFile = File(scriptPath);
      if (await scriptFile.exists()) {
        await scriptFile.delete();
      }
      
      // 从数据库中删除
      return await _repository.deleteById(pluginId);
    }
    return false;
  }
  
  // 获取插件脚本路径
  Future<String> _getPluginScriptPath(String pluginId) async {
    final directory = await PluginWebService._getPluginsDirectory();
    return '${directory.path}/$pluginId.js';
  }
  
  // 启用插件
  Future<void> enablePlugin(String pluginId) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin != null) {
      await _repository.save(plugin.copyWith(enabled: true));
      await _repository.setEnabled(pluginId, true);
      await loadPlugin(plugin);
    }
  }
  
  // 禁用插件
  Future<void> disablePlugin(String pluginId) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin != null) {
      await _repository.save(plugin.copyWith(enabled: false));
      await _repository.setEnabled(pluginId, false);
    }
  }
  
  // 更新插件
  Future<bool> updatePlugin(String pluginId) async {
    final plugin = await _repository.getById(pluginId);
    if (plugin != null && plugin.url.isNotEmpty) {
      try {
        // 获取最新脚本
        final response = await http.get(Uri.parse(plugin.url));
        if (response.statusCode != 200) {
          throw Exception('无法获取插件更新: ${response.statusCode}');
        }
        
        final script = utf8.decode(response.bodyBytes);
        final remoteVersion = PluginWebService.extractRemoteVersion(script);
        
        // 检查是否有更新
        if (PluginWebService.isNewerVersion(remoteVersion, plugin.version)) {
          // 更新版本号
          await _repository.updateVersion(pluginId, remoteVersion);
          
          // 保存脚本到本地
          await _webService.saveScriptToLocal(plugin, script);
          
          // 如果插件已启用，重新加载
          if (plugin.enabled) {
            await loadPlugin(plugin.copyWith(version: remoteVersion));
          }
          
          return true;
        }
      } catch (e) {
        print('更新插件失败: $e');
      }
    }
    return false;
  }
  
  // 自动更新所有插件
  Future<void> autoUpdateAllPlugins() async {
    final plugins = await _repository.getAll();
    for (final plugin in plugins.where((p) => p.isAutoUpdate)) {
      await updatePlugin(plugin.id);
    }
  }
  
  // 检查更新间隔
  Future<bool> shouldCheckForUpdates() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdateCheck = prefs.getInt('lastUpdateCheck') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    
    // 检查是否已经过了更新间隔
    final updateInterval = UpdateInterval.getInterval();
    if (now - lastUpdateCheck > updateInterval) {
      // 更新最后检查时间
      await prefs.setInt('lastUpdateCheck', now);
      return true;
    }
    
    return false;
  }
  
  // 执行插件函数
  Future<Map<String, dynamic>?> executePluginFunction(
    String functionName, 
    Map<String, dynamic> params
  ) async {
    return await _webService.executePluginFunction(functionName, params);
  }
  
  // 导入导出功能
  Future<List<PluginEntry>> importPluginsFromFile(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('File not found: $path');
    }
    
    final data = await file.readAsString();
    final plugins = _parsePluginData(data, path);
    
    for (final plugin in plugins) {
      await _repository.save(plugin);
    }
    
    return plugins;
  }
  
  Future<String> exportPluginsToFile(String format) async {
    final plugins = await _repository.getAll();
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    String filePath;
    
    if (format == 'json') {
      filePath = '${directory.path}/plugins_export_$timestamp.json';
      final jsonData = jsonEncode(plugins.map((p) => p.toMap()).toList());
      await File(filePath).writeAsString(jsonData);
    } else if (format == 'csv') {
      filePath = '${directory.path}/plugins_export_$timestamp.csv';
      final csvData = [
        ['id', 'name', 'url', 'version', 'enabled', 'pluginOrder', 'isAutoUpdate'],
        ...plugins.map((p) => [
          p.id,
          p.name,
          p.url,
          p.version,
          p.enabled.toString(),
          p.pluginOrder.toString(),
          p.isAutoUpdate.toString(),
        ]),
      ];
      final csv = const ListToCsvConverter().convert(csvData);
      await File(filePath).writeAsString(csv);
    } else {
      throw Exception('Unsupported format: $format');
    }
    
    return filePath;
  }
  
  // 解析插件数据
  List<PluginEntry> _parsePluginData(String data, String source) {
    if (source.endsWith('.csv')) {
      return _parseCsvData(data);
    } else if (source.endsWith('.json')) {
      return _parseJsonData(data);
    } else if (source.endsWith('.yaml') || source.endsWith('.yml')) {
      return _parseYamlData(data);
    } else if (source.endsWith('.txt')) {
      return _parseTxtData(data);
    } else {
      throw Exception('Unsupported file format: $source');
    }
  }
  
  List<PluginEntry> _parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
    return csvList.skip(1).map((parts) {
      return PluginEntry(
        id: parts.isNotEmpty ? parts[0].toString() : '',
        name: parts.length > 1 ? parts[1].toString() : '',
        url: parts.length > 2 ? parts[2].toString() : '',
        version: parts.length > 3 ? parts[3].toString() : '',
        enabled: parts.length > 4 && parts[4].toString().toLowerCase() == 'true',
        pluginOrder: parts.length > 5 ? int.tryParse(parts[5].toString()) ?? 0 : 0,
        isAutoUpdate: parts.length > 6 && parts[6].toString().toLowerCase() == 'true',
      );
    }).toList();
  }
  
  List<PluginEntry> _parseJsonData(String data) {
    final jsonData = jsonDecode(data);
    if (jsonData is List) {
      return jsonData.map((plugin) {
        return PluginEntry(
          id: plugin['id'] ?? '',
          name: plugin['name'] ?? '',
          url: plugin['url'] ?? '',
          version: plugin['version'] ?? '',
          enabled: plugin['enabled'] ?? false,
          pluginOrder: plugin['pluginOrder'] ?? 0,
          isAutoUpdate: plugin['isAutoUpdate'] ?? false,
        );
      }).toList();
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
  
  List<PluginEntry> _parseYamlData(String data) {
    final yamlData = loadYaml(data) as List;
    return yamlData.map((plugin) {
      return PluginEntry(
        id: plugin['id'] ?? '',
        name: plugin['name'] ?? '',
        url: plugin['url'] ?? '',
        version: plugin['version'] ?? '',
        enabled: plugin['enabled'] ?? false,
        pluginOrder: plugin['pluginOrder'] ?? 0,
        isAutoUpdate: plugin['isAutoUpdate'] ?? false,
      );
    }).toList();
  }
  
  List<PluginEntry> _parseTxtData(String data) {
    final lines = data.split('\n');
    return lines.map((line) {
      final parts = line.split(',');
      return PluginEntry(
        id: parts.isNotEmpty ? parts[0].toString() : '',
        name: parts.length > 1 ? parts[1].toString() : '',
        url: parts.length > 2 ? parts[2].toString() : '',
        version: parts.length > 3 ? parts[3].toString() : '',
        enabled: parts.length > 4 && parts[4].toString().toLowerCase() == 'true',
        pluginOrder: parts.length > 5 ? int.tryParse(parts[5].toString()) ?? 0 : 0,
        isAutoUpdate: parts.length > 6 && parts[6].toString().toLowerCase() == 'true',
      );
    }).toList();
  }
}