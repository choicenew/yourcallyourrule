import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

import '../utils/predefined_labels.dart';

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
      CREATE TABLE IF NOT EXISTS sms_blacklisted (
        phoneNumber TEXT UNIQUE,

        label TEXT,

        name TEXT,
                avatar TEXT,
        isSubscribed INTEGER,

        url TEXT
      )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS sms_whitelisted (
        phoneNumber TEXT UNIQUE,

        label TEXT,

        name TEXT,
                avatar TEXT,
        isSubscribed INTEGER,

        url TEXT
      )
    ''');
  }
}

// 抽象类 PhonelistEntry
abstract class PhonelistEntry {
  String phoneNumber;

  String? label;

  String? name;
  String? avatar;
  bool isSubscribed;

  String? url;

  PhonelistEntry({
    required this.phoneNumber,

    this.label,

    this.name,
    this.avatar,    
    this.isSubscribed = false,
    this.url,
  });

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,

        'label': label,

        'name': name,
        'avatar': avatar,
        'isSubscribed': isSubscribed,
        'url': url,
      };

  factory PhonelistEntry.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class SmsBlacklistEntry extends PhonelistEntry {
  SmsBlacklistEntry({
    required super.phoneNumber,
    required super.label,
    super.name,
    super.avatar,
    super.isSubscribed,

    super.url,
  });

  factory SmsBlacklistEntry.fromJson(Map<String, dynamic> json) =>
      SmsBlacklistEntry(
        avatar: json['avatar'],
        label: json['label'],
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        isSubscribed: json['isSubscribed'] ?? false,
        url: json['url'],
      );
}

class SmsWhitelistEntry extends PhonelistEntry {
  SmsWhitelistEntry({
    super.avatar,
    super.label,
    required super.phoneNumber,
    super.name,
    super.isSubscribed,
    super.url,
  });

  factory SmsWhitelistEntry.fromJson(Map<String, dynamic> json) =>
      SmsWhitelistEntry(
        avatar: json['avatar'],
        label: json['label'],
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        isSubscribed: json['isSubscribed'] ?? false,
        url: json['url'],
      );
}

// 抽象类 _PhonelistService，注意前面加了下划线，表示私有
abstract class _PhonelistService<T extends PhonelistEntry> {
  final Database database;
  final String tableName;

  _PhonelistService(this.database, this.tableName);

  // 添加条目
  Future<void> add(T entry) async {
    final exists = await database.query(tableName,
        where: 'phoneNumber = ?',
        whereArgs: [entry.phoneNumber]).then((results) => results.isNotEmpty);
    if (!exists) {
      await database.insert(tableName, entry.toJson());
    }
  }

  // 添加或更新条目
  Future<void> addOrUpdate(T entry) async {
    final exists = await database.query(tableName,
        where: 'phoneNumber = ?',
        whereArgs: [entry.phoneNumber]).then((results) => results.isNotEmpty);
    if (exists) {
      await database.update(tableName, entry.toJson(),
          where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
    } else {
      await database.insert(tableName, entry.toJson());
    }
  }

  // 批量添加条目
  Future<void> addAll(List<T> entries) async {
    final batch = database.batch();
    for (final entry in entries) {
      batch.insert(tableName, entry.toJson());
    }
    await batch.commit();
  }

  // 批量添加或更新条目
  Future<void> addAllOrUpdate(List<T> entries) async {
    final batch = database.batch();
    for (final entry in entries) {
      final exists = await database.query(tableName,
          where: 'phoneNumber = ?',
          whereArgs: [entry.phoneNumber]).then((results) => results.isNotEmpty);
      if (exists) {
        batch.update(tableName, entry.toJson(),
            where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
      } else {
        batch.insert(tableName, entry.toJson());
      }
    }
    await batch.commit();
  }

  // 获取所有标签
  Future<List<String>> getAllLabels() async {
    final labels = await database.query(tableName).then(
        (results) => results.map((row) => row['label'] as String).toList());
    return labels.toSet().toList();
  }

  // 插入预定义标签
  Future<void> insertPredefinedLabelsIfNotExists(Database database) async {
    final existingLabels = await this.database.query(tableName, columns: [
      'label'
    ]).then((results) => results.map((row) => row['label'] as String).toSet());
    final batch = database.batch();
    for (final labelMap in predefinedLabels) {
      final label = labelMap['label'] as String;
      if (!existingLabels.contains(label)) {
        batch.insert(tableName, {
          'label': label,
          'phoneNumber': '',
          'isSubscribed': 0,
        });
      }
    }
    await batch.commit();
  }

  // 根据号码查询标签
  /*
  Future<String?> getLabelByPhoneNumber(T entry) async {
    final List<Map<String, dynamic>> results = await database.query(tableName,
        where: 'phoneNumber IN (?, ?)', whereArgs: [entry.phoneNumber]);
    if (results.isNotEmpty) {
      return results.first['label'];
    } else {
      return null;
    }
  }
*/

  Future<String?> getLabelByPhoneNumber(String phoneNumber) async {
    // 查询数据库中的标签，只查询 phoneNumber
    final Map<String, dynamic>? result = await database.query(
      tableName,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    ).then((results) => results.isNotEmpty ? results.first : null);

    // 如果找到匹配的标签，则返回该标签
    if (result != null) {
      return result['label'] as String?;
    } else {
      return null;
    }
  }


  // 修改号码的姓名和标签
  Future<void> editEntry(T entry) async {
    await database.update(tableName, entry.toJson(),
        where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
  }

  // 根据URL删除号码
  Future<void> deleteByUrl(String url) async {
    await database.delete(tableName, where: 'url = ?', whereArgs: [url]);
  }

  // 移除条目
  Future<void> remove(T entry) async {
    database.delete(tableName,
        where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
  }

  // 检查号码是否存在
  Future<bool> contains(String phoneNumber) {
    return database.query(tableName,
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber]).then((results) => results.isNotEmpty);
  }

  // 获取已订阅的条目
  Future<List<T>> getSubscribedEntries() {
    return database.query(tableName, where: 'isSubscribed = 1').then(
        (results) =>
            results.map((row) => PhonelistEntry.fromJson(row) as T).toList());
  }

  // 获取所有条目
  Future<List<T>> getEntries() {
    return database.query(tableName).then((results) =>
        results.map((row) => PhonelistEntry.fromJson(row) as T).toList());
  }

  // 根据号码获取条目
  Future<T?> getEntryByPhoneNumber(String phoneNumber) {
    return database.query(tableName, where: 'phoneNumber = ?', whereArgs: [
      phoneNumber
    ]).then((results) => results.isNotEmpty
        ? PhonelistEntry.fromJson(results.first) as T
        : null);
  }

  // 导出为 CSV 格式
  Future<void> exportToCsv(List<T> entries, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final typeName = tableName; // 获取类型名称
    final filePath = '$directoryPath/${typeName}_entries_$dateStr.csv';
    final csvData = ListToCsvConverter().convert(entries
        .map((entry) => [
              entry.avatar ?? '',
              entry.label ?? '',
              entry.phoneNumber,
              entry.name ?? '',
              entry.isSubscribed,
              entry.url ?? ''
            ])
        .toList());
    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  // 导出为 JSON 格式
  Future<void> exportToJson(List<T> entries, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final typeName = tableName; // 获取类型名称
    final filePath = '$directoryPath/${typeName}_entries_$dateStr.json';
    final jsonData = {
      'entries': entries.map((entry) => entry.toJson()).toList(),
    };
    final file = File(filePath);
    await file.writeAsString(jsonEncode(jsonData));
  }

  // 导出所有数据为 CSV 格式
  Future<String> exportAllToCsv() async {
    final entries = await getEntries();
    final csvList = entries
        .map((entry) => [
              entry.avatar ?? '',
              entry.label ?? '',
              entry.phoneNumber,
              entry.name ?? '',
              entry.isSubscribed,
              entry.url ?? ''
            ])
        .toList();
    final csvString = const ListToCsvConverter().convert(csvList);
    return csvString;
  }

  // 导出所有数据为 JSON 格式
  Future<String> exportAllToJson() async {
    final entries = await getEntries();
    final jsonData = {
      'entries': entries
          .map((entry) => {
                'avatar': entry.avatar ?? '',
                'label': entry.label ?? '',
                'phoneNumber': entry.phoneNumber,
                'name': entry.name ?? '',
                'isSubscribed': entry.isSubscribed,
                'url': entry.url ?? '',
              })
          .toList(),
    };
    return jsonEncode(jsonData);
  }

// 解析数据
List<Map<String, dynamic>> parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
    return csvList.map((parts) {
      return {
        'avatar': parts[0].isNotEmpty ? parts[0] : null,
        'label': parts[1],
        'phoneNumber': parts[2],
        'name': parts[3].isNotEmpty ? parts[3] : null,
        'isSubscribed': parts[4].toLowerCase() == 'true',

        'url': parts[5].isNotEmpty ? parts[5] : null,
      };
    }).toList();
  }

List<Map<String, dynamic>> parseJsonData(String data) {
    final jsonData = jsonDecode(data) as List<dynamic>;
    return jsonData.map((entry) {
      return {
        'avatar': entry['avatar'],
        'label': entry['label'],
        'phoneNumber': entry['phoneNumber'],
        'name': entry['name'],
        'isSubscribed': entry['isSubscribed'] ?? false,

        'url': entry['url'],
      };
    }).toList();
  }

List<Map<String, dynamic>> parseTxtData(String data) {
    final lines = data.split('\n');
    return lines.map((line) {
      final parts = line.split(',');
      return {
        'avatar': parts[0].isNotEmpty ? parts[0] : null,
        'label': parts[1],
        'phoneNumber': parts[2],
        'name': parts[3].isNotEmpty ? parts[3] : null,
        'isSubscribed': parts[4].toLowerCase() == 'true',

        'url': parts[5].isNotEmpty ? parts[5] : null,
      };
    }).toList();
  }

List<Map<String, dynamic>> parseYamlData(String data) {
    final yamlData = loadYaml(data) as List<dynamic>;
    return yamlData.map((entry) {
      return {
        'avatar': entry['avatar'],
        'label': entry['label'],
        'phoneNumber': entry['phoneNumber'],
        'name': entry['name'],
        'isSubscribed': entry['isSubscribed'] ?? false,

        'url': entry['url'],
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
  // 新增一个私有方法来处理解析逻辑
  List<Map<String, dynamic>> _parseData(String data, String source) {
    if (source.endsWith('.csv')) return parseCsvData(data);
    if (source.endsWith('.json')) return parseJsonData(data);
    if (source.endsWith('.txt')) return parseTxtData(data);
    if (source.endsWith('.yaml')) return parseYamlData(data);
    throw UnsupportedError('Unsupported file format');
  }

  // 这个方法应该是公共的，因为它被子类调用
  Future<List<Map<String, dynamic>>> _parseFromUrl(String url) async {
    final data = await _fetchData(url);
    return _parseData(data, url);
  }

  // 这个方法应该是公共的，因为它被子类调用
  Future<List<Map<String, dynamic>>> _parseFromLocal(String filePath) async {
    final data = await File(filePath).readAsString();
    return _parseData(data, filePath);
  }

Future<List<Map<String, dynamic>>> parseFromUrl(String url) async {
  final data = await _fetchData(url);
  if (url.endsWith('.csv')) {
    return parseCsvData(data);
  } else if (url.endsWith('.json')) {
    return parseJsonData(data);
  } else if (url.endsWith('.txt')) {
    return parseTxtData(data);
  } else if (url.endsWith('.yaml')) {
    return parseYamlData(data);
  } else {
    throw UnsupportedError('Unsupported file format');
  }
}

Future<List<Map<String, dynamic>>> parseFromLocal(String filePath) async {
  final data = await File(filePath).readAsString();
  if (filePath.endsWith('.csv')) {
    return parseCsvData(data);
  } else if (filePath.endsWith('.json')) {
    return parseJsonData(data);
  } else if (filePath.endsWith('.txt')) {
    return parseTxtData(data);
  } else if (filePath.endsWith('.yaml')) {
    return parseYamlData(data);
  } else {
    throw UnsupportedError('Unsupported file format');
  }
}

  Future<void> _addAllWithUrl(
      String tableName, List<Map<String, dynamic>> entries, String? url) async {
    final batch = database.batch();
    for (final entry in entries) {
      entry['isSubscribed'] = true; // 设置为已订阅

      // 只有当 entry 中缺少 url 字段时才添加 url
      if (url != null && !entry.containsKey('url')) {
        entry['url'] = url;
      }

      batch.insert(tableName, entry);
    }
    await batch.commit();
  }
  // Generic import functions
  Future<void> _importFromUrl(String url) async {
    final entries = await _parseFromUrl(url);
    await _addAllWithUrl(tableName, entries, url); // 传递 tableName 参数
  }

  Future<void> _importFromLocal(String filePath) async {
    final entries = await _parseFromLocal(filePath);
    await _addAllWithUrl(tableName, entries, null); // 传递 tableName 参数
  }
  

}

// 黑名单服务类
class SmsBlacklistService extends _PhonelistService<SmsBlacklistEntry> {
  SmsBlacklistService(Database database) : super(database, 'sms_blacklisted');

  // 检查电话号码是否在黑名单中
  Future<bool> isBlacklisted(String phoneNumber) {
    return contains(phoneNumber);
  }

// 导入黑名单号码
Future<void> importSmsBlacklistNumbersFromUrl(String url) async {
    await _importFromUrl(url);
}

Future<void> importSmsBlacklistNumbersFromLocal(String filePath) async {
    await _importFromLocal(filePath);
}

  // Specific export functions calling the generic functions
  Future<void> exportBlacklistToCsv(
      List<SmsBlacklistEntry> entries, String directoryPath) async {
    await exportToCsv(entries, directoryPath);
  }

  Future<void> exportBlacklistToJson(
      List<SmsBlacklistEntry> entries, String directoryPath) async {
    await exportToJson(entries, directoryPath);
  }

  // Export All functions using the separate data generation functions
  Future<String> exportAllBlacklistToCsv() async {

    return exportAllToCsv();
  }

  Future<String> exportAllBlacklistToJson() async {

    return exportAllToJson();
  }

}

// 白名单服务类
class SmsWhitelistService extends _PhonelistService<SmsWhitelistEntry> {
  SmsWhitelistService(Database database) : super(database, 'sms_whitelisted');

  // 检查电话号码是否在白名单中
  Future<bool> isWhitelisted(String phoneNumber) {
    return contains(phoneNumber);
  }
// 导入白名单号码
Future<void> importSmsWhitelistNumbersFromUrl(String url) async {
    await _importFromUrl(url);
}

Future<void> importSmsWhitelistNumbersFromLocal(String filePath) async {
    await _importFromLocal(filePath);
}

  // Specific export functions calling the generic functions
  Future<void> exportWhitelistToCsv(
      List<SmsWhitelistEntry> entries, String directoryPath) async {
    await exportToCsv(entries, directoryPath);
  }

  Future<void> exportWhitelistToJson(
      List<SmsWhitelistEntry> entries, String directoryPath) async {
    await exportToJson(entries, directoryPath);
  }

  // Export All functions using the separate data generation functions
  Future<String> exportAllWhitelistToCsv() async {
    
    return exportAllToCsv();
  }

  Future<String> exportAllWhitelistToJson() async {

    return exportAllToJson();
  }

}


/*
// 导入黑名单号码
Future<void> importSmsBlacklistNumbersFromUrl(String url) async {
  final entries = await parseFromUrl(url);
  final database = await _initDatabase();
  await _batchInsert('sms_blacklisted', entries, database);
}

Future<void> importSmsBlacklistNumbersFromLocal(String filePath) async {
  final entries = await parseFromLocal(filePath);
  final database = await _initDatabase();
  await _batchInsert('sms_blacklisted', entries, database);
}

// 导入白名单号码
Future<void> importSmsWhitelistNumbersFromUrl(String url) async {
  final entries = await parseFromUrl(url);
  final database = await _initDatabase();
  await _batchInsert('sms_whitelisted', entries, database);
}

Future<void> importSmsWhitelistNumbersFromLocal(String filePath) async {
  final entries = await parseFromLocal(filePath);
  final database = await _initDatabase();
  await _batchInsert('sms_whitelisted', entries, database);
}

Future<void> _batchInsert(String tableName, List<Map<String, dynamic>> entries,
    Database database) async {
  final batch = database.batch();
  for (final entry in entries) {
    batch.insert(tableName, entry);
  }
  await batch.commit();
}
*/