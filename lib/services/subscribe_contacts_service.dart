import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yaml/yaml.dart';

import '../utils/update_interval.dart';



Database? _database;

Future<Database> get database async {
  if (_database != null) return _database!;

  _database = await _initDatabase();
  return _database!;
}

Future<Database> _initDatabase() async {
  final String path =
      join(await getDatabasesPath(), 'call_rule_database.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: createDatabase,
  );
}

Future<void> createDatabase(Database db, int version) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS contact_subscriptions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      url TEXT,
      enabled INTEGER,
      last_updated TEXT,
      isAutoUpdate INTEGER
    )
  ''');
}

class ContactSubscriptionModel {
  int? id;
  String name;
  String url;
  bool enabled;
  DateTime lastUpdated;
  bool isAutoUpdate;

  ContactSubscriptionModel({
    this.id,
    required this.name,
    required this.url,
    this.enabled = true,
    DateTime? lastUpdated, // 将 lastUpdated 声明为可空类型
    this.isAutoUpdate = false,
  }) : lastUpdated = lastUpdated ?? DateTime.now(); // 使用空值合并运算符设置默认值

  /// 将对象转换为 JSON 格式
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'enabled': enabled ? 1 : 0, // 布尔值转换为整数
        'lastUpdated': lastUpdated.toIso8601String(),
        'isAutoUpdate': isAutoUpdate ? 1 : 0, // 布尔值转换为整数
      };

  /// 从 JSON 格式构建对象
  static ContactSubscriptionModel fromJson(Map<String, dynamic> json) =>
      ContactSubscriptionModel(
        id: json['id'] as int?,
        name: json['name'] as String,
        url: json['url'] as String,
        enabled: (json['enabled'] as int) == 1, // 整数转换为布尔值
        lastUpdated: json['lastUpdated'] != null
            ? DateTime.tryParse(json['lastUpdated'] as String) ?? DateTime.now()
            : DateTime.now(),
        isAutoUpdate: (json['isAutoUpdate'] as int) == 1, // 整数转换为布尔值
      );
}

class SubscribeContactsService {
  late final Database database;

  SubscribeContactsService(this.database);




  Future<List<ContactSubscriptionModel>> getAllSubscriptions({String? orderBy, bool ascending = true}) async {
    final List<Map<String, dynamic>> results = await database.query(
      'contact_subscriptions',
      orderBy:
          orderBy != null ? '$orderBy ${ascending ? 'ASC' : 'DESC'}' : null,
    );
    return results.map((row) => ContactSubscriptionModel.fromJson(row)).toList();
  }





// 编辑订阅
  Future<void> editSubscription(ContactSubscriptionModel subscription) async {
    // Update the subscription in the database
    await database.update('contact_subscriptions', subscription.toJson(),
        where: 'id = ?', whereArgs: [subscription.id]);
  }

// 删除订阅订阅
  Future<void> deleteSubscription(ContactSubscriptionModel subscription) async {
    await database.delete('contact_subscriptions',
        where: 'id = ?', whereArgs: [subscription.id]);
  }

  // 插入数据库
  Future<void> insertSubscription(ContactSubscriptionModel subscription) async {
    await database.insert('contact_subscriptions', subscription.toJson());
  }

  // 根据 url 查询订阅
  Future<ContactSubscriptionModel?> getSubscriptionByUrl(String url) async {
    final maps = await database
        .query('contact_subscriptions', where: 'url = ?', whereArgs: [url]);
    return maps.isNotEmpty ? ContactSubscriptionModel.fromJson(maps.first) : null;
  }

  // 根据 ID 查询订阅
  Future<ContactSubscriptionModel?> getSubscriptionById(int id) async {
    final maps = await database
        .query('contact_subscriptions', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty ? ContactSubscriptionModel.fromJson(maps.first) : null;
  }




  // 检查订阅是否存在
  Future<bool> urlExists(String url) async {
    final maps = await database
        .query('contact_subscriptions', where: 'url = ?', whereArgs: [url]);
    return maps.isNotEmpty;
  }

  // 添加订阅
  Future<void> addSubscription(ContactSubscriptionModel subscription) async {
  

    // 将订阅插入数据库
  // 将订阅插入数据库，如果 URL 已经存在，则替换原来的订阅项
  await database.insert('contact_subscriptions', subscription.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }



  // 根据是否启用查询订阅
  Future<List<ContactSubscriptionModel>> getSubscriptionsByEnabled(
      bool enabled) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'contact_subscriptions',
      where: 'enabled = ?',
      whereArgs: [enabled ? 1 : 0], // Convert bool to integer for SQLite
    );
    return List.generate(
      maps.length,
      (i) => ContactSubscriptionModel.fromJson(maps[i]),
    );
  }

  // 启用订阅
  Future<void> enableSubscription(ContactSubscriptionModel subscription) async {
    // 更新订阅
    await database.update('contact_subscriptions', {'enabled': true},
        where: 'id = ?', whereArgs: [subscription.id]);

    // 更新订阅列表
    subscription.enabled = true;
  }

  // 禁用订阅
  Future<void> disableSubscription(ContactSubscriptionModel subscription) async {
    // 更新订阅
    await database.update('contact_subscriptions', {'enabled': false},
        where: 'id = ?', whereArgs: [subscription.id]);

    // 更新订阅列表
    subscription.enabled = false;
  }




// 更新订阅
  Future<void> updateSubscription(ContactSubscriptionModel subscription) async {
    await database.update('contact_subscriptions', subscription.toJson(),
        where: 'id = ?', whereArgs: [subscription.id]);
  }

//自动更新
Future<void> autoUpdateSubscription(ContactSubscriptionModel subscription) async {
  if (!subscription.enabled) {
    return;
  }

  // 检查是否需要更新
  const objectName = 'ContactSubscriptionModel';
  if (!(await subscription.shouldUpdate(objectName))) {
    return;
  }

  // 记录本次更新时间
  subscription.lastUpdated = DateTime.now();
}

//手动更新
Future<void> manualUpdateSubscription(ContactSubscriptionModel subscription) async {
  if (!subscription.enabled) {
    return;
  }

  // 记录本次更新时间
  subscription.lastUpdated = DateTime.now();
}

  // --- 解析函数 ---

List<Map<String, dynamic>> _parseCsvData(String data) {
  final csvList = const CsvToListConverter().convert(data);
  return csvList.skip(1).map((parts) {
    return {
      'id': parts.isNotEmpty ? int.tryParse(parts[0].toString()) : null,
      'name': parts.length > 1 ? parts[1].toString() : null,
      'url': parts.length > 2 ? parts[2].toString() : null,
      'enabled': parts.length > 3 && parts[3].toString().toLowerCase() == 'true' ? 1 : 0,

      'lastUpdated': parts.length > 6 ? parts[6].toString() : DateTime.now().toIso8601String(), // 如果没有提供 lastUpdated，则使用当前时间并转换为 ISO 8601 格式的字符串
      'isAutoUpdate': parts.length > 7 && parts[7].toString().toLowerCase() == 'true' ? 1 : 0,
    };
  }).toList();
}

List<Map<String, dynamic>> _parseJsonData(String data) {
  final jsonData = jsonDecode(data);
  if (jsonData is List) {
    return jsonData.map((subscription) {
      return {
        'id': subscription.containsKey('id') ? subscription['id'] : null,
        'name': subscription.containsKey('name') ? subscription['name'] : null,
        'url': subscription.containsKey('url') ? subscription['url'] : null,
        'enabled': subscription.containsKey('enabled') && subscription['enabled'] ? 1 : 0,

        'lastUpdated': subscription.containsKey('lastUpdated') ? subscription['lastUpdated'] : DateTime.now().toIso8601String(), // 如果没有提供 lastUpdated，则使用当前时间并转换为 ISO 8601 格式的字符串
        'isAutoUpdate': subscription.containsKey('isAutoUpdate') && subscription['isAutoUpdate'] ? 1 : 0,
      };
    }).toList();
  } else {
    throw const FormatException('Unexpected JSON format');
  }
}

// ... (其他代码不变)

// --- 解析函数 ---

// ... (_parseCsvData 和 _parseJsonData 函数不变)

List<Map<String, dynamic>> _parseTxtData(String data) {
  final lines = data.split('\n');
  return lines.map((line) {
    final parts = line.split(',');
    return {
      'id': parts.isNotEmpty ? int.tryParse(parts[0].toString()) : null,
      'name': parts.length > 1 ? parts[1].toString() : null,
      'url': parts.length > 2 ? parts[2].toString() : null,
      'enabled': parts.length > 3 && parts[3].toString().toLowerCase() == 'true' ? 1 : 0,

      'lastUpdated': parts.length > 6 ? parts[6].toString() : DateTime.now().toIso8601String(), 
      'isAutoUpdate': parts.length > 7 && parts[7].toString().toLowerCase() == 'true' ? 1 : 0,
    };
  }).toList();
}

List<Map<String, dynamic>> _parseYamlData(String data) {
  final yamlData = loadYaml(data) as List;
  return yamlData.map((subscription) {
    return {
      'id': subscription.containsKey('id') ? subscription['id'] : null,
      'name': subscription.containsKey('name') ? subscription['name'] : null,
      'url': subscription.containsKey('url') ? subscription['url'] : null,
      'enabled': subscription.containsKey('enabled') && subscription['enabled'] ? 1 : 0,
      'lastUpdated': subscription.containsKey('lastUpdated') ? subscription['lastUpdated'] : DateTime.now().toIso8601String(), 
      'isAutoUpdate': subscription.containsKey('isAutoUpdate') && subscription['isAutoUpdate'] ? 1 : 0,
    };
  }).toList();
}

// ... (其他代码不变)

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

  Future<void> importSubscriptionsFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importSubscriptionsFromLocalFile(String filePath) async {
    await _importFromLocal(filePath);
  }

  // --- 私有导入函数 ---

  Future<void> _importFromUrl(String url) async {
    final subscriptions = await parseFromUrl(url);
    await _addAllWithUrl(subscriptions);
  }

  Future<void> _importFromLocal(String filePath) async {
    final subscriptions = await parseFromLocal(filePath);
    await _addAllWithUrl(subscriptions);
  }

  // --- 批量添加或更新函数 ---

  Future<void> _addAllWithUrl(
      List<Map<String, dynamic>> subscriptions) async {
    final batch = database.batch();
    for (final subscription in subscriptions) {


      // 检查数据库中是否已存在相同的 URL
      final exists = await database.query(
        'subscription_models',
        where: 'url = ?',
        whereArgs: [subscription['url']],
      ).then((results) => results.isNotEmpty);

      if (exists) {
        batch.update(
          'subscription_models',
          subscription,
          where: 'url = ?',
          whereArgs: [subscription['url']],
        );
      } else {
        batch.insert('subscription_models', subscription);
      }
    }
    await batch.commit();
  }

  // --- 导出函数 ---

  Future<void> exportSubscriptionsToCsv(
      List<ContactSubscriptionModel> subscriptions, String directoryPath) async {
    await _exportToCsv(subscriptions, directoryPath);
  }

  Future<void> exportSubscriptionsToJson(
      List<ContactSubscriptionModel> subscriptions, String directoryPath) async {
    await _exportToJson(subscriptions, directoryPath);
  }

  // --- 数据生成函数 ---

  String _generateCsvData(List<ContactSubscriptionModel> subscriptions) {
    return const ListToCsvConverter().convert(subscriptions
        .map((subscription) => [
              subscription.id,
              subscription.name,
              subscription.url,
              subscription.enabled ? '1' : '0',
              subscription.lastUpdated.toIso8601String(),
              subscription.isAutoUpdate ? '1' : '0'
            ])
        .toList());
  }

  String _generateJsonData(List<ContactSubscriptionModel> subscriptions) {
    final listofMaps = subscriptions.map((subscription) => subscription.toJson()).toList();
    return jsonEncode(listofMaps);
  }

  // --- 私有导出函数 ---

  Future<void> _exportToCsv(
      List<ContactSubscriptionModel> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/subscriptions_$dateStr.csv';

    final csvData = _generateCsvData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  Future<void> _exportToJson(
      List<ContactSubscriptionModel> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/subscriptions_$dateStr.json';

    final jsonData = _generateJsonData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }





  // 结束





}