import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
      CREATE TABLE IF NOT EXISTS blocked_phonenumber (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT
      )
    ''');

    await database.execute('''
      CREATE TABLE IF NOT EXISTS allowed_phonenumber (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT
      )
    ''');
  }
}

abstract class ListEntry {
  String phoneNumber;
  String label;
  String? name;
  String? avatar;

  ListEntry({
    required this.phoneNumber,
    required this.label,
    this.name,
    this.avatar,
  });

  Map<String, dynamic> toMap();
}

class BlockedEntry extends ListEntry {
  BlockedEntry({
    required super.phoneNumber,
    required super.label,
    super.name,
    super.avatar,
  });

  @override
  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'label': label,
        'name': name,
        'avatar': avatar,
      };

  static BlockedEntry fromJson(Map<String, dynamic> json) => BlockedEntry(
        phoneNumber: json['phoneNumber'],
        label: json['label'],
        name: json['name'],
        avatar: json['avatar'],
      );
}

class AllowedEntry extends ListEntry {
  AllowedEntry({
    required super.phoneNumber,
    required super.label,
    super.name,
    super.avatar,
  });

  @override
  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'label': label,
        'name': name,
        'avatar': avatar,
      };

  static AllowedEntry fromJson(Map<String, dynamic> json) => AllowedEntry(
        phoneNumber: json['phoneNumber'],
        label: json['label'],
        name: json['name'],
        avatar: json['avatar'],
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

  Future<void> addAllOrUpdate(List<T> entries) async {
    final batch = database.batch();
    for (final entry in entries) {
      batch.insert(tableName, entry.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
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

  // 获取所有名单条目
  Future<List<T>> getEntries() async {
    final results = await database.query(tableName);
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
    final entries = await _parseFromUrl(url);
    await _addAllWithUrl(tableName, entries); // 传递 tableName 参数
  }

  Future<void> _importFromLocal(String filePath) async {
    final entries = await _parseFromLocal(filePath);
    await _addAllWithUrl(tableName, entries); // 传递 tableName 参数
  }

  // --- Refactored Data Generation Functions ---

  String _generateCsvData(List<T> entries) {
    return const ListToCsvConverter().convert(entries
        .map((entry) => [
              entry.phoneNumber,
              entry.label,
              entry.name ?? '',
              entry.avatar ?? ''
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

  // --- Parsing and Fetching Functions ---

  List<Map<String, dynamic>> _parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data, eol: '\r\n');
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

  Future<List<Map<String, dynamic>>> _parseFromUrl(String url) async {
    final data = await _fetchData(url);
    if (url.endsWith('.csv')) {
      return _parseCsvData(data);
    } else if (url.endsWith('.json')) {
      return _parseJsonData(data);
    } else if (url.endsWith('.txt')) {
      return _parseTxtData(data);
    } else if (url.endsWith('.yaml')) {
      return _parseYamlData(data);
    } else {
      throw UnsupportedError('Unsupported file format');
    }
  }

  Future<List<Map<String, dynamic>>> _parseFromLocal(String filePath) async {
    final data = await File(filePath).readAsString();
    if (filePath.endsWith('.csv')) {
      return _parseCsvData(data);
    } else if (filePath.endsWith('.json')) {
      return _parseJsonData(data);
    } else if (filePath.endsWith('.txt')) {
      return _parseTxtData(data);
    } else if (filePath.endsWith('.yaml')) {
      return _parseYamlData(data);
    } else {
      throw UnsupportedError('Unsupported file format');
    }
  }

// 在 ListService 类中修改 _addAllWithUrl 方法
  Future<void> _addAllWithUrl(
      String tableName, List<Map<String, dynamic>> entries) async {
    final batch = database.batch();
    // 打印列表长度
    for (final entry in entries) {
      // 打印正在添加的条目
      batch.insert(tableName, entry,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
    // 打印添加成功的消息
  }
}

class BlockedService extends ListService<BlockedEntry> {
  BlockedService(Database database) : super(database, 'blocked_phonenumber');

  @override
  BlockedEntry fromJson(Map<String, dynamic> json) =>
      BlockedEntry.fromJson(json);

  Future<bool> isBlocked(String phoneNumber) => contains(phoneNumber);

  // Specific import functions calling the generic functions
  Future<void> importNumbersFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importNumbersFromLocal(String filePath) async {
    await _importFromLocal(filePath);
  }

  // Specific export functions calling the generic functions
  Future<void> exportToCsv(
      List<BlockedEntry> entries, String directoryPath) async {
    await _exportToCsv(entries, directoryPath);
  }

  Future<void> exportToJson(
      List<BlockedEntry> entries, String directoryPath) async {
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

class AllowedService extends ListService<AllowedEntry> {
  AllowedService(Database database) : super(database, 'allowed_phonenumber');

  @override
  AllowedEntry fromJson(Map<String, dynamic> json) =>
      AllowedEntry.fromJson(json);

  Future<bool> isAllowed(String phoneNumber) => contains(phoneNumber);

  // Specific import functions calling the generic functions
  Future<void> importNumbersFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importNumbersFromLocal(String filePath) async {
    await _importFromLocal(filePath);
  }

  // Specific export functions calling the generic functions
  Future<void> exportToCsv(
      List<AllowedEntry> entries, String directoryPath) async {
    await _exportToCsv(entries, directoryPath);
  }

  Future<void> exportToJson(
      List<AllowedEntry> entries, String directoryPath) async {
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
