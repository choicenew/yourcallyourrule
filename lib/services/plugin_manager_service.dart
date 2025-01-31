// 导入必要的库
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
import 'package:webview_flutter/webview_flutter.dart';
// 引入 Android 平台相关的包
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:yaml/yaml.dart';

import '../../utils/update_interval.dart';
import '../utils/http_interceptor.dart';

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
  late HttpInterceptor _httpInterceptor; // 添加 HttpInterceptor 对象

// 存储每个插件查询的 Completer
  Map<String, Completer<Map<String, dynamic>?>> _pluginQueryCompleters = {};

  // 跟踪每个插件的就绪状态
  final Map<String, bool> _pluginReadyStatus = {};

  // 用于通知插件就绪状态的 StreamController
  final StreamController<String> _pluginReadyController = StreamController<String>.broadcast();


  PluginService(this.database) {
    _httpInterceptor = HttpInterceptor(); // 初始化 HttpInterceptor
    _initializeWebView();
  }

void _initializeWebView() {
  late final PlatformWebViewControllerCreationParams params;
  if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    params = WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
      mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    );
  } else {
    params = const PlatformWebViewControllerCreationParams();
  }

  _webViewController = WebViewController.fromPlatformCreationParams(params)
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..addJavaScriptChannel(
      'TestPageChannel',
      onMessageReceived: (JavaScriptMessage message) async {
        // 处理来自 JavaScript 的消息 (例如插件加载、就绪状态等)
        print('message信息: ${message.message}');
        try {
          final jsonData = jsonDecode(message.message);
          print('jsonData打印: $jsonData');

          if (jsonData['type'] == 'pluginLoaded') {
            print('Plugin loaded打印: ${jsonData['pluginId']}');
          } else if (jsonData['type'] == 'pluginReady') {
            print('Plugin ready: ${jsonData['pluginId']}');

              // 1. 标记插件为就绪状态
              _pluginReadyStatus[jsonData['pluginId']] = true;
              print('Plugin marked as ready插件就绪 in _pluginReadyStatus: ${jsonData['pluginId']}');
              // 2. 通过 StreamController 发送插件就绪通知
              _pluginReadyController.add(jsonData['pluginId']);
              print('Plugin ready 准备通知notification sent via _pluginReadyController: ${jsonData['pluginId']}');


          } else if (jsonData['type'] == 'pluginError') {
            print('Plugin error: ${jsonData['error']}');
          }
        } catch (e) {
          print('Received message: ${message.message}');
        }
      },
    )
    ..addJavaScriptChannel(
      'consoleLog',
      onMessageReceived: (JavaScriptMessage message) {
        print('JS Console Log: ${message.message}');
      },
    )
    ..addJavaScriptChannel(
      'consoleWarn',
      onMessageReceived: (JavaScriptMessage message) {
        print('JS Console Warn: ${message.message}');
      },
    )
    ..addJavaScriptChannel(
      'consoleError',
      onMessageReceived: (JavaScriptMessage message) {
        print('JS Console Error: ${message.message}');
      },
    )
    ..addJavaScriptChannel(
      'PluginResultChannel',
      onMessageReceived: (JavaScriptMessage message) {
        print('Received message on PluginResultChannel: ${message.message}');
        try {
          final Map<String, dynamic> decodedMessage = jsonDecode(message.message);
          final pluginId = decodedMessage['pluginId'];
          final requestId = decodedMessage['requestId'];

          // 检查消息类型和 requestId 是否存在于 _pluginQueryCompleters 中
          if (decodedMessage['type'] == 'pluginResult' &&
              _pluginQueryCompleters.containsKey(requestId)) {
            final data = Map<String, dynamic>.from(decodedMessage['data']);
                    // 明确打印即将执行 complete 操作
        print('Completing Completer for requestId: $requestId with data: $data'); 
            // 完成对应的 Completer
            _pluginQueryCompleters[requestId]!.complete(data);
                    print('Completer for requestId: $requestId completed'); 
            _pluginQueryCompleters.remove(requestId); // 成功完成，移除 Completer
          } else if (decodedMessage['type'] == 'pluginError' &&
              _pluginQueryCompleters.containsKey(requestId)) {
            // 错误完成对应的 Completer
             print('Completing Completer with error for requestId: $requestId');
            _pluginQueryCompleters[requestId]!.completeError(
              decodedMessage['error'] ?? 'Unknown error from plugin',
            );
            _pluginQueryCompleters.remove(requestId); // 错误完成，移除 Completer
          }
        } catch (e) {
          print('Error processing message on PluginResultChannel: $e');
          // 可以在这里处理解析错误，例如记录日志或完成对应的 Completer（如果有的话）
        }
      },
    )
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (String url) async {},
        onWebResourceError: (WebResourceError error) {
          print('Page loading error: ${error.description}');
        },
      ),
    );

  if (_webViewController.platform is AndroidWebViewController) {
    AndroidWebViewController.enableDebugging(false);
    (_webViewController.platform as AndroidWebViewController)
        .setMediaPlaybackRequiresUserGesture(false);
  }

    // 初始化 HTTP 拦截器
    _httpInterceptor.register(_webViewController);

    //_webViewController.loadRequest(Uri.parse('about:blank'));
}

  Future<void> addPlugin(Plugin plugin) async {
    await database.insert('plugins', plugin.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Plugin>> getAllPlugins(
      {String? orderBy, bool ascending = true}) async {
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
    final scriptPath =
        '${await Plugin._getPluginsDirectory().then((dir) => dir.path)}/${plugin.id}.js';
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
      } else {}
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
        'enabled':
            parts.length > 4 && parts[4].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'pluginOrder':
            parts.length > 5 ? int.tryParse(parts[5].toString()) : null,
        'isAutoUpdate':
            parts.length > 6 && parts[6].toString().toLowerCase() == 'true'
                ? 1
                : 0,
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
          'pluginOrder':
              plugin.containsKey('pluginOrder') ? plugin['pluginOrder'] : null,
          'isAutoUpdate':
              plugin.containsKey('isAutoUpdate') && plugin['isAutoUpdate']
                  ? 1
                  : 0,
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
        'enabled':
            parts.length > 4 && parts[4].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'pluginOrder':
            parts.length > 5 ? int.tryParse(parts[5].toString()) : null,
        'isAutoUpdate':
            parts.length > 6 && parts[6].toString().toLowerCase() == 'true'
                ? 1
                : 0,
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
        'pluginOrder':
            plugin.containsKey('pluginOrder') ? plugin['pluginOrder'] : null,
        'isAutoUpdate':
            plugin.containsKey('isAutoUpdate') && plugin['isAutoUpdate']
                ? 1
                : 0,
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

  Future<void> _exportToCsv(List<Plugin> plugins, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/plugins_$dateStr.csv';

    final csvData = _generateCsvData(plugins);

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  Future<void> _exportToJson(List<Plugin> plugins, String directoryPath) async {
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

/*
  Future<void> loadScriptFromFile(Plugin plugin) async {
    final scriptPath = await plugin.getScriptPath();
    final script = await File(scriptPath).readAsString();

    // 为每个插件加载一个带有唯一标识的 HTML 页面
    // await _webViewController.loadHtmlString('<html><body id="${plugin.id}"></body></html>');

    // 在全局作用域中创建一个以插件 ID 命名的对象
    final jsObject = 'window.plugin["${plugin.id}"] = {};';
    await _webViewController.runJavaScript(jsObject);

    // 将插件脚本添加到该对象中
    await _webViewController.runJavaScript('''
    (function() {
      ${script}
    })();
  ''');

    loadedPlugins[plugin.id] = 'window.plugin["${plugin.id}"]';
  }
*/


  // 使用 Map 来跟踪每个插件的就绪状态
  // 加载单个插件
  Future<void> loadScriptFromFile(Plugin plugin) async {
    final scriptPath = await plugin.getScriptPath();
    final script = await File(scriptPath).readAsString();

    print('Executing script for plugin: ${plugin.id}');

    // 重置插件就绪状态
    _pluginReadyStatus[plugin.id] = false;

    // 执行 JS 插件代码
    await _webViewController.runJavaScript('''
      (function() {
        $script
      })();
    ''');

    print('Waiting for pluginReady message for plugin: ${plugin.id}');

    loadedPlugins[plugin.id] = 'window.plugin["${plugin.id}"]';
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
      // 添加 print 语句
      await loadScriptFromFile(plugin);
      // 添加 print 语句
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


  // 辅助函数：等待插件就绪
  Future<void> waitForPluginReady(String pluginId) async {
    // 如果插件已经就绪，则直接返回
    if (_pluginReadyStatus[pluginId] == true) {
      return;
    }

    // 创建一个 Completer，用于等待插件就绪
    final completer = Completer<void>();

    // 监听 _pluginReadyController 的流，等待指定 pluginId 的插件就绪
    StreamSubscription? sub;
    sub = _pluginReadyController.stream.listen((readyPluginId) {
      if (readyPluginId == pluginId) {
        // 如果等待的插件已就绪，则完成 Completer
        if (!completer.isCompleted) {
          completer.complete();
        }
        // 取消订阅，因为已经找到并等待的插件已就绪
        sub?.cancel();
      }
    });

    // 设置超时时间，如果在指定时间内插件未就绪，则打印提示信息
    await completer.future.timeout(const Duration(seconds: 5), onTimeout: () {
      print('Timeout: Plugin $pluginId did not send pluginReady message.');
      // 超时后取消订阅
      sub?.cancel();
    });
  }


  // 调用所有已启用插件的函数查询
  // 调用所有已启用插件的函数查询 (修正此函数)
Future<Map<String, dynamic>?> callPlugins(
    String? phoneNumber,
    String? nationalNumber,
    String? e164Number,
  ) async {
    final enabledPlugins = await getEnabledPlugins();
    final enabledPluginIds = enabledPlugins.map((plugin) => plugin.id).toList();

    if (enabledPluginIds.isEmpty) {
      print('No enabled plugins to call.');
      return null;
    }

    print('Enabled plugin IDs: $enabledPluginIds');

    // 1. 加载并等待所有启用的插件就绪
    for (var pluginId in enabledPluginIds) {
      if (!loadedPlugins.containsKey(pluginId) || _pluginReadyStatus[pluginId] != true) {
        final plugin = await getPluginById(pluginId);
        if (plugin != null) {
          print('Attempting to load script for plugin: $pluginId');
          await loadScriptFromFile(plugin);
          print('Finished loadScriptFromFile for plugin: $pluginId');

          // 等待当前插件就绪
          print('Waiting for pluginReady: $pluginId');
          await waitForPluginReady(pluginId);
          print('Plugin ready confirmed: $pluginId');
        }
      }
    }

    // 2. 执行所有已就绪插件的查询函数
    print('Calling plugins: $enabledPluginIds');

    // 用于存储所有插件查询任务的 Future
    List<Future<Map<String, dynamic>?>> futures = [];
    // 用于存储所有插件查询的 Completer (为了在最后清理)
    List<Completer<Map<String, dynamic>?>> completers = [];

    for (var pluginId in enabledPluginIds) {
      final requestId = 'query_${pluginId}_${DateTime.now().millisecondsSinceEpoch}';
      // 为每个插件查询创建一个 Completer
      final completer = Completer<Map<String, dynamic>?>();
      _pluginQueryCompleters[requestId] = completer;
      completers.add(completer);

      // 将每个插件查询的 Future 添加到 futures 列表中
      futures.add(completer.future);

      print('开始执行generateOutput');
      // 执行 JavaScript 查询代码
      if (loadedPlugins.containsKey(pluginId)) {
        await _webViewController.runJavaScript('''
          (function(pluginId) {
            if (window.plugin && window.plugin[pluginId]) {
              window.plugin[pluginId].generateOutput(
                "$phoneNumber",
                "$nationalNumber",
                "$e164Number",
                "$requestId"
              );
            } else {
              console.error('Plugin not found or not loaded:', pluginId);
            }
          })('$pluginId');
        ''');
      } else {
        print('Plugin object not found for pluginId: $pluginId');
      }
    }
    print('完成执行generateOutput');

    // 3. 等待第一个有效的插件结果
    print('Waiting for first valid result...');
    Map<String, dynamic>? validResult;
    for (var future in futures) {
      try {
        final result = await future;
        if (result != null && isValidResult(result)) {
          validResult = result;
          print('Valid result found: $validResult');
          break; // 找到有效结果，跳出循环
        }
      } catch (error) {
        print('Error in plugin future: $error');
      }
    }

    // 4. 清理并返回结果
    print('Cleaning up completers...');
    _pluginQueryCompleters.clear(); // 清理 Completers

    print('Final result: $validResult');
    return validResult;
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
  final userSelectedDirectory =
      prefs.getString('defaultExternalStorageDirectory');

  if (userSelectedDirectory != null) {
    return userSelectedDirectory;
  }

  final appDocumentsDirectory = await getApplicationDocumentsDirectory();
  return appDocumentsDirectory.path;
}
