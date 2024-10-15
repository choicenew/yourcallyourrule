import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';


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
      CREATE TABLE IF NOT EXISTS sms_text_blacklisted(

        keyword TEXT NOT NULL UNIQUE,
        name TEXT,
        isSubscribed INTEGER,
        url TEXT
      )
    ''');
        await database.execute('''
      CREATE TABLE IF NOT EXISTS sms_text_whitelisted(

        keyword TEXT NOT NULL UNIQUE,
        name TEXT,
        isSubscribed INTEGER,
        url TEXT
      )
    ''');
  }
}

// 抽象类 TextEntry
abstract class TextEntry {
  String keyword;
  String? name;
  bool isSubscribed;
  String? url;

  TextEntry({
    required this.keyword,
    this.name,
    this.isSubscribed = false,
    this.url,
  });

  Map<String, dynamic> toJson() => {
        'keyword': keyword,
        'name': name,
        'isSubscribed': isSubscribed,
        'url': url,
      };

  factory TextEntry.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class SmsTextBlacklistEntry extends TextEntry {
  SmsTextBlacklistEntry({
    required String keyword,
    String? name,
    bool isSubscribed = false,
    String? url,
  }) : super(
          keyword: keyword,
          name: name,
          isSubscribed: isSubscribed,
          url: url,
        );

  factory SmsTextBlacklistEntry.fromJson(Map<String, dynamic> json) =>
      SmsTextBlacklistEntry(
        keyword: json['keyword'],
        name: json['name'],
        isSubscribed: json['isSubscribed'] ?? false,
        url: json['url'],
      );
}

class SmsTextWhitelistEntry extends TextEntry {
  SmsTextWhitelistEntry({
    required String keyword,
    String? name,
    bool isSubscribed = false,
    String? url,
  }) : super(
          keyword: keyword,
          name: name,
          isSubscribed: isSubscribed,
          url: url,
        );

  factory SmsTextWhitelistEntry.fromJson(Map<String, dynamic> json) =>
      SmsTextWhitelistEntry(
        keyword: json['keyword'],
        name: json['name'],
        isSubscribed: json['isSubscribed'] ?? false,
        url: json['url'],
      );
}


// 抽象类 _PhonelistService，注意前面加了下划线，表示私有
abstract class _PhonelistService<T extends TextEntry> {
  final Database database;
  final String tableName;

  _PhonelistService(this.database, this.tableName);

  // 添加条目
  Future<void> add(T entry) async {
    final exists = await database.query(tableName,
        where: 'keyword = ?',
        whereArgs: [entry.keyword]).then((results) => results.isNotEmpty);
    if (!exists) {
      await database.insert(tableName, entry.toJson());
    }
  }

  // 添加或更新条目
  Future<void> addOrUpdate(T entry) async {
    final exists = await database.query(tableName,
        where: 'keyword = ?',
        whereArgs: [entry.keyword]).then((results) => results.isNotEmpty);
    if (exists) {
      await database.update(tableName, entry.toJson(),
          where: 'keyword = ?', whereArgs: [entry.keyword]);
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
          where: 'keyword = ?',
          whereArgs: [entry.keyword]).then((results) => results.isNotEmpty);
      if (exists) {
        batch.update(tableName, entry.toJson(),
            where: 'keyword = ?', whereArgs: [entry.keyword]);
      } else {
        batch.insert(tableName, entry.toJson());
      }
    }
    await batch.commit();
  }


  // 修改关键词的姓名和标签
  Future<void> editEntry(T entry) async {
    await database.update(tableName, entry.toJson(),
        where: 'keyword = ?', whereArgs: [entry.keyword]);
  }

  // 根据URL删除关键词
  Future<void> deleteByUrl(String url) async {
    await database.delete(tableName, where: 'url = ?', whereArgs: [url]);
  }

  // 移除条目
  Future<void> remove(T entry) async {
    database
        .delete(tableName, where: 'keyword = ?', whereArgs: [entry.keyword]);
  }

  // 检查关键词是否存在
  Future<bool> contains(String keyword) {
    return database.query(tableName,
        where: 'keyword = ?',
        whereArgs: [keyword]).then((results) => results.isNotEmpty);
  }
  // 检查短信内容是否包含关键词
  Future<bool> isIncluded(String smsContent) async {
    final keywords = await getEntries();
    for (final keywordEntry in keywords) {
      // 尝试三种匹配方式
      if (smsContent.contains(keywordEntry.keyword) || // 原样匹配
          smsContent.toLowerCase().contains(keywordEntry.keyword.toLowerCase()) || // 转换为小写匹配
          smsContent.replaceAll(' ', '').contains(keywordEntry.keyword.replaceAll(' ', ''))) { // 去除空格匹配
        return true;
      }
    }
    return false;
  }

  // 获取已订阅的条目
  Future<List<T>> getSubscribedEntries() {
    return database.query(tableName, where: 'isSubscribed = 1').then(
        (results) =>
            results.map((row) => TextEntry.fromJson(row) as T).toList());
  }

  // 获取所有条目
  Future<List<T>> getEntries() {
    return database.query(tableName).then((results) =>
        results.map((row) => TextEntry.fromJson(row) as T).toList());
  }

  // 根据关键词获取条目
  Future<T?> getEntryByPhonekeyword(String keyword) {
    return database
        .query(tableName, where: 'keyword = ?', whereArgs: [keyword]).then(
            (results) => results.isNotEmpty
                ? TextEntry.fromJson(results.first) as T
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
            
              entry.keyword,
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
           
              entry.keyword,
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
             
                'keyword': entry.keyword,
                'name': entry.name ?? '',
                'isSubscribed': entry.isSubscribed,
                'url': entry.url ?? '',
              })
          .toList(),
    };
    return jsonEncode(jsonData);
  }

  // --- Parsing and Fetching Functions ---

  List<Map<String, dynamic>> _parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
    return csvList.map((parts) {
      return {

        'keyword': parts[0],

        'name': parts[1].isNotEmpty ? parts[1] : null,
        'isSubscribed': parts[2].toLowerCase() == 'true',

        'url': parts[3].isNotEmpty ? parts[3] : null,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseJsonData(String data) {
    final jsonData = jsonDecode(data) as List<dynamic>;
    return jsonData.map((entry) {
      return {

        'keyword': entry['keyword'],

        'name': entry['name'],
        'isSubscribed': entry['isSubscribed'] ?? false,

        'url': entry['url'],
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseTxtData(String data) {
    final lines = data.split('\n');
    return lines.map((line) {
      final parts = line.split(',');
      return {

        'keyword': parts[0],

        'name': parts[1].isNotEmpty ? parts[1] : null,
        'isSubscribed': parts[2].toLowerCase() == 'true',

        'url': parts[3].isNotEmpty ? parts[3] : null,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseYamlData(String data) {
    final yamlData = loadYaml(data) as List<dynamic>;
    return yamlData.map((entry) {
      return {

        'keyword': entry['keyword'],

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
class SmsTextBlacklistService extends _PhonelistService<SmsTextBlacklistEntry> {
  SmsTextBlacklistService(Database database) : super(database, 'sms_text_blacklisted');

  // 检查电话关键词是否在黑名单中
  Future<bool> isBlacklisted(String keyword) {
    return contains(keyword);
  }

    // 导入黑名单关键词
Future<void> importSmsTextBlacklistFromUrl(String url) async {
    await _importFromUrl(url);
}

Future<void> importSmsTextBlacklistFromLocal(String filePath) async {
    await _importFromLocal(filePath);
}
  Future<void> exportSmsTextBlacklistToCsv(
      List<SmsTextBlacklistEntry> entries, String directoryPath) async {
    await exportToCsv(entries, directoryPath);
  }

  Future<void> exportSmsTextBlacklistToJson(
      List<SmsTextBlacklistEntry> entries, String directoryPath) async {
    await exportToJson(entries, directoryPath);
  }

  // Export All functions using the separate data generation functions
  Future<String> exportSmsTextAllBlacklistToCsv() async {

    return exportAllToCsv();
  }

  Future<String> exportSmsTextAllBlacklistToJson() async {

    return exportAllToJson();
  }
}

// 白名单服务类
class SmsTextWhitelistService extends _PhonelistService<SmsTextWhitelistEntry> {
  SmsTextWhitelistService(Database database) : super(database, 'sms_text_whitelisted');

  // 检查电话关键词是否在白名单中
  Future<bool> isWhitelisted(String keyword) {
    return contains(keyword);
  }


// 导入白名单关键词
Future<void> importSmsTextWhitelistFromUrl(String url) async {
    await _importFromUrl(url);
}

Future<void> importSmsTextWhitelistFromLocal(String filePath) async {
    await _importFromLocal(filePath);
}

  Future<void> exportSmsTextWhitelistToCsv(
      List<SmsTextWhitelistEntry> entries, String directoryPath) async {
    await exportToCsv(entries, directoryPath);
  }

  Future<void> exportSmsTextWhitelistToJson(
      List<SmsTextWhitelistEntry> entries, String directoryPath) async {
    await exportToJson(entries, directoryPath);
  }

  // Export All functions using the separate data generation functions
  Future<String> exportSmsTextAllWhitelistToCsv() async {

    return exportAllToCsv();
  }

  Future<String> exportSmsTextAllWhitelistToJson() async {

    return exportAllToJson();
  }

}


/*
// 解析数据
List<Map<String, dynamic>> parseCsvData(String data) {
  final csvList = const CsvToListConverter().convert(data);
  return csvList
      .map(
          (parts) => {'keyword': parts[0], 'name': parts[1]})
      .toList();
}

List<Map<String, dynamic>> parseJsonData(String data) {
  final jsonData = jsonDecode(data) as List<dynamic>;
  final List<Map<String, dynamic>> entries = [];
  for (final entry in jsonData) {
    if (
        !entry.containsKey('keyword') ||
        !entry.containsKey('name')) {
      continue;
    }
    final Map<String, dynamic> mappedEntry = {
     
      'keyword': entry['keyword'],
      'name': entry['name'],
    };
    entries.add(mappedEntry);
  }
  return entries;
}

List<Map<String, dynamic>> parseTxtData(String data) {
  final lines = data.split('\n');
  final List<Map<String, dynamic>> entries = [];
  for (final line in lines) {
    if (line.isEmpty || line.split(',').length < 3) {
      continue;
    }
    final parts = line.split(',');
    final Map<String, dynamic> mappedEntry = {

      'keyword': parts[0],
      'name': parts[1],
    };
    entries.add(mappedEntry);
  }
  return entries;
}

List<Map<String, dynamic>> parseYamlData(String data) {
  final yamlData = loadYaml(data) as List<dynamic>;
  final List<Map<String, dynamic>> entries = [];
  for (final entry in yamlData) {
    if (
        !entry.containsKey('keyword') ||
        !entry.containsKey('name')) {
      continue;
    }
    final Map<String, dynamic> mappedEntry = {
      
      'keyword': entry['keyword'],
      'name': entry['name'],
    };
    entries.add(mappedEntry);
  }
  return entries;
}

Future<String> _fetchData(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to fetch data');
  }
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

// 导入黑名单关键词
Future<void> importSmsTextBlacklistFromUrl(String url) async {
  final entries = await parseFromUrl(url);
  final database = await _initDatabase();
  await _batchInsert('sms_blacklisted', entries, database);
}

Future<void> importSmsTextBlacklistFromLocal(String filePath) async {
  final entries = await parseFromLocal(filePath);
  final database = await _initDatabase();
  await _batchInsert('sms_blacklisted', entries, database);
}

// 导入白名单关键词
Future<void> importSmsTextWhitelistFromUrl(String url) async {
  final entries = await parseFromUrl(url);
  final database = await _initDatabase();
  await _batchInsert('sms_whitelisted', entries, database);
}

Future<void> importSmsTextWhitelistFromLocal(String filePath) async {
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
/*// ... 其他代码 ...

abstract class _PhonelistService<T extends TextEntry> {
  // ... 其他代码 ...

  // 检查短信内容是否包含关键词
  Future<bool> isIncluded(String smsContent, {bool caseSensitive = false, bool ignoreSpace = false}) async {
    final keywords = await getEntries();
    for (final keywordEntry in keywords) {
      final preparedKeyword = caseSensitive ? keywordEntry.keyword : keywordEntry.keyword.toLowerCase();
      final preparedContent = caseSensitive ? smsContent : smsContent.toLowerCase();

      if (ignoreSpace) {
        if (preparedContent.replaceAll(' ', '').contains(preparedKeyword.replaceAll(' ', ''))) {
          return true;
        }
      } else {
        if (preparedContent.contains(preparedKeyword)) {
          return true;
        }
      }
    }
    return false;
  }

  // ... 其他代码 ...
}

// ... 其他代码 ...
// 区分大小写，不忽略空格
final isIncluded1 = await smsBlacklistService.isIncluded(smsContent, caseSensitive: true, ignoreSpace: false);

// 不区分大小写，忽略空格
final isIncluded2 = await smsBlacklistService.isIncluded(smsContent, caseSensitive: false, ignoreSpace: true);

// ... 其他代码 ...

abstract class _PhonelistService<T extends TextEntry> {
  // ... 其他代码 ...

  // 检查短信内容是否包含关键词
  Future<bool> isIncluded(String smsContent) async {
    final keywords = await getEntries();
    for (final keywordEntry in keywords) {
      // 尝试三种匹配方式
      if (smsContent.contains(keywordEntry.keyword) || // 原样匹配
          smsContent.toLowerCase().contains(keywordEntry.keyword.toLowerCase()) || // 转换为小写匹配
          smsContent.replaceAll(' ', '').contains(keywordEntry.keyword.replaceAll(' ', ''))) { // 去除空格匹配
        return true;
      }
    }
    return false;
  }

  // ... 其他代码 ...
}

// ... 其他代码 ...*/