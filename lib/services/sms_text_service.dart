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

  Map<String, dynamic> toMap();
}

class SmsTextBlacklistEntry extends TextEntry {
  SmsTextBlacklistEntry({
    required super.keyword,
    super.name,
    super.isSubscribed,
    super.url,
  });

  @override
  Map<String, dynamic> toMap() => {
        'keyword': keyword,

        'name': name,

        'isSubscribed': isSubscribed ? 1 : 0,

        'url': url is String ? url : null, // 检查 url 是否为字符串
      };

  static SmsTextBlacklistEntry fromJson(Map<String, dynamic> json) =>
      SmsTextBlacklistEntry(
        keyword: json['keyword'],
        name: json['name'],
        isSubscribed: json['isSubscribed'] == 1,
        url: json['url'],
      );
}

class SmsTextWhitelistEntry extends TextEntry {
  SmsTextWhitelistEntry({
    required super.keyword,
    super.name,
    super.isSubscribed,
    super.url,
  });

  @override
  Map<String, dynamic> toMap() => {
        'keyword': keyword,

        'name': name,

        'isSubscribed': isSubscribed ? 1 : 0,

        'url': url is String ? url : null, // 检查 url 是否为字符串
      };

  static SmsTextWhitelistEntry fromJson(Map<String, dynamic> json) =>
      SmsTextWhitelistEntry(
        keyword: json['keyword'],
        name: json['name'],
        isSubscribed: json['isSubscribed'] == 1,
        url: json['url'],
      );
}

abstract class TextlistService<T extends TextEntry> {
  final Database database;
  final String tableName;

  TextlistService(this.database, this.tableName);

  T fromJson(Map<String, dynamic> json);

  // 添加名单条目
  Future<void> add(T entry) async {
    final exists = await database.query(tableName,
        where: 'keyword = ?',
        whereArgs: [entry.keyword]).then((results) => results.isNotEmpty);
    if (!exists) {
      await database.insert(tableName, entry.toMap());
    }
  }

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


// 修改名单中关键词的姓名和标签
  Future<void> editEntry(T entry) async {
    await database.update(tableName, entry.toMap(),
        where: 'keyword = ?', whereArgs: [entry.keyword]);
  }

// 根据url删除关键词
  Future<void> deleteByUrl(String url) async {
    await database.delete(tableName, where: 'url = ?', whereArgs: [url]);
  }

// 移除名单条目
  Future<void> remove(T entry) async {
    await database
        .delete(tableName, where: 'keyword = ?', whereArgs: [entry.keyword]);
  }

  // 检查关键词是否在名单中
  Future<bool> contains(String keyword) async {
    final results = await database
        .query(tableName, where: 'keyword = ?', whereArgs: [keyword]);
    return results.isNotEmpty;
  }


//检查是否包含关键词
Future<bool> isIncluded(String smsContent) async {
  final keywords = await getEntries();

  for (final keywordEntry in keywords) {
    String keyword = keywordEntry.keyword;

    if (smsContent.contains(keyword)) {
      return true;
    }
  }

  return false;
}



// 获取已订阅的名单条目
  Future<List<T>> getSubscribedEntries() async {
    final results = await database.query(tableName, where: 'isSubscribed = 1');
    return results.map((row) => fromJson(row)).toList();
  }

  // 获取所有名单条目
  Future<List<T>> getEntries({String? orderBy, bool ascending = true}) async {
    final List<Map<String, dynamic>> results = await database.query(
      tableName,
      orderBy:
          orderBy != null ? '$orderBy ${ascending ? 'ASC' : 'DESC'}' : null,
    );
    return results.map((row) => fromJson(row)).toList();
  }

// 获取指定关键词对应的名单条目
  Future<T?> getEntryByKeyword(String keyword) async {
    final results = await database
        .query(tableName, where: 'keyword = ?', whereArgs: [keyword]);
    return results.isNotEmpty ? fromJson(results.first) : null;
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

  // --- Refactored Data Generation Functions ---

  String _generateCsvData(List<T> entries) {
    return const ListToCsvConverter().convert(entries
        .map((entry) => [
              entry.keyword,
              entry.name ?? '',
              entry.isSubscribed ? 1 : 0,
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
        'keyword': parts.isNotEmpty ? parts[0] : null,
        'name': parts.length > 1 && parts[1].toString().isNotEmpty
            ? parts[1]
            : null,
        'isSubscribed':
            parts.length > 2 && (parts[2] == 'true' || parts[2] == '1') ? 1 : 0,
        'url': parts.length > 3 ? parts[3] : null,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseJsonData(String data) {
    final jsonData = jsonDecode(data);

    List<Map<String, dynamic>> parseEntries(List entries) {
      return entries
          .map((entry) => {
                'keyword':
                    entry.containsKey('keyword') ? entry['keyword'] : null,
                'name': entry.containsKey('name') ? entry['name'] : null,
                'isSubscribed': entry.containsKey('isSubscribed')
                    ? (entry['isSubscribed'] is bool
                        ? (entry['isSubscribed'] ? 1 : 0)
                        : entry['isSubscribed'])
                    : 0,
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
        'keyword': parts.isNotEmpty ? parts[0] : null,
        'name': parts.length > 1 && parts[1].toString().isNotEmpty
            ? parts[1]
            : null,
        'isSubscribed':
            parts.length > 2 && (parts[2] == 'true' || parts[2] == '1') ? 1 : 0,
        'url': parts.length > 3 ? parts[3] : null,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _parseYamlData(String data) {
    final yamlData = loadYaml(data) as List<dynamic>;
    return yamlData
        .map((entry) => {
              'keyword': entry.containsKey('keyword') ? entry['keyword'] : null,
              'name': entry.containsKey('name') ? entry['name'] : null,
              'isSubscribed': entry.containsKey('isSubscribed')
                  ? (entry['isSubscribed'] is bool
                      ? (entry['isSubscribed'] ? 1 : 0)
                      : entry['isSubscribed'])
                  : 0,
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

// 在 TextlistService 类中修改 _addAllWithUrl 方法
  Future<void> _addAllWithUrl(
      String tableName, List<Map<String, dynamic>> entries, String? url) async {
    final batch = database.batch();
    for (final entry in entries) {
      // 添加 URL（如果提供了且条目中没有）
      if (url != null && !entry.containsKey('url')) {
        entry['url'] = url;
      }

      final exists = await database.query(
        tableName,
        where: 'keyword = ?',
        whereArgs: [entry['keyword']],
      ).then((results) => results.isNotEmpty);

      if (exists) {
        batch.update(
          tableName,
          entry,
          where: 'keyword = ?',
          whereArgs: [entry['keyword']],
        );
      } else {
        batch.insert(tableName, entry);
      }
    }
    await batch.commit();
  }
}

class SmsTextBlacklistService extends TextlistService<SmsTextBlacklistEntry> {
  SmsTextBlacklistService(Database database)
      : super(database, 'sms_text_blacklisted');

  @override
  SmsTextBlacklistEntry fromJson(Map<String, dynamic> json) =>
      SmsTextBlacklistEntry.fromJson(json);

  Future<bool> isBlacklisted(String keyword) => contains(keyword);

  Future<List<SmsTextBlacklistEntry>> getSubscribedBlacklistEntries() =>
      getSubscribedEntries();

  // Specific import functions calling the generic functions
  Future<void> importKeywordsFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importKeywordsFromLocal(String filePath) async {
    await _importFromLocal(filePath);
  }

  // Specific export functions calling the generic functions
  Future<void> exportToCsv(
      List<SmsTextBlacklistEntry> entries, String directoryPath) async {
    await _exportToCsv(entries, directoryPath);
  }

  Future<void> exportToJson(
      List<SmsTextBlacklistEntry> entries, String directoryPath) async {
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

class SmsTextWhitelistService extends TextlistService<SmsTextWhitelistEntry> {
  SmsTextWhitelistService(Database database)
      : super(database, 'sms_text_whitelisted');

  @override
  SmsTextWhitelistEntry fromJson(Map<String, dynamic> json) =>
      SmsTextWhitelistEntry.fromJson(json);

  Future<bool> isWhitelisted(String keyword) => contains(keyword);

  Future<List<SmsTextWhitelistEntry>> getSubscribedWhitelistEntries() =>
      getSubscribedEntries();

  // Specific import functions calling the generic functions
  Future<void> importKeywordsFromUrl(String url) async {
    await _importFromUrl(url);
  }

  Future<void> importKeywordsFromLocal(String filePath) async {
    await _importFromLocal(filePath);
  }

  // Specific export functions calling the generic functions
  Future<void> exportToCsv(
      List<SmsTextWhitelistEntry> entries, String directoryPath) async {
    await _exportToCsv(entries, directoryPath);
  }

  Future<void> exportToJson(
      List<SmsTextWhitelistEntry> entries, String directoryPath) async {
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
