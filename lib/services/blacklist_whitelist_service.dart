import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

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
      CREATE TABLE IF NOT EXISTS blacklist_phonenumber (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT,
        isSubscribed INTEGER,
        count INTEGER DEFAULT 0,
        url TEXT 
      )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS whitelist_phonenumber (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT,
        isSubscribed INTEGER,
        count INTEGER DEFAULT 0,
        url TEXT 
      )
    ''');
  }
}

abstract class ListEntry {
  String phoneNumber;
  String label;
  String? name;
  String? avatar;
  bool isSubscribed;
  int? count;
  String? url;

  ListEntry({
    required this.phoneNumber,
    required this.label,
    this.name,
    this.avatar,
    this.isSubscribed = false,
    this.count,
    this.url,
  });

  Map<String, dynamic> toMap();
}

class BlacklistEntry extends ListEntry {
  BlacklistEntry({
    required super.phoneNumber,
    required super.label,
    super.name,
    super.avatar,
    super.isSubscribed,
    super.count,
    super.url,
  });

  @override
  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'label': label,
        'name': name,
        'avatar': avatar,
        'isSubscribed': isSubscribed ? 1 : 0,
        'count': count,
        'url': url is String ? url : null, // 检查 url 是否为字符串
      };

  static BlacklistEntry fromJson(Map<String, dynamic> json) => BlacklistEntry(
        phoneNumber: json['phoneNumber'],
        label: json['label'],
        name: json['name'],
        avatar: json['avatar'],
        isSubscribed: json['isSubscribed'] == 1,
        count: json['count'],
        url: json['url'],
      );
}

class WhitelistEntry extends ListEntry {
  WhitelistEntry({
    required super.phoneNumber,
    required super.label,
    super.name,
    super.avatar,
    super.isSubscribed,
    super.count,
    super.url,
  });

  @override
  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'label': label,
        'name': name,
        'avatar': avatar,
        'isSubscribed': isSubscribed ? 1 : 0,
        'count': count,
        'url': url is String ? url : null, // 检查 url 是否为字符串
      };

  static WhitelistEntry fromJson(Map<String, dynamic> json) => WhitelistEntry(
        phoneNumber: json['phoneNumber'],
        label: json['label'],
        name: json['name'],
        avatar: json['avatar'],
        isSubscribed: json['isSubscribed'] == 1,
        count: json['count'],
        url: json['url'],
      );
}

abstract class ListService<T extends ListEntry> {
  final Database database;
  final String tableName;

  ListService(this.database, this.tableName);

  T fromJson(Map<String, dynamic> json);

  // 添加名单条目
  Future<void> add(T entry) async {
    final exists = await database.query(tableName,
        where: 'phoneNumber = ?',
        whereArgs: [entry.phoneNumber]).then((results) => results.isNotEmpty);
    if (!exists) {
      await database.insert(tableName, entry.toMap());
    }
  }

  // 添加/更新名单条目
  /*
  Future<void> addOrUpdate(T entry) async {
    final results = await database.query(tableName,
        where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
    final exists = results.isNotEmpty;

    exists
        ? await database.update(tableName, entry.toMap(),
            where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber])
        : await database.insert(tableName, entry.toMap());
  }
*/

  Future<void> addOrUpdate(T entry) async {
    await database.insert(tableName, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

// 批量添加名单条目
  Future<void> addAll(List<T> entries) async {
    final batch = database.batch();
    for (final entry in entries) {
      batch.insert(tableName, entry.toMap());
    }
    await batch.commit();
  }

/*
  Future<void> addAllOrUpdate(List<T> entries) async {
    final batch = database.batch();
    for (final entry in entries) {
      final exists = await database.query(tableName,
          where: 'phoneNumber = ?',
          whereArgs: [entry.phoneNumber]).then((results) => results.isNotEmpty);
      if (exists) {
        batch.update(tableName, entry.toMap(),
            where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
      } else {
        batch.insert(tableName, entry.toMap());
      }
    }
    await batch.commit();
  }
*/

  Future<void> addAllOrUpdate(List<T> entries) async {
    final batch = database.batch();
    for (final entry in entries) {
      batch.insert(tableName, entry.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  // 修改：添加带 URL 的名单条目
  Future<void> addWithUrl(T entry, String url) async {
    entry.isSubscribed = false;
    entry.url = url;
    await database.insert(tableName, entry.toMap());
  }

  // 修改：批量添加带 URL 的名单条目
  Future<void> addAllWithUrl(List<T> entries, String url) async {
    final batch = database.batch();
    for (final entry in entries) {
      entry.isSubscribed = false;
      entry.url = url;
      batch.insert(tableName, entry.toMap());
    }
    await batch.commit();
  }

  // 检查名单被标记数量
  Future<int> checkCount(String phoneNumber) async {
    final results = await database.query(
      tableName,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
    if (results.isNotEmpty) {
      return results.first['count'] as int? ?? 0;
    } else {
      return 0;
    }
  }

  //根据号码查询名单的标签
  Future<List<String>> getAllLabels() async {
    final labels = await database.query(tableName).then(
        (results) => results.map((row) => row['label'] as String).toList());
    return labels.toSet().toList();
  }

  Future<void> insertPredefinedLabelsIfNotExists(Database database) async {
    // 获取数据库中已存在的标签
    final existingLabels = await database.query(tableName, columns: [
      'label'
    ]).then((results) => results.map((row) => row['label'] as String).toSet());

    // 创建一个批处理操作
    final batch = database.batch();

    // 遍历预定义标签，插入不存在的标签
    for (final labelMap in predefinedLabels) {
      final label = labelMap['label'] as String;
      if (!existingLabels.contains(label)) {
        batch.insert(tableName, {
          'phoneNumber': 'PLACEHOLDER_${label.hashCode}', // 使用唯一的占位符
          'label': label,
          'isSubscribed': 0, // 假设默认为未订阅
        });
      }
    }

    // 执行批处理操作
    await batch.commit();
  }

//根据号码查询名单的标签
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

// 修改名单中号码的姓名和标签
  Future<void> editEntry(T entry) async {
    await database.update(tableName, entry.toMap(),
        where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
  }

// 根据url删除号码
  Future<void> deleteByUrl(String url) async {
    await database.delete(tableName, where: 'url = ?', whereArgs: [url]);
  }

// 移除名单条目
  Future<void> remove(T entry) async {
    await database.delete(tableName,
        where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
  }

  // 检查电话号码是否在名单中
  Future<bool> contains(String phoneNumber) async {
    final results = await database
        .query(tableName, where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
    return results.isNotEmpty;
  }

// 获取已订阅的名单条目
  Future<List<T>> getSubscribedEntries() async {
    final results = await database.query(tableName, where: 'isSubscribed = 1');
    return results.map((row) => fromJson(row)).toList();
  }

  // 获取所有名单条目

  /* 
  Future<List<T>> getEntries() async {
    final results = await database.query(tableName);
    return results.map((row) => fromJson(row)).toList();
  }
*/
  Future<List<T>> getEntries({String? orderBy, bool ascending = true}) async {
    final List<Map<String, dynamic>> results = await database.query(
      tableName,
      orderBy:
          orderBy != null ? '$orderBy ${ascending ? 'ASC' : 'DESC'}' : null,
    );
    return results.map((row) => fromJson(row)).toList();
  }

// 获取指定电话号码对应的名单条目
  Future<T?> getEntryByPhoneNumber(String phoneNumber) async {
    final results = await database
        .query(tableName, where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
    return results.isNotEmpty ? fromJson(results.first) : null;
  }

// Generic import functions
  Future<void> _importFromUrl(String url) async {
    final entries = await parseFromUrl(url);
    await _addAllWithUrl(tableName, entries, url); // 传递 tableName 参数
  }

  Future<void> _importFromLocal(String filePath) async {
    final entries = await parseFromLocal(filePath);
    await _addAllWithUrl(tableName, entries, null); // 传递 tableName 参数
  }

  // --- Refactored Data Generation Functions ---

  String _generateCsvData(List<T> entries) {
    return const ListToCsvConverter().convert(entries
        .map((entry) => [
              entry.phoneNumber,
              entry.label,
              entry.name ?? '',
              entry.avatar ?? '',
              entry.isSubscribed ? 1 : 0,
              entry.count?.toString() ?? '',
              entry.url ?? ''
            ])
        .toList());
  }

  String _generateJsonData(List<T> entries) {
    final listofMaps = entries.map((entry) => entry.toMap()).toList();
    return jsonEncode(listofMaps);
  }

  // --- End of Refactored Data Generation Functions ---

  // Generic export functions
  Future<void> _exportToCsv(List<T> entries, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/${tableName}_entries_$dateStr.csv';

    final csvData = _generateCsvData(entries); // Call the separate function

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  Future<void> _exportToJson(List<T> entries, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/${tableName}_entries_$dateStr.json';

    final jsonData = _generateJsonData(entries); // Call the separate function

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }

  List<Map<String, dynamic>> _parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
    return csvList.skip(1).map((parts) {
      return {
        'phoneNumber': parts.isNotEmpty ? parts[0] : null,
        'label': parts.length > 1 ? parts[1] : null,
        'name': parts.length > 2 && parts[2].toString().isNotEmpty
            ? parts[2]
            : null,
        'avatar': parts.length > 3 && parts[3].toString().isNotEmpty
            ? parts[3]
            : null,
        'isSubscribed':
            parts.length > 4 && (parts[4] == 'true' || parts[4] == '1') ? 1 : 0,
        'count': parts.length > 5 && parts[5].toString().isNotEmpty
            ? int.tryParse(parts[5].toString())
            : null,
        'url': parts.length > 6 ? parts[6] : null,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseJsonData(String data) {
    final jsonData = jsonDecode(data);

    List<Map<String, dynamic>> parseEntries(List entries) {
      return entries
          .map((entry) => {
                'phoneNumber': entry.containsKey('phoneNumber')
                    ? entry['phoneNumber']
                    : null,
                'label': entry.containsKey('label') ? entry['label'] : null,
                'name': entry.containsKey('name') ? entry['name'] : null,
                'avatar': entry.containsKey('avatar') ? entry['avatar'] : null,
                'isSubscribed': entry.containsKey('isSubscribed')
                    ? (entry['isSubscribed'] is bool
                        ? (entry['isSubscribed'] ? 1 : 0)
                        : entry['isSubscribed'])
                    : 0,
                'count': entry.containsKey('count')
                    ? (entry['count'] is String
                        ? int.tryParse(entry['count'])
                        : entry['count'])
                    : null,
                'url': entry.containsKey('url') ? entry['url'] : null,
              })
          .toList();
    }

    if (jsonData is List) {
      return parseEntries(jsonData);
    } else if (jsonData is Map && jsonData.containsKey('entries')) {
      return parseEntries(jsonData['entries']);
    } else if (jsonData is Map) {
      return parseEntries([jsonData]);
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }

  List<Map<String, dynamic>> _parseTxtData(String data) {
    final lines = data.split('\n');
    return lines.map((line) {
      final parts = line.split(',');
      return {
        'phoneNumber': parts.isNotEmpty ? parts[0] : null,
        'label': parts.length > 1 ? parts[1] : null,
        'name': parts.length > 2 && parts[2].toString().isNotEmpty
            ? parts[2]
            : null,
        'avatar': parts.length > 3 && parts[3].toString().isNotEmpty
            ? parts[3]
            : null,
        'isSubscribed':
            parts.length > 4 && (parts[4] == 'true' || parts[4] == '1') ? 1 : 0,
        'count': parts.length > 5 && parts[5].toString().isNotEmpty
            //? int.tryParse(parts[5])
            ? int.tryParse(parts[5].toString())
            : null,
        'url': parts.length > 6 ? parts[6] : null,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseYamlData(String data) {
    final yamlData = loadYaml(data) as List<dynamic>;
    return yamlData
        .map((entry) => {
              'phoneNumber': entry.containsKey('phoneNumber')
                  ? entry['phoneNumber']
                  : null,
              'label': entry.containsKey('label') ? entry['label'] : null,
              'name': entry.containsKey('name') ? entry['name'] : null,
              'avatar': entry.containsKey('avatar') ? entry['avatar'] : null,
              'isSubscribed': entry.containsKey('isSubscribed')
                  ? (entry['isSubscribed'] is bool
                      ? (entry['isSubscribed'] ? 1 : 0)
                      : entry['isSubscribed'])
                  : 0,
              // 'count': entry.containsKey('count') ? entry['count'] : null,
              'count': entry.containsKey('count')
                  ? (entry['count'] is String
                      ? int.tryParse(entry['count'])
                      : entry['count'])
                  : null,

              'url': entry.containsKey('url') ? entry['url'] : null,
            })
        .toList();
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
    if (source.endsWith('.csv')) return _parseCsvData(data);
    if (source.endsWith('.json')) return _parseJsonData(data);
    if (source.endsWith('.txt')) return _parseTxtData(data);
    if (source.endsWith('.yaml')) return _parseYamlData(data);
    throw UnsupportedError('Unsupported file format');
  }

  // 这个方法应该是公共的，因为它被子类调用
  Future<List<Map<String, dynamic>>> parseFromUrl(String url) async {
    final data = await _fetchData(url);

    return _parseData(data, url);
  }

  // 这个方法应该是公共的，因为它被子类调用
  Future<List<Map<String, dynamic>>> parseFromLocal(String filePath) async {
    final data = await File(filePath).readAsString();
    return _parseData(data, filePath);
  }

Future<void> _addAllWithUrl(String tableName, List<Map<String, dynamic>> entries, String? url) async {
  final batch = database.batch();

  for (final entry in entries) {
    // 修改判断逻辑，同时处理 null 和空字符串的情况
    if (entry['url'] == null || entry['url'].toString().isEmpty) {
      entry['url'] = url;
    }
    

    
    batch.insert(
      tableName, 
      entry,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  await batch.commit(noResult: true);
}

}

class BlacklistService extends ListService<BlacklistEntry> {
  BlacklistService(Database database)
      : super(database, 'blacklist_phonenumber');

  @override
  BlacklistEntry fromJson(Map<String, dynamic> json) =>
      BlacklistEntry.fromJson(json);

  Future<bool> isBlacklisted(String phoneNumber) => contains(phoneNumber);

  Future<List<BlacklistEntry>> getSubscribedBlacklistEntries() =>
      getSubscribedEntries();

  // Specific import functions calling the generic functions
  Future<void> importNumbersFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importNumbersFromLocal(String filePath) async {
    await _importFromLocal(filePath);
  }

  // Specific export functions calling the generic functions
  Future<void> exportToCsv(
      List<BlacklistEntry> entries, String directoryPath) async {
    await _exportToCsv(entries, directoryPath);
  }

  Future<void> exportToJson(
      List<BlacklistEntry> entries, String directoryPath) async {
    await _exportToJson(entries, directoryPath);
  }

  // Export All functions using the separate data generation functions
  Future<String> exportAllToCsv() async {
    final entries = await getEntries();
    return _generateCsvData(entries);
  }

  Future<String> exportAllBlacklistToJson() async {
    final entries = await getEntries();
    return _generateJsonData(entries);
  }
}

class WhitelistService extends ListService<WhitelistEntry> {
  WhitelistService(Database database)
      : super(database, 'whitelist_phonenumber');

  @override
  WhitelistEntry fromJson(Map<String, dynamic> json) =>
      WhitelistEntry.fromJson(json);

  Future<bool> isWhitelisted(String phoneNumber) => contains(phoneNumber);

  Future<List<WhitelistEntry>> getSubscribedWhitelistEntries() =>
      getSubscribedEntries();

  // Specific import functions calling the generic functions
  Future<void> importNumbersFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importNumbersFromLocal(String filePath) async {
    await _importFromLocal(filePath);
  }

  // Specific export functions calling the generic functions
  Future<void> exportToCsv(
      List<WhitelistEntry> entries, String directoryPath) async {
    await _exportToCsv(entries, directoryPath);
  }

  Future<void> exportToJson(
      List<WhitelistEntry> entries, String directoryPath) async {
    await _exportToJson(entries, directoryPath);
  }

  // Export All functions using the separate data generation functions
  Future<String> exportAllToCsv() async {
    final entries = await getEntries();
    return _generateCsvData(entries);
  }

  Future<String> exportAllToJson() async {
    final entries = await getEntries();
    return _generateJsonData(entries);
  }
}
