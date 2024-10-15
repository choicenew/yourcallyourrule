// 导入必要的库
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yaml/yaml.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/update_interval.dart';

Database? _database;

Future<Database> get database async {
  if (_database != null) return _database!;

  _database = await _initDatabase();
  return _database!;
}

Future<Database> _initDatabase() async {
  final String path = join(await getDatabasesPath(), 'call_rule_database.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: createDatabase,
  );
}

Future<void> createDatabase(Database database, int version) async {
  if (version == 1) {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS plugins (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT,
        version TEXT NOT NULL,
        enabled INTEGER NOT NULL,
        pluginOrder INTEGER NOT NULL,
            isAutoUpdate INTEGER        
      )
    ''');
  }
}

// Define the Plugin interface
class Plugin {
 String id; // 订阅 ID
  String name;
  String url;
  String version;
  bool enabled;
  int pluginOrder;
  bool isAutoUpdate; // 是否自动更新

  Plugin({
    required this.id,
    required this.name,
    required this.url,
    required this.version,
    required this.enabled,
    required this.pluginOrder,
        this.isAutoUpdate = false,
  });

  // 具体实现 toJson 方法
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'version': version,
      'enabled': enabled ? 1 : 0,
      'pluginOrder': pluginOrder,
        'isAutoUpdate': isAutoUpdate ? 1 : 0, // 布尔值转换为整数  
    };
  }

  // 从 JSON 数据创建 Plugin 对象
  factory Plugin.fromJson(Map<String, dynamic> json) {
    return Plugin(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      version: json['version'] ?? '',
      enabled: json['enabled'] == 1,
      pluginOrder: json['pluginOrder'] ?? 0,
        isAutoUpdate: json['isAutoUpdate'] == 1, // 整数转换为布尔值      
    );
  }

  


  // 获取插件脚本的本地文件路径
  Future<String> getScriptPath() async {
    final directory = await _getPluginsDirectory();
    return '${directory.path}/$id.js';
  }

  // 获取插件目录
  static Future<Directory> _getPluginsDirectory() async {
    final appSupportDirectory = await getApplicationSupportDirectory();
    final pluginsDirectory =
        Directory(join(appSupportDirectory.path, 'plugins'));

    // 如果 plugins 文件夹不存在，则创建它
    if (!pluginsDirectory.existsSync()) {
      pluginsDirectory.createSync(recursive: true);
    }

    return pluginsDirectory;
  }
}

class PluginService {
  final List<Plugin> _plugins = [];
  final Database database;
  late WebViewController _webViewController;
  // 添加一个 Map 用于存储已加载的插件对象
  static Map<String, dynamic> loadedPlugins = {};

  PluginService(this.database) {
    _initWebView();
  }

  void _initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            // You can add any necessary logic here when the page is finished loading
          },
        ),
      )
      ..loadHtmlString('<html><body></body></html>'); // Load an empty HTML page
  }

  Future<void> addPlugin(Plugin plugin) async {
    await database.insert('plugins', plugin.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
/*
  Future<List<Plugin>> getAllPlugins() async {
    final List<Map<String, dynamic>> maps = await database.query('plugins');
    return List.generate(maps.length, (i) => Plugin.fromJson(maps[i]));
  }
*/
  Future<List<Plugin>> getAllPlugins({String? orderBy, bool ascending = true}) async {
    final List<Map<String, dynamic>> results = await database.query(
      'plugins',
      orderBy:
          orderBy != null ? '$orderBy ${ascending ? 'ASC' : 'DESC'}' : null,
    );
    return results.map((row) => Plugin.fromJson(row)).toList();
  }


  Future<Plugin?> getPluginById(String id) async {
    final List<Map<String, dynamic>> maps =
        await database.query('plugins', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) {
      return null;
    } else {
      return Plugin.fromJson(maps[0]);
    }
  }

  // 更新插件数据库
  Future<void> updatePlugin(Plugin plugin) async {
    await database.update('plugins', plugin.toJson(),
        where: 'id = ?', whereArgs: [plugin.id]);
  }


  // 删除插件
  Future<void> deletePlugin(Plugin plugin) async {
    // 根据插件 ID 构建脚本路径
    final scriptPath = '${await Plugin._getPluginsDirectory().then((dir) => dir.path)}/${plugin.id}.js';
    final scriptFile = File(scriptPath);

    // 删除本地脚本文件
    if (await scriptFile.exists()) {
      await scriptFile.delete();
    }

    // 从数据库中删除插件
    await database.delete('plugins', where: 'id = ?', whereArgs: [plugin.id]);
  }

  // 编辑插件
  Future<void> editPlugin(Plugin plugin) async {
    // 根据插件 ID 从数据库中获取插件
    List<Map<String, dynamic>> result = await database.query(
      'plugins',
      where: 'id = ?',
      whereArgs: [plugin.id],
    );

    if (result.isNotEmpty) {
      // 如果找到相应的插件，则更新记录
      await database.update(
        'plugins',
        plugin.toJson(),
        where: 'id = ?',
        whereArgs: [plugin.id],
      );
    } else {
      // 如果未找到相应的插件，则插入新记录
      await database.insert('plugins', plugin.toJson());
    }
  }

  // 从插件脚本中提取插件信息并创建 Plugin 对象
  static Plugin createPluginFromScript(String script, String url) {
    final pluginInfo = extractPluginInfo(script);
    return Plugin(
      id: pluginInfo['id'],
      name: pluginInfo['name'],
      url: url,
      version: pluginInfo['version'],
      enabled: true,
      pluginOrder: 0,
    );
  }


  // 从 URL 中获取最新版本
  Future<void> updatePluginFromUrl(Plugin plugin) async {
    if (plugin.url.isNotEmpty) {
      // 如果是 JavaScript 插件，则从 URL 中获取最新版本信息
      final response = await http.get(Uri.parse(plugin.url));
      if (response.statusCode != 200) {
        throw Exception('无法获取 JavaScript 插件更新信息: ${response.statusCode}');
      }

      final script = utf8.decode(response.bodyBytes);

      final remoteVersion = extractRemoteVersion(script);

      // 检查是否有更新版本
      if (isNewerVersion(remoteVersion, plugin.version)) {
        // 更新数据库中插件的版本号
        await database.update('plugins', {'version': remoteVersion},
            where: 'id = ?', whereArgs: [plugin.id]);

        // 保存最新的脚本到本地
        await _saveScriptToLocal(plugin, script);

        // 执行更新操作
        await updateJavaScriptPlugin(script);
      } else {
        print('当前插件已经是最新版本');
      }
    }
  }

  // 检查是否有更新版本的方法
  bool isNewerVersion(String remoteVersion, String currentVersion) {
    return remoteVersion.compareTo(currentVersion) > 0;
  }

  // 更新 JavaScript 插件的方法
  Future<void> updateJavaScriptPlugin(String script) async {
    await SystemChannels.platform.invokeMethod('loadJavaScriptPlugin', {
      'script': script,
    });
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

  // 查询数据库，检查是否存在具有特定 URL 的插件记录
  Future<Plugin?> getPluginByUrl(String url) async {
    final List<Map<String, dynamic>> results = await database.query(
      'plugins',
      where: 'url = ?',
      whereArgs: [url],
    );

    if (results.isNotEmpty) {
      return Plugin.fromJson(results.first);
    } else {
      return null;
    }
  }



  // --- Refactored Data Generation Functions ---

  // --- 解析函数 ---

  List<Map<String, dynamic>> _parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
    return csvList.skip(1).map((parts) {
      return {
        'id': parts.isNotEmpty ? parts[0].toString() : null,
        'name': parts.length > 1 ? parts[1].toString() : null,
        'url': parts.length > 2 ? parts[2].toString() : null,
        'version': parts.length > 3 ? parts[3].toString() : null,
        'enabled': parts.length > 4 && parts[4].toString().toLowerCase() == 'true' ? 1 : 0,
        'pluginOrder': parts.length > 5 ? int.tryParse(parts[5].toString()) : null,
      'isAutoUpdate': parts.length > 6 && parts[6].toString().toLowerCase() == 'true' ? 1 : 0,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseJsonData(String data) {
    final jsonData = jsonDecode(data);
    if (jsonData is List) {
      return jsonData.map((plugin) {
        return {
          'id': plugin.containsKey('id') ? plugin['id'] : null,
          'name': plugin.containsKey('name') ? plugin['name'] : null,
          'url': plugin.containsKey('url') ? plugin['url'] : null,
          'version': plugin.containsKey('version') ? plugin['version'] : null,
          'enabled': plugin.containsKey('enabled') && plugin['enabled'] ? 1 : 0,
          'pluginOrder': plugin.containsKey('pluginOrder') ? plugin['pluginOrder'] : null,
        'isAutoUpdate': plugin.containsKey('isAutoUpdate') && plugin['isAutoUpdate'] ? 1 : 0,          
        };
      }).toList();
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }

  List<Map<String, dynamic>> _parseTxtData(String data) {
    final lines = data.split('\n');
    return lines.map((line) {
      final parts = line.split(',');
      return {
        'id': parts.isNotEmpty ? parts[0].toString() : null,
        'name': parts.length > 1 ? parts[1].toString() : null,
        'url': parts.length > 2 ? parts[2].toString() : null,
        'version': parts.length > 3 ? parts[3].toString() : null,
        'enabled': parts.length > 4 && parts[4].toString().toLowerCase() == 'true' ? 1 : 0,
        'pluginOrder': parts.length > 5 ? int.tryParse(parts[5].toString()) : null,
      'isAutoUpdate': parts.length > 6 && parts[6].toString().toLowerCase() == 'true' ? 1 : 0,        
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseYamlData(String data) {
    final yamlData = loadYaml(data) as List;
    return yamlData.map((plugin) {
      return {
        'id': plugin.containsKey('id') ? plugin['id'] : null,
        'name': plugin.containsKey('name') ? plugin['name'] : null,
        'url': plugin.containsKey('url') ? plugin['url'] : null,
        'version': plugin.containsKey('version') ? plugin['version'] : null,
        'enabled': plugin.containsKey('enabled') && plugin['enabled'] ? 1 : 0,
        'pluginOrder': plugin.containsKey('pluginOrder') ? plugin['pluginOrder'] : null,
      'isAutoUpdate': plugin.containsKey('isAutoUpdate') && plugin['isAutoUpdate'] ? 1 : 0,        
      };
    }).toList();
  }

  Future<String> _fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // --- 解析逻辑处理函数 ---

  List<Map<String, dynamic>> _parseData(String data, String source) {
    if (source.endsWith('.csv')) return _parseCsvData(data);
    if (source.endsWith('.json')) return _parseJsonData(data);
    if (source.endsWith('.txt')) return _parseTxtData(data);
    if (source.endsWith('.yaml')) return _parseYamlData(data);
    throw UnsupportedError('Unsupported file format');
  }

  // --- 公共解析函数 ---

  Future<List<Map<String, dynamic>>> parseFromUrl(String url) async {
    final data = await _fetchData(url);
    return _parseData(data, url);
  }

  Future<List<Map<String, dynamic>>> parseFromLocal(String filePath) async {
    final data = await File(filePath).readAsString();
    return _parseData(data, filePath);
  }

  // --- 导入函数 ---

  Future<void> importPluginsFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importPluginsFromLocalFile(String filePath) async {
    await _importFromLocal(filePath);
  }

  // --- 私有导入函数 ---

  Future<void> _importFromUrl(String url) async {
    final plugins = await parseFromUrl(url);
    await _addAllWithUrl(plugins);
  }

  Future<void> _importFromLocal(String filePath) async {
    final plugins = await parseFromLocal(filePath);
    await _addAllWithUrl(plugins);
  }

  // --- 批量添加或更新函数 ---

  Future<void> _addAllWithUrl(List<Map<String, dynamic>> plugins) async {
    final batch = database.batch();
    for (final pluginMap in plugins) {
      // 检查数据库中是否已存在相同的 URL
      final exists = await database.query(
        'plugins',
        where: 'url = ?',
        whereArgs: [pluginMap['url']],
      ).then((results) => results.isNotEmpty);

      if (exists) {
        batch.update(
          'plugins',
          pluginMap,
          where: 'url = ?',
          whereArgs: [pluginMap['url']],
        );
      } else {
        batch.insert('plugins', pluginMap);
      }
    }
    await batch.commit();
  }

  // --- 导出函数 ---

  Future<void> exportPluginsToCsv(
      List<Plugin> plugins, String directoryPath) async {
    await _exportToCsv(plugins, directoryPath);
  }

  Future<void> exportPluginsToJson(
      List<Plugin> plugins, String directoryPath) async {
    await _exportToJson(plugins, directoryPath);
  }

  // --- 数据生成函数 ---

  String _generateCsvData(List<Plugin> plugins) {
    return const ListToCsvConverter().convert(plugins
        .map((plugin) => [
              plugin.id,
              plugin.name,
              plugin.url,
              plugin.version,
              plugin.enabled ? '1' : '0',
              plugin.pluginOrder.toString(),
              plugin.isAutoUpdate ? '1' : '0'              
            ])
        .toList());
  }

  String _generateJsonData(List<Plugin> plugins) {
    final listOfMaps = plugins.map((plugin) => plugin.toJson()).toList();
    return jsonEncode(listOfMaps);
  }

  // --- 私有导出函数 ---

  Future<void> _exportToCsv(
      List<Plugin> plugins, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/plugins_$dateStr.csv';

    final csvData = _generateCsvData(plugins);

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  Future<void> _exportToJson(
      List<Plugin> plugins, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/plugins_$dateStr.json';

    final jsonData = _generateJsonData(plugins);

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }

  // 添加插件 (从 URL)
  Future<void> addPluginFromUrl(String url) async {
    // 查询数据库，检查是否已经存在具有相同 URL 的插件记录
    final existingPlugin = await getPluginByUrl(url);
    if (existingPlugin != null) {
      // 如果插件已存在于数据库中，则不进行添加
      return;
    }

    final response = await HttpClient().getUrl(Uri.parse(url));
    final httpClientResponse = await response.close();
    final script = await utf8.decodeStream(httpClientResponse);

    // 从脚本中提取插件信息
    final plugin = createPluginFromScript(script, url);

    // 保存脚本到本地
    await _saveScriptToLocal(plugin, script);

    // 添加到数据库
    await addPlugin(plugin);

    // 添加到插件列表
    _plugins.add(plugin);
  }

  // 添加插件 (从本地文件)
  Future<void> addPluginFromLocal(String filePath) async {
    // Read script content from local file
    File file = File(filePath);
    if (!file.existsSync()) {
      throw const FileSystemException('File not found');
    }
    List<int> bytes = await file.readAsBytes();
    String script = utf8.decode(bytes);

    // 从脚本中提取插件信息
    final plugin = createPluginFromScript(script, ''); // 本地文件没有 URL

    // 保存脚本到本地
    await _saveScriptToLocal(plugin, script);

    // Add to database
    await addPlugin(plugin);

    // Add to plugins list (if needed in your context)
    _plugins.add(plugin);
  }

  Future<void> loadPlugins() async {

    final plugins = await getAllPlugins();

    // 使用 Future.wait 并行加载插件
    await Future.wait(plugins.map((plugin) async {
      // 加载插件脚本
      await loadScriptFromFile(plugin);
    }));

    _plugins.addAll(plugins);
  }

  Future<void> loadScriptFromFile(Plugin plugin) async {
    final scriptPath = await plugin.getScriptPath(); // 等待获取脚本路径
    final script = await File(scriptPath).readAsString();
    await _webViewController.runJavaScript(script);
  }

  /// 保存插件
  Future<void> savePlugin(Plugin plugin) async {
    // 将插件信息存储到数据库
    await addPlugin(plugin);

    // 如果插件已启用，则加载插件
    if (plugin.enabled) {
      await loadScriptFromFile(plugin);
    }
  }

  // Remove a plugin
  void removePlugin(String id) {
    _plugins.removeWhere((p) => p.id == id);
  }

  // Enable/disable a plugin
  Future<void> setPluginEnabled(String id, bool enabled) async {
    final plugin = _plugins.firstWhere((p) => p.id == id);
    plugin.enabled = enabled;

    // 更新数据库
    await updatePlugin(plugin);

    // 如果插件已启用，则加载插件
    if (plugin.enabled) {
      await loadScriptFromFile(plugin);
    }
  }
  // 启用插件
  Future<void> enablePlugin(Plugin plugin) async {
    // 更新数据库
    await database.update('plugins', {'enabled': true},
        where: 'id = ?', whereArgs: [plugin.id]);

    // 更新插件列表
    plugin.enabled = true;

    // 如果插件已启用，则加载插件
    if (plugin.enabled) {
      print("正在加载插件 ${plugin.name}..."); // 添加 print 语句
      await loadScriptFromFile(plugin);
      print("插件 ${plugin.name} 加载完成"); // 添加 print 语句
    }
  }

  // 禁用插件
  Future<void> disablePlugin(Plugin plugin) async {
    // 更新数据库
    await database.update('plugins', {'enabled': false},
        where: 'id = ?', whereArgs: [plugin.id]);

    // 更新插件列表
    plugin.enabled = false;
  }


  // Sort plugins by their pluginOrder
  void sortPlugins() {
    _plugins.sort((a, b) => a.pluginOrder.compareTo(b.pluginOrder));
  }

/*
  // Get all enabled plugins
  List<Plugin> getEnabledPlugins() {
    return _plugins.where((p) => p.enabled).toList();
  }
*/

// Get all enabled plugins from database
Future<List<Plugin>> getEnabledPlugins() async {
  final List<Map<String, dynamic>> results = await database.query(
    'plugins',
    where: 'enabled = ?',
    whereArgs: [1], // 1 represents true
  );
  return results.map((row) => Plugin.fromJson(row)).toList();
}


  /// 手动更新插件
  Future<void> manualUpdatePlugin(Plugin plugin) async {
    // 直接调用更新插件方法
    await updatePlugin(plugin);
  }

  /// 自动更新插件
  Future<void> autoUpdatePlugin(Plugin plugin) async {
    // 获取对象名称
    const objectName = 'PluginUpdate';

    // 判断是否需要更新插件
    if (await shouldUpdate(objectName)) {
      // 执行插件更新操作
      await updatePluginFromUrl(plugin);

      // 更新服务的最后更新时间
      updateService(objectName);
    }
  }

  /// Automatically update plugins
  void startAutoUpdate() {
    for (final plugin in _plugins) {
      if (plugin.enabled) {
        // 自动更新插件
        autoUpdatePlugin(plugin);
      }
    }
  }

  // 加载 JavaScript 插件
  Future<void> loadPlugin(Plugin plugin) async {
    final scriptPath = await plugin.getScriptPath();
    final script = await File(scriptPath).readAsString();

    await _webViewController.runJavaScript(script);
    loadedPlugins[plugin.id] = script;
  }

  // 调用所有已启用插件的函数查询
  Future<Map<String, dynamic>?> callPlugins(
      String? phoneNumber, String? nationalNumber, String? e164Number) async {
    // 存储每个插件返回的结果        
    List<Map<String, dynamic>> results = [];
    // 获取已启用的插件列表    
    final enabledPlugins = await getEnabledPlugins();
       // 将 enabledPlugins 转换为插件ID列表 
    final enabledPluginIds = enabledPlugins.map((plugin) => plugin.id).toList();

    if (enabledPluginIds.isEmpty) { 
      print('没有插件启用');
      return null;
    }

    // 遍历所有已启用的插件，调用相应的函数并获取返回结果
    for (var pluginId in enabledPluginIds) {
       // 从已加载的插件中获取插件对象     
      var pluginScript = loadedPlugins[pluginId];
      if (pluginScript != null) {
                // 调用 JavaScript 函数并传递参数
        var result = await _webViewController.runJavaScriptReturningResult(
            "$pluginScript.generateOutput('${phoneNumber ?? ''}', '${nationalNumber ?? ''}', '${e164Number ?? ''}')");

        // 将 JavaScript 返回结果解析为 Dart Map，并添加到结果列表中
        var resultMap = Map<String, dynamic>.from(result as Map);
       // 检查结果是否有效（例如，检查 count 是否大于 0）
        if (isValidResult(resultMap)) {
          results.add({
            'phoneNumber': resultMap['phoneNumber'],
            'sourceLabel': resultMap['sourceLabel'],
            'count': resultMap['count'],
            'predefinedLabel': resultMap['predefinedLabel'],
            'source': resultMap['source'],
          });
        }
      }
    }

  // 返回第一个有效结果，如果所有插件都返回空值，则返回 null
    return results.isNotEmpty ? results.first : null;
  }

  // 定义一个函数来检查结果是否有效
  bool isValidResult(Map<String, dynamic> result) {
    return result['count'] != null && result['count'] > 0;
  }

  // 保存脚本到本地
  Future<void> _saveScriptToLocal(Plugin plugin, String script) async {
    final scriptPath = await plugin.getScriptPath();
    final scriptFile = File(scriptPath);
    await scriptFile.parent.create(recursive: true);
    await scriptFile.writeAsString(script);
  }

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
}

// 设置默认的外部存储目录
Future<void> setDefaultStorageDirectory() async {
  final result = await FilePicker.platform.getDirectoryPath();
  if (result != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('defaultExternalStorageDirectory', result);
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
    final prefs = await SharedPreferences.getInstance();
    final userSelectedDirectory = prefs.getString('defaultExternalStorageDirectory');

    if (userSelectedDirectory != null) {
      return userSelectedDirectory;
    }

    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    return appDocumentsDirectory.path;
  }
