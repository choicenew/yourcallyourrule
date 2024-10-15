import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/services.dart';
//import 'dart:js';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as localLabel;
import 'package:sqflite/sqflite.dart';

//import '../services/blacklist_whitelist_service.dart';
//import 'package:sqflite/sqflite.dart' as blacklistWhitelist;
import '../utils/update_interval.dart';
import 'label_service.dart';

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
        url TEXT NOT NULL,
        version TEXT NOT NULL,
        enabled INTEGER NOT NULL,
        order INTEGER NOT NULL,
        script TEXT  -- Add this line
      )
    ''');
  }
}

// Define the Plugin interface
class Plugin {
  String id;
  String name;
  String url;
  String version;
  bool enabled;
  int order;
  String script;

  Plugin({
    required this.id,
    required this.name,
    required this.url,
    required this.version,
    required this.enabled,
    required this.order,
    required this.script,
  });

  // 具体实现 toJson 方法
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'version': version,
      'enabled': enabled ? 1 : 0,
      'order': order,
      'script': script,
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
      order: json['order'] ?? 0,
      script: json['script'] ?? '',
    );
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
  // final PluginServiceModel pluginServiceModel;

  //PluginService(this.database)
  //     : pluginServiceModel = PluginServiceModel(database: database);

  Future<void> addPlugin(Plugin plugin) async {
    await database.insert('plugins', plugin.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }




  Future<List<Plugin>> getAllPlugins() async {
    final List<Map<String, dynamic>> maps = await database.query('plugins');
    return List.generate(maps.length, (i) => Plugin.fromJson(maps[i]));
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
  Future<void> deletePlugin(String id) async {
    await database.delete('plugins', where: 'id = ?', whereArgs: [id]);
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
        plugin.toJson(), // 将插件对象转换为 Map，用于更新
        where: 'id = ?',
        whereArgs: [plugin.id],
      );
    } else {
      // 如果未找到相应的插件，则插入新记录
      await database.insert('plugins', plugin.toJson());
    }
  }

/*
// 编辑插件
  Future<void> editPlugin(String id, String newUrl, String newName,
      String newVersion, String newScript) async {
    // 根据插件 ID 从数据库中获取插件
    Plugin? existingPlugin = await getPluginById(id);
    if (existingPlugin == null) {
      // 如果找不到相应的插件，则无法编辑
      throw Exception('Plugin with ID $id not found');
    }

    // 创建更新后的插件对象
    Plugin updatedPlugin = Plugin(
      id: id,
      name: newName,
      url: newUrl,
      version: newVersion,
      enabled: existingPlugin.enabled,
      order: existingPlugin.order,
      script: newScript,
    );

    // 更新数据库中的插件记录
    await updatePlugin(updatedPlugin);
  }
*/
// 从 URL 中获取最新版本
  Future<void> updatePluginFromUrl(Plugin plugin) async {
    if (plugin.script.isNotEmpty) {
      // 如果是 JavaScript 插件，则从 URL 中获取最新版本信息
      final response = await http.get(Uri.parse(plugin.url));
      if (response.statusCode != 200) {
        throw Exception('无法获取 JavaScript 插件更新信息: ${response.statusCode}');
      }

      final script = utf8.decode(response.bodyBytes); // 解码响应主体以获取脚本内容

      final remoteVersion = extractRemoteVersion(script);

      // 检查是否有更新版本
      if (isNewerVersion(remoteVersion, plugin.version)) {
        final script = response.body;

        // 更新数据库中插件的版本号为远程版本号
        await database.update(
            'plugins', {'version': remoteVersion, 'script': script},
            where: 'url = ?', whereArgs: [plugin.url]);
        // 执行更新操作
        await updateJavaScriptPlugin(script);
      } else {
        print('当前插件已经是最新版本');
      }
    }
  }

// 检查是否有更新版本的方法
  bool isNewerVersion(String remoteVersion, String currentVersion) {
    // 这里是一个简单的比较方法，你可以根据具体的版本号规范来实现更复杂的比较逻辑
    return remoteVersion.compareTo(currentVersion) > 0;
  }

// 更新 JavaScript 插件的方法
  Future<void> updateJavaScriptPlugin(String script) async {
    // 调用平台方法加载 JavaScript 插件
    await SystemChannels.platform.invokeMethod('loadJavaScriptPlugin', {
      'script': script,
    });
  }

  String extractRemoteVersion(String script) {
    // 从插件脚本中提取远程版本号
    // 这里假设你的插件脚本中有一个类似于"version: '1.0.0',"的版本号定义
    // 你需要根据实际情况来编写相应的逻辑
    // 下面是一个示例：
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
      return Plugin.fromJson(
          results.first); // 使用 Plugin.fromJson 方法将数据库结果映射为 Plugin 对象
    } else {
      return null;
    }
  }

  // Add a new plugin from URL
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

    // 创建 Plugin 实例并添加到数据库和插件列表中
    final plugin = Plugin(
      id: '',
      name: '',
      url: url,
      version: '',
      enabled: false,
      order: 0,
      script: script, // Assign JavaScript script directly
    );

    // 添加到数据库
    await addPlugin(plugin);

    // 添加到插件列表
    _plugins.add(plugin);
  }

  // Add a new plugin from local
  Future<void> addPluginFromLocal(String filePath) async {


    // Read script content from local file
    File file = File(filePath);
    if (!file.existsSync()) {
      throw FileSystemException('File not found');
    }
    List<int> bytes = await file.readAsBytes();
    String script = utf8.decode(bytes);

    // Create Plugin instance
    final plugin = Plugin(
      id: '',
      name: '',
      url: '', // You might want to set this to indicate it's from local file
      version: '',
      enabled: false,
      order: 0,
      script: script, // Assign JavaScript script directly
    );

    // Add to database
    await addPlugin(plugin);

    // Add to plugins list (if needed in your context)
    _plugins.add(plugin);
  }
//导出csv 数据

  Future<void> exportPluginsToCsv(List<Plugin> plugins, String s) async {
    // 生成文件名
    final fileName = 'plugins-${DateTime.now().toString().split(' ')[0]}.csv';

    // 打开文件流
    final File file = File(fileName);
    final sink = file.openWrite();

    // 写入 CSV 头部
    sink.writeln('ID,Name,URL,Version,Enabled,Order,Script');

    // Convert subscriptions to a list of lists
    final List<List<dynamic>> pluginLists = plugins.map((plugin) {
      return [
        plugin.id,
        plugin.name,
        plugin.url,
        plugin.version,
        plugin.enabled,
        plugin.order,
        plugin.script
      ];
    }).toList();

    // Convert subscription lists to CSV data and write to file
    final csvData = ListToCsvConverter().convert(pluginLists);
    sink.write(csvData);

    // 关闭文件流
    await sink.close();
  }

//导出json 数据
  Future<void> exportPluginsToJson(List<Plugin> plugins, String s) async {
    // 生成文件名
    final fileName = 'plugins-${DateTime.now().toString().split(' ')[0]}.json';

    // 将订阅列表转换为 JSON 格式
    final jsonPlugins = plugins.map((plugin) => plugin.toJson()).toList();

    // 将 JSON 数据写入文件
    final File file = File(fileName);
    await file.writeAsString(json.encode(jsonPlugins));
  }

  /// 从 JSON 文件加载多个插件
  // import plugins from JSON file
  Future<void> importPluginsFromJson(String filePath) async {
    final jsonString = await File(filePath).readAsString();
    final List<dynamic> pluginDataList = jsonDecode(jsonString);

    for (var pluginData in pluginDataList) {
      final url = pluginData['url'];
      await addPluginFromUrl(url);
    }
  }

  // import plugins from url JSON
  Future<void> importPluginsFromUrlJson(String url) async {
    final response = await HttpClient().getUrl(Uri.parse(url));
    final httpClientResponse = await response.close();
    final jsonString = await utf8.decodeStream(httpClientResponse);
    final List<dynamic> pluginDataList = jsonDecode(jsonString);

    for (var pluginData in pluginDataList) {
      final pluginUrl = pluginData['url'];
      await addPluginFromUrl(pluginUrl);
    }
  }

// 从 CSV 导入 数据
  Future<void> importPluginsFromCsv(String csvContent) async {
    Database database = await _initDatabase(); // 获取数据库实例

    // 解析 CSV 数据
    final List<List<dynamic>> lines = CsvToListConverter().convert(csvContent);

    for (final line in lines) {
      if (line.length != 9) {
        continue;
      }

      final url = line[2];
      // 检查数据库中是否已存在相同的 URL
      final existingPlugin = await database.query(
        'plugins',
        where: 'url = ?',
        whereArgs: [url],
      );

      if (existingPlugin.isNotEmpty) {
        // 如果 URL 已存在，则跳过更新
        continue;
      }

      // 创建订阅模型
      final plugin = Plugin(
        id: line[1],
        name: line[2],
        url: url,
        version: line[4],
        enabled: line[5] == 'false',
        order: int.parse(line[6] as String), // 将索引 6 的字段解析为整数
        script: line[7],
      );

      // 插入数据库
      await database.insert('plugins', plugin.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  //从本地文件导入
  Future<void> importPluginsFromLocalFile(File file) async {
    // 判断文件是否存在
    if (!file.existsSync()) {
      return; // 文件不存在，直接返回
    }

    // 获取文件内容
    final fileContent = await file.readAsString();

    // 获取文件类型
    final fileType = file.path.split('.').last;
    if (fileType == 'csv') {
      // 导入 CSV 文件
      await importPluginsFromCsv(fileContent);
    } else if (fileType == 'json') {
      // 导入 JSON 文件
      await importPluginsFromJson(fileContent);
    }
  }

  Future<void> loadPlugins() async {
    //await pluginManagerModel.init();
    await _initDatabase(); // 初始化数据库
    final plugins = await getAllPlugins();

    // 使用 Future.wait 并行加载插件
    await Future.wait(plugins.map((plugin) async {
      // 加载插件脚本
      await loadScript(plugin.script);
    }));

    _plugins.addAll(plugins);
  }

  Future<void> loadScript(String script) async {
    // Execute JavaScript code using evaluateJavascript
    await _webViewController.runJavaScript(script);
  }

  /// 保存插件
  Future<void> savePlugin(Plugin plugin) async {
    // 将插件信息存储到数据库
    await addPlugin(plugin);

    // 如果插件已启用，则加载插件
    if (plugin.enabled) {
      await loadScript(plugin.script);
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

    // 如果插件已启用，则加载插件
    if (plugin.enabled) {
      await loadScript(plugin.script);
    }
  }

  // Sort plugins by their order
  void sortPlugins() {
    _plugins.sort((a, b) => a.order.compareTo(b.order));
  }

  // Get all enabled plugins
  List<Plugin> getEnabledPlugins() {
    return _plugins.where((p) => p.enabled).toList();
  }

  /// 手动更新插件
  Future<void> manualUpdatePlugin(Plugin plugin) async {
    // 直接调用更新插件方法
    await updatePlugin(plugin);
  }

  /// 自动更新插件
  /// 自动更新插件
  Future<void> autoUpdatePlugin(Plugin plugin) async {
    // 获取对象名称
    final objectName = 'PluginUpdate';

    // 判断是否需要更新插件
    if (await shouldUpdate(objectName)) {
      // 执行插件更新操作
      await updatePlugin(plugin);

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

  // 添加一个 Map 用于存储已加载的插件对象
  //static Map<String, dynamic> loadedPlugins = {};

// 加载 JavaScript 插件
  Future<void> loadPlugin(String id, String script) async {
    // 使用 evaluateJavascript 方法执行 JavaScript 插件脚本
    // Execute JavaScript plugin script using runJavaScript method
    await _webViewController.runJavaScript(script);
    // 将已加载的插件对象保存到 loadedPlugins 中，如果需要的话
    loadedPlugins[id] = script;
    // 这里假设 loadedPlugins 是一个 Map<String, String>，保存插件的 id 和脚本内容
  }

  // 调用所有已启用插件的函数查询
  Future<Map<String, dynamic>?> callPlugins(
      String? phoneNumber, String? nationalNumber, String? e164Number) async {
    // 存储每个插件返回的结果
    List<Map<String, dynamic>> results = [];
    // 获取已启用的插件列表
    final enabledPlugins = getEnabledPlugins();
    // 将 enabledPlugins 转换为插件ID列表
    final enabledPluginIds = enabledPlugins.map((plugin) => plugin.id).toList();

  // 如果没有插件启用，直接返回 null
  if (enabledPluginIds.isEmpty) {
    print('没有插件启用'); // 添加日志记录
    return null;
  }

    // 遍历所有已启用的插件，调用相应的函数并获取返回结果
    for (var pluginId in enabledPluginIds) {
      // 从已加载的插件中获取插件对象
      var plugin = loadedPlugins[pluginId];
      if (plugin != null) {
        // 调用 JavaScript 函数并传递参数
        var result = await _webViewController.runJavaScriptReturningResult(
            "$plugin.generateOutput('${phoneNumber ?? ''}', '${nationalNumber ?? ''}', '${e164Number ?? ''}')");

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
  // 根据你的需求定义有效结果的条件
  // 例如，检查 count 是否大于 0
  return result['count'] != null && result['count'] > 0;
}


}

/*
class PluginLabelService {
  final Database database;

  PluginLabelService(this.database);

  Future<Map<String, String>?> getLabelByPhoneNumber(String phoneNumber) async {
    // 1. 解析电话号码
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);

    // 2. 格式化为 E.164 格式和本地格式的号码
    final e164Number = PhoneNumberUtil.instance
        .format(parsedPhoneNumber, PhoneNumberFormat.e164);
    final nationalNumber = PhoneNumberUtil.instance
        .format(parsedPhoneNumber, PhoneNumberFormat.national);

    // 创建 PluginManager 的实例
    final pluginService = PluginService(database);
    // 调用所有已启用插件的函数查询
    final Map<String, dynamic>? labelData =
        await pluginService.callPlugins(phoneNumber, nationalNumber, e164Number);

// 等待 labelData 解析完成后，提取所需信息
    final sourceLabel = labelData?['sourceLabel'];
    final source = labelData?['source'];
    final count = labelData?['count'];
    final predefinedLabel = labelData?['predefinedLabel'];

    /*
    // 查询黑白名单中的标签

    // 打开数据库
    final _databaseName = "number_control_list.db";

    final _database = await blacklistWhitelist.openDatabase(_databaseName);


    // 创建 listService 实例
    final blacklistService = BlacklistService(_database);
    final whitelistService = WhitelistService(_database);
    // 通过电话号码获取标签

    final blacklistLabel =
        await blacklistService.getLabelByPhoneNumber(phoneNumber);
    final whitelistLabel =
        await whitelistService.getLabelByPhoneNumber(phoneNumber);
   */

    // 查询本地label service的标签

    // 打开数据库
    final _labelServiceDatabaseName = "call_rule_database.db";

    final _labelServiceDatabase =
        await localLabel.openDatabase(_labelServiceDatabaseName);

    // 创建 listService 实例
    final labelService = LabelService(_labelServiceDatabase);

    // 通过电话号码获取标签

    final existingLabel =
        await labelService.getLabelFromPhoneNumber(phoneNumber);

// 如果数据库中没有标签，则插入标签；否则更新标签信息

    if (existingLabel == null) {
      await _labelServiceDatabase.insert('labels', {
        'phoneNumber': phoneNumber,
        'label': predefinedLabel,
      });
    } else {
      await _labelServiceDatabase.update(
        'labels',
        {
          'label': predefinedLabel,
        },
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
      );
    }

    /* 合并所有标签数据
    final labelExists = blacklistLabel != null ||
        whitelistLabel != null ||
        existingLabel != null;
    // 如果数据库中没有标签，则插入标签
    if (!labelExists) {
      await database.insert('labels', {
        'phoneNumber': phoneNumber,
        'label': predefinedLabel,
      });
    } else {
      // 数据库中有标签，则更新标签信息
      await database.update(
          'labels',
          {
            'label': predefinedLabel,
          },
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber]);
    }

    */
    //返回标签数据
    return {
      'sourceLabel': sourceLabel,
      'source': source,
      'count': count,
      'predefinedLabel':
          predefinedLabel, // Added this to include all relevant data
    };
  }
}
*/