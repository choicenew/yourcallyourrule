import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:csv/csv.dart';

import 'package:http/http.dart' as http;
import 'dart:io';



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
      CREATE TABLE IF NOT EXISTS regex_patterns (

        pattern TEXT PRIMARY KEY, 
        name TEXT,        
        isWhitelist INTEGER,
        isBlacklist INTEGER,     
        enabled INTEGER 
      )
    ''');
  }
}


// RegexPattern 类 (in models/regex_pattern.dart)
class RegexPattern {

  String pattern;
  String name; // User-friendly name for the pattern  
  bool isWhitelist; // 是否白名单
  bool isBlacklist; // 是否黑名单
  bool enabled; // Flag to enable/disable the pattern

  RegexPattern({
        required this.pattern,
    required this.name,

    this.isWhitelist = false,
    this.isBlacklist = false,
    this.enabled = true,
  });

  factory RegexPattern.fromJson(Map<String, dynamic> json) =>
      RegexPattern(

        pattern: json['pattern'],
        name: json['name'],        
        isWhitelist: (json['isWhitelist'] as int) == 1, // 整数转换为布尔值
        isBlacklist: (json['isBlacklist'] as int) == 1, // 整数转换为布尔值
        enabled: (json['enabled'] as int) == 1, // 整数转换为布尔值
      );

  Map<String, dynamic> toJson() => {

        'pattern': pattern,
        'name': name,        
        'isWhitelist': isWhitelist ? 1 : 0, // 布尔值转换为整数
        'isBlacklist': isBlacklist ? 1 : 0, // 布尔值转换为整数
        'enabled': enabled ? 1 : 0, // 布尔值转换为整数
      };
}

class RegexService {
  final Database database;

  RegexService(this.database);

Future<void> add(RegexPattern rexPattern) async {
  // 将通配规则插入数据库，如果 URL 已经存在，则替换原来的通配规则项
  await database.insert('regex_patterns', rexPattern.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> addAll(List<RegexPattern> rexPatterns) async {
  final batch = database.batch();
  for (final rexPattern in rexPatterns) {
    batch.insert('regex_patterns', rexPattern.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  await batch.commit();
}

  Future<void> update(RegexPattern rexPattern) async {
    await database.update('regex_patterns', rexPattern.toJson(),
        where: 'pattern = ?', whereArgs: [rexPattern.pattern]);
  }

  Future<void> remove(RegexPattern rexPattern) async {
    await database.delete('regex_patterns',
        where: 'pattern = ?', whereArgs: [rexPattern.pattern]);
  }

  Future<void> edit(RegexPattern rexPattern) async {
    // Update using pattern for identification (assuming uniqueness)
    await database.update('regex_patterns', rexPattern.toJson(),
        where: 'pattern = ?', whereArgs: [rexPattern.pattern]);
  }

  Future<void> enablePattern(RegexPattern rexPattern) async {
    await database.update('regex_patterns', {'enabled': 1},
        where: 'pattern = ?', whereArgs: [rexPattern.pattern]);
  }

  Future<void> disablePattern(RegexPattern rexPattern) async {
    await database.update('regex_patterns', {'enabled': 0},
        where: 'pattern = ?', whereArgs: [rexPattern.pattern]);
  }

  Future<bool> whitelistedMatch(String phoneNumber) async {
    var rexPatterns = await getWhitelistedPatterns();
    return matches(phoneNumber, rexPatterns);
  }

  Future<bool> blacklistedMatch(String phoneNumber) async {
    var rexPatterns = await getBlacklistedPatterns();
    return matches(phoneNumber, rexPatterns);
  }

  Future<bool> matches(
      String phoneNumber, List<RegexPattern> rexPatterns) async {
    for (var rexPattern in rexPatterns) {
      if (matchesPattern(phoneNumber, rexPattern.pattern)) {
        return rexPattern.isBlacklist;
      }
    }
    return false;
  }

  bool matchesPattern(String phoneNumber, String pattern) {
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(phoneNumber);
  }

  Future<List<RegexPattern>> getBlacklistedPatterns() async {
    return getPatterns(where: 'isBlacklist = 1');
  }

  Future<List<RegexPattern>> getWhitelistedPatterns() async {
    return getPatterns(where: 'isWhitelist = 1');
  }

// 获取所有规则
  Future<List<RegexPattern>> getAllPatterns({String? orderBy, bool ascending = true}) async {
    final List<Map<String, dynamic>> results = await database.query(
      'regex_patterns',
      orderBy:
          orderBy != null ? '$orderBy ${ascending ? 'ASC' : 'DESC'}' : null,
    );
    return results.map((row) => RegexPattern.fromJson(row)).toList();
  }

  Future<List<RegexPattern>> getPatterns({String? where}) async {
    List<Map<String, dynamic>> results =
        await database.query('regex_patterns', where: where);
    return results.map((json) => RegexPattern.fromJson(json)).toList();
  }

  // --- 解析函数 ---

  List<Map<String, dynamic>> _parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
return csvList.skip(1).map((parts) {
    
      return {

        'pattern': parts.isNotEmpty ? parts[0].toString() : null,
        'name': parts.length > 1 ? parts[1].toString() : null,        
        'isWhitelist':
            parts.length > 2 && parts[2].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'isBlacklist':
            parts.length > 3 && parts[3].toString().toLowerCase() == 'true'
                ? 1
                : 0,
        'enabled': parts.length > 4 && parts[4].toString().toLowerCase() == 'true'
            ? 1
            : 0,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseJsonData(String data) {
    final jsonData = jsonDecode(data);
    if (jsonData is List) {
      return jsonData.map((rexPattern) {
        return {

          'pattern': rexPattern.containsKey('pattern') ? rexPattern['pattern'] : null,
          'name': rexPattern.containsKey('name') ? rexPattern['name'] : null,          
          'isWhitelist': rexPattern.containsKey('isWhitelist') && rexPattern['isWhitelist'] ? 1 : 0,
          'isBlacklist': rexPattern.containsKey('isBlacklist') && rexPattern['isBlacklist'] ? 1 : 0,
          'enabled': rexPattern.containsKey('enabled') && rexPattern['enabled'] ? 1 : 0,
        };
      }).toList();
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }

  // --- 解析逻辑处理函数 ---

  List<Map<String, dynamic>> _parseData(String data, String source) {
    if (source.endsWith('.csv')) return _parseCsvData(data);
    if (source.endsWith('.json')) return _parseJsonData(data);
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

  Future<void> importFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importFromLocal(String filePath) async {
    await _importFromLocal(filePath);
  }

  // --- 私有导入函数 ---

  Future<void> _importFromUrl(String url) async {
    final rexPatterns = await parseFromUrl(url);
    await _addAllWithPattern(rexPatterns);
  }

  Future<void> _importFromLocal(String filePath) async {
    final rexPatterns = await parseFromLocal(filePath);
    await _addAllWithPattern(rexPatterns);
  }

  // --- 批量添加或更新函数 ---

  Future<void> _addAllWithPattern(List<Map<String, dynamic>> rexPatterns) async {
    final batch = database.batch();
    for (final pattern in rexPatterns) {
      // 检查数据库中是否已存在相同的 pattern
      final exists = await database.query(
        'regex_patterns',
        where: 'pattern = ?',
        whereArgs: [pattern['pattern']],
      ).then((results) => results.isNotEmpty);

      if (exists) {
        batch.update(
          'regex_patterns',
          pattern,
          where: 'pattern = ?',
          whereArgs: [pattern['pattern']],
        );
      } else {
        batch.insert('regex_patterns', pattern);
      }
    }
    await batch.commit();
  }

  // --- 导出函数 ---

  Future<void> exportToCsv(
      List<RegexPattern> rexPatterns, String directoryPath) async {
    await _exportToCsv(rexPatterns, directoryPath);
  }

  Future<void> exportToJson(
      List<RegexPattern> rexPatterns, String directoryPath) async {
    await _exportToJson(rexPatterns, directoryPath);
  }

  // --- 数据生成函数 ---

  String _generateCsvData(List<RegexPattern> rexPatterns) {
    return const ListToCsvConverter().convert(rexPatterns
        .map((rexPattern) => [

              rexPattern.pattern,
               rexPattern.name,             
              rexPattern.isWhitelist ? '1' : '0',
              rexPattern.isBlacklist ? '1' : '0',
              rexPattern.enabled ? '1' : '0',
            ])
        .toList());
  }

  String _generateJsonData(List<RegexPattern> rexPatterns) {
    final listofMaps = rexPatterns.map((rexPattern) => rexPattern.toJson()).toList();
    return jsonEncode(listofMaps);
  }

  // --- 私有导出函数 ---

  Future<void> _exportToCsv(
      List<RegexPattern> rexPatterns, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/regex_patterns_$dateStr.csv';

    final csvData = _generateCsvData(rexPatterns);

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  Future<void> _exportToJson(
      List<RegexPattern> rexPatterns, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/regex_patterns_$dateStr.json';

    final jsonData = _generateJsonData(rexPatterns);

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }

  // --- 其他 ---

  Future<String> _fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}