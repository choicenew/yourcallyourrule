// 导入必要的库
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yaml/yaml.dart';

import '../utils/update_interval.dart';

import 'sms_blacklist_whitelist_service.dart';
import 'sms_text_service.dart';

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

Future<void> createDatabase(Database db, int version) async {
  await db.execute('''
    CREATE TABLE IF NOT EXISTS sms_subscribe(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            url TEXT,
            enabled INTEGER,
            isWhitelist INTEGER,
            isBlacklist INTEGER,
            isNumberType INTEGER,  -- 使用整数来表示是否为 number 类型
            lastUpdated TEXT,
            isAutoUpdate INTEGER
    )
  ''');
}

//  SmsSubscriptionModel 类

class SmsSubscriptionModel {
  int? id; // 订阅 ID
  String name; // 订阅名称
  String url; // 订阅地址
  bool enabled; // 是否启用
  bool isWhitelist; // 是否白名单
  bool isBlacklist; // 是否黑名单
  bool isNumberType; // 是否为 number 类型
  DateTime lastUpdated; // 最后更新时间
  bool isAutoUpdate; // 是否自动更新

  SmsSubscriptionModel({
    this.id,
    required this.name,
    required this.url,
    this.enabled = true,
    this.isWhitelist = false,
    this.isBlacklist = false,
    this.isNumberType = true, // 默认为 true，表示 number 类型
    DateTime? lastUpdated,
    this.isAutoUpdate = false,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  // 工厂方法，从Map构建订阅模型
  factory SmsSubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SmsSubscriptionModel(
      name: map['name'],
      url: map['url'],
      enabled: map['enabled'] == 1, // 整数转换为布尔值
      isWhitelist: map['isWhitelist'] == 1, // 整数转换为布尔值
      isBlacklist: map['isBlacklist'] == 1, // 整数转换为布尔值
      isNumberType: map['isNumberType'] == 1,
      lastUpdated: DateTime.tryParse(map['lastUpdated']) ?? DateTime.now(),
      isAutoUpdate: map['isAutoUpdate'] == 1, // 整数转换为布尔值
    );
  }

  // 将 SmsSubscriptionModel 对象转换为 JSON 格式
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'enabled': enabled ? 1 : 0, // 布尔值转换为整数
        'isWhitelist': isWhitelist ? 1 : 0, // 布尔值转换为整数
        'isBlacklist': isBlacklist ? 1 : 0, // 布尔值转换为整数
        'isNumberType': isNumberType ? 1 : 0,
        'lastUpdated': lastUpdated.toIso8601String(),
        'isAutoUpdate': isAutoUpdate ? 1 : 0, // 布尔值转换为整数
      };

  // 从 JSON 格式创建 SmsSubscriptionModel 对象
  factory SmsSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SmsSubscriptionModel(
        id: json['id'] as int?,
        name: json['name'] as String,
        url: json['url'] as String,
        enabled: (json['enabled'] as int) == 1, // 整数转换为布尔值
        isWhitelist: (json['isWhitelist'] as int) == 1, // 整数转换为布尔值
        isBlacklist: (json['isBlacklist'] as int) == 1, // 整数转换为布尔值
        isNumberType: (json['isNumberType'] as int) == 1, // 整数转换为布尔值
        lastUpdated: json['lastUpdated'] != null
            ? DateTime.tryParse(json['lastUpdated'] as String) ?? DateTime.now()
            : DateTime.now(),
        isAutoUpdate: (json['isAutoUpdate'] as int) == 1, // 整数转换为布尔值
      );
}

// 数据库服务类
class SmsSubscribeService {
  // 数据库实例
  final Database database;
  SmsSubscribeService(this.database);

  Future<void> subscribeToUrl(String url) async {
    await database.insert('sms_subscribe',
        {'url': url, 'last_updated': DateTime.now().toIso8601String()},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<String>> fetchSubscribedUrls() async {
    final List<Map<String, dynamic>> maps =
        await database.query('sms_subscribe');
    return List.generate(maps.length, (i) => maps[i]['url'] as String);
  }

// 获取所有订阅
  Future<List<SmsSubscriptionModel>> getAllSubscriptions(
      {String? orderBy, bool ascending = true}) async {
    final List<Map<String, dynamic>> results = await database.query(
      'sms_subscribe',
      orderBy:
          orderBy != null ? '$orderBy ${ascending ? 'ASC' : 'DESC'}' : null,
    );
    return results.map((row) => SmsSubscriptionModel.fromJson(row)).toList();
  }

  // edit订阅
  Future<void> editSubscription(SmsSubscriptionModel subscription) async {
    // 更新订阅
    await database.update(
      'sms_subscribe',
      subscription.toJson(),
      where: 'id = ?',
      whereArgs: [subscription.id],
    );
  }

  // 删除订阅
  Future<void> deleteSubscription(SmsSubscriptionModel subscription) async {
    await database
        .delete('sms_subscribe', where: 'id = ?', whereArgs: [subscription.id]);
  }

  // 插入订阅
  Future<void> insertSubscription(SmsSubscriptionModel subscription) async {
    await database.insert('sms_subscribe', subscription.toJson());
  }

  // 根据 url 查询订阅
  Future<SmsSubscriptionModel?> getSubscriptionByUrl(String url) async {
    final maps = await database
        .query('sms_subscribe', where: 'url = ?', whereArgs: [url]);
    return maps.isNotEmpty ? SmsSubscriptionModel.fromJson(maps.first) : null;
  }

  // 根据 ID 查询订阅
  Future<SmsSubscriptionModel?> getSubscriptionById(int id) async {
    final maps =
        await database.query('sms_subscribe', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty ? SmsSubscriptionModel.fromJson(maps.first) : null;
  }

  // 检查订阅是否存在
  Future<bool> urlExists(String url) async {
    final maps = await database
        .query('sms_subscribe', where: 'url = ?', whereArgs: [url]);
    return maps.isNotEmpty;
  }

  // 添加订阅
  Future<void> addSubscription(SmsSubscriptionModel subscription) async {
    // 将订阅插入数据库
    //await database.insert('sms_subscribe', subscription.toJson());
    await database.insert('sms_subscribe', subscription.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // 根据是否启用查询订阅
  Future<List<SmsSubscriptionModel>> getSubscriptionsByEnabled(
      bool enabled) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'sms_subscribe',
      where: 'enabled = ?',
      whereArgs: [enabled ? 1 : 0], // Convert bool to integer for SQLite
    );
    return List.generate(
      maps.length,
      (i) => SmsSubscriptionModel.fromJson(maps[i]),
    );
  }

  // 启用订阅
  Future<void> enableSubscription(SmsSubscriptionModel subscription) async {
    // 更新订阅
    await database.update('sms_subscribe', {'enabled': true},
        where: 'id = ?', whereArgs: [subscription.id]);

    // 更新订阅列表
    subscription.enabled = true;
  }

  // 禁用订阅
  Future<void> disableSubscription(SmsSubscriptionModel subscription) async {
    // 更新订阅
    await database.update('sms_subscribe', {'enabled': false},
        where: 'id = ?', whereArgs: [subscription.id]);

    // 更新订阅列表
    subscription.enabled = false;
  }

// 添加订阅并标记为白名单
  Future<void> addWhitelistSubscription(
      SmsSubscriptionModel subscription) async {
    subscription.isWhitelist = true; // 标记为白名单
    // await database.insert('sms_subscribe', subscription.toJson());

    await database.insert('sms_subscribe', subscription.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

// 添加订阅并标记为黑名单
  Future<void> addBlacklistSubscription(
      SmsSubscriptionModel subscription) async {
    subscription.isBlacklist = true; // 标记为黑名单
    //await database.insert('sms_subscribe', subscription.toJson());

    await database.insert('sms_subscribe', subscription.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

// 删除白名单订阅
  Future<void> removeWhitelistSubscription(
      SmsSubscriptionModel subscription) async {
    subscription.isWhitelist = false; // 将订阅标记为非白名单
    await database.update('sms_subscribe', subscription.toJson(),
        where: 'id = ?', whereArgs: [subscription.id]);
  }

// 删除黑名单订阅
  Future<void> removeBlacklistSubscription(
      SmsSubscriptionModel subscription) async {
    subscription.isBlacklist = false; // 将订阅标记为非黑名单
    await database.update('sms_subscribe', subscription.toJson(),
        where: 'id = ?', whereArgs: [subscription.id]);
  }

  // 查询白名单订阅
  Future<List<SmsSubscriptionModel>> getWhitelistSubscriptions() async {
    final List<Map<String, dynamic>> maps = await database
        .query('sms_subscribe', where: 'is_whitelist = ?', whereArgs: [true]);
    return List.generate(
        maps.length, (i) => SmsSubscriptionModel.fromJson(maps[i]));
  }

  // 查询黑名单订阅
  Future<List<SmsSubscriptionModel>> getBlacklistSubscriptions() async {
    final List<Map<String, dynamic>> maps = await database
        .query('sms_subscribe', where: 'is_blacklist = ?', whereArgs: [true]);
    return List.generate(
        maps.length, (i) => SmsSubscriptionModel.fromJson(maps[i]));
  }

// 检查订阅是否在白名单中
  Future<bool> isWhitelisted(SmsSubscriptionModel subscription) async {
    // 查询订阅是否在白名单中
    final List<Map<String, dynamic>> maps = await database.query(
        'sms_subscribe',
        where: 'url = ? AND isWhitelist = ?',
        whereArgs: [subscription.url, true]);
    return maps.isNotEmpty;
  }

// 检查订阅是否在黑名单中
  Future<bool> isBlacklisted(SmsSubscriptionModel subscription) async {
    // 查询订阅是否在黑名单中
    final List<Map<String, dynamic>> maps = await database.query(
        'sms_subscribe',
        where: 'url = ? AND isBlacklist = ?',
        whereArgs: [subscription.url, true]);
    return maps.isNotEmpty;
  }

//自动更新
  Future<void> autoUpdateSubscription(SmsSubscriptionModel subscription) async {
    if (!subscription.enabled) {
      return;
    }

    // 检查是否需要更新
    final objectName = 'SmsSubscriptionModel';
    if (!(await subscription.shouldUpdate(objectName))) {
      return;
    }

    // 根据订阅类型和内容类型更新
    if (subscription.isWhitelist) {
      if (subscription.isNumberType) {
        final smsWhitelistService = SmsWhitelistService(database);
        await smsWhitelistService.importNumbersFromUrl(subscription.url);
      } else {
        final smsTextWhitelistService = SmsTextWhitelistService(database);
        await smsTextWhitelistService.importKeywordsFromUrl(subscription.url);
      }
    } else if (subscription.isBlacklist) {
      if (subscription.isNumberType) {
        final smsBlacklistService = SmsBlacklistService(database);
        await smsBlacklistService.importNumbersFromUrl(subscription.url);
      } else {
        final smsTextBlacklistService = SmsTextBlacklistService(database);
        await smsTextBlacklistService.importKeywordsFromUrl(subscription.url);
      }
    }

    // 记录本次更新时间
    subscription.lastUpdated = DateTime.now();
  }

//手动更新
  Future<void> manualUpdateSubscription(
      SmsSubscriptionModel subscription) async {
    if (!subscription.enabled) {
      return;
    }

    // 检查是否需要更新
    final objectName = 'SmsSubscriptionModel';
    if (!(await subscription.shouldUpdate(objectName))) {
      return;
    }

    // 根据订阅类型和内容类型更新
    if (subscription.isWhitelist) {
      if (subscription.isNumberType) {
        final smsWhitelistService = SmsWhitelistService(database);
        await smsWhitelistService.importNumbersFromUrl(subscription.url);
      } else {
        final smsTextWhitelistService = SmsTextWhitelistService(database);
        await smsTextWhitelistService.importKeywordsFromUrl(subscription.url);
      }
    } else if (subscription.isBlacklist) {
      if (subscription.isNumberType) {
        final smsBlacklistService = SmsBlacklistService(database);
        await smsBlacklistService.importNumbersFromUrl(subscription.url);
      } else {
        final smsTextBlacklistService = SmsTextBlacklistService(database);
        await smsTextBlacklistService.importKeywordsFromUrl(subscription.url);
      }
    }

    // 记录本次更新时间
    subscription.lastUpdated = DateTime.now();
  }

// --- Refactored Data Generation Functions ---

  // --- 解析函数 ---

  List<Map<String, dynamic>> _parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
    return csvList.skip(1).map((parts) {
      return {
        'id': parts.isNotEmpty ? int.tryParse(parts[0].toString()) : null,
        'name': parts.length > 1 ? parts[1].toString() : null,
        'url': parts.length > 2 ? parts[2].toString() : null,
        'enabled':
            parts.length > 3 && parts[3].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'isWhitelist':
            parts.length > 4 && parts[4].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'isBlacklist':
            parts.length > 5 && parts[5].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'isNumberType':
            parts.length > 6 && parts[6].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'lastUpdated': parts.length > 7
            ? parts[7].toString()
            : DateTime.now()
                .toIso8601String(), // 如果没有提供 lastUpdated，则使用当前时间并转换为 ISO 8601 格式的字符串
        'isAutoUpdate':
            parts.length > 8 && parts[8].toString().toLowerCase() == 'true'
                ? 1
                : 0,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseJsonData(String data) {
    final jsonData = jsonDecode(data);
    if (jsonData is List) {
      return jsonData.map((subscription) {
        return {
          'id': subscription.containsKey('id') ? subscription['id'] : null,
          'name':
              subscription.containsKey('name') ? subscription['name'] : null,
          'url': subscription.containsKey('url') ? subscription['url'] : null,
          'enabled':
              subscription.containsKey('enabled') && subscription['enabled']
                  ? 1
                  : 0,
          'isWhitelist': subscription.containsKey('isWhitelist') &&
                  subscription['isWhitelist']
              ? 1
              : 0,
          'isBlacklist': subscription.containsKey('isBlacklist') &&
                  subscription['isBlacklist']
              ? 1
              : 0,
          'isNumberType': subscription.containsKey('isNumberType') &&
                  subscription['isNumberType']
              ? 1
              : 0,
          'lastUpdated': subscription.containsKey('lastUpdated')
              ? subscription['lastUpdated']
              : DateTime.now()
                  .toIso8601String(), // 如果没有提供 lastUpdated，则使用当前时间并转换为 ISO 8601 格式的字符串
          'isAutoUpdate': subscription.containsKey('isAutoUpdate') &&
                  subscription['isAutoUpdate']
              ? 1
              : 0,
        };
      }).toList();
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }

// ... (_parseCsvData 和 _parseJsonData 函数不变)

  List<Map<String, dynamic>> _parseTxtData(String data) {
    final lines = data.split('\n');
    return lines.map((line) {
      final parts = line.split(',');
      return {
        'id': parts.isNotEmpty ? int.tryParse(parts[0].toString()) : null,
        'name': parts.length > 1 ? parts[1].toString() : null,
        'url': parts.length > 2 ? parts[2].toString() : null,
        'enabled':
            parts.length > 3 && parts[3].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'isWhitelist':
            parts.length > 4 && parts[4].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'isBlacklist':
            parts.length > 5 && parts[5].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'isNumberType':
            parts.length > 6 && parts[6].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'lastUpdated': parts.length > 7
            ? parts[7].toString()
            : DateTime.now().toIso8601String(),
        'isAutoUpdate':
            parts.length > 8 && parts[8].toString().toLowerCase() == 'true'
                ? 1
                : 0,
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
        'enabled':
            subscription.containsKey('enabled') && subscription['enabled']
                ? 1
                : 0,
        'isWhitelist': subscription.containsKey('isWhitelist') &&
                subscription['isWhitelist']
            ? 1
            : 0,
        'isBlacklist': subscription.containsKey('isBlacklist') &&
                subscription['isBlacklist']
            ? 1
            : 0,
        'isNumberType': subscription.containsKey('isNumberType') &&
                subscription['isNumberType']
            ? 1
            : 0,
        'lastUpdated': subscription.containsKey('lastUpdated')
            ? subscription['lastUpdated']
            : DateTime.now().toIso8601String(),
        'isAutoUpdate': subscription.containsKey('isAutoUpdate') &&
                subscription['isAutoUpdate']
            ? 1
            : 0,
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

  Future<void> _addAllWithUrl(List<Map<String, dynamic>> subscriptions) async {
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
      List<SmsSubscriptionModel> subscriptions, String directoryPath) async {
    await _exportToCsv(subscriptions, directoryPath);
  }

  Future<void> exportSubscriptionsToJson(
      List<SmsSubscriptionModel> subscriptions, String directoryPath) async {
    await _exportToJson(subscriptions, directoryPath);
  }

  // --- 数据生成函数 ---

  String _generateCsvData(List<SmsSubscriptionModel> subscriptions) {
    return const ListToCsvConverter().convert(subscriptions
        .map((subscription) => [
              subscription.id,
              subscription.name,
              subscription.url,
              subscription.enabled ? '1' : '0',
              subscription.isWhitelist ? '1' : '0',
              subscription.isBlacklist ? '1' : '0',
              subscription.lastUpdated.toIso8601String(),
              subscription.isAutoUpdate ? '1' : '0'
            ])
        .toList());
  }

  String _generateJsonData(List<SmsSubscriptionModel> subscriptions) {
    final listofMaps =
        subscriptions.map((subscription) => subscription.toJson()).toList();
    return jsonEncode(listofMaps);
  }

  // --- 私有导出函数 ---

  Future<void> _exportToCsv(
      List<SmsSubscriptionModel> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/subscriptions_$dateStr.csv';

    final csvData = _generateCsvData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  Future<void> _exportToJson(
      List<SmsSubscriptionModel> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/subscriptions_$dateStr.json';

    final jsonData = _generateJsonData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }

  // 结束
}
