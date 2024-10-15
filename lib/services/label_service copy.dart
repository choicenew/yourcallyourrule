import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

import 'package:yaml/yaml.dart';
import '../utils/predefined_labels.dart';

//import '../models/label_model.dart';
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
      CREATE TABLE IF NOT EXISTS labeled_calls (
        
        phoneNumber TEXT,
        label TEXT,
        name TEXT,
        avatar TEXT
        
      )
    ''');
  }
}

class LabeledEntry {
  String phoneNumber; // 电话
    String label; // 标签文本内容
  String? name; // 电话名称
  String? avatar; // 标签头像


  LabeledEntry({
    required this.phoneNumber,
        required this.label,
    this.name,
    this.avatar,

  });

  static LabeledEntry fromJson(Map<String, dynamic> json) => LabeledEntry(
        phoneNumber: json['phoneNumber'],
         label: json['label'],       
        name: json['name'],
        avatar: json['avatar'],

      );

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'label': label,        
        'name': name,
        'avatar': avatar,

      };
}

// 数据库实例
class LabelService {
  final Database database;

  LabelService(this.database);

  // 获取所有标签
  // Future<List<Label>> getAllLabels() async {
  //   final List<Map<String, dynamic>> maps = await database.query('labeled_calls');
  //  return List.generate(maps.length, (i) => Label.fromJson(maps[i]));
  // }
  // 添加标签
  // Future<void> addLabel(Label label) async {
  //   await database.insert('labeled_calls', label.toJson());
  //}

  // 编辑标签
  // Future<void> editLabel(Label label) async {
  //   await database.update('labeled_calls', label.toJson(), where: 'label = ?', whereArgs: [label]);
  // }

  // 删除标签
  //Future<void> deleteLabel(int id) async {
  //  await database.delete('labeled_calls', where: 'label = ?', whereArgs: [label]);
  // }

  // 添加标签到号码

  Future<void> addLabelForPhoneNumber(String label, String phoneNumber) async {
    // 查询是否已经存在相同的电话号码和标签
    final List<Map<String, dynamic>> existingRecords = await database.query(
      'labeled_calls',
      where: 'phonenumber = ? AND label = ?',
      whereArgs: [phoneNumber, label],
    );

    // 如果不存在相同的记录，则插入新记录
    if (existingRecords.isEmpty) {
      await database.insert('labeled_calls', {
        'label': label,
        'phonenumber': phoneNumber,
      });
    }
  }

// 删除号码和标签
  Future<void> deleteLabelAndNumber(String phoneNumber) async {
    // 删除标签与号码的关联关系
    await database.delete('labeled_calls',
        where: 'phonenumber = ?', whereArgs: [phoneNumber]);
  }

  // 添加/更新名单条目
  Future<void> addOrUpdate(LabeledEntry entry) async {
    final exists = await database.query('labeled_calls',
        where: 'phoneNumber = ?',
        whereArgs: [entry.phoneNumber]).then((results) => results.isNotEmpty);

    if (exists) {
      await database.update('labeled_calls', entry.toJson(),
          where: 'phoneNumber = ?', whereArgs: [entry.phoneNumber]);
    } else {
      await database.insert('labeled_calls', entry.toJson());
    }
  }


  // 编辑号码的标签
  Future<void> editLabelForPhoneNumber(String label, String phoneNumber) async {
    // 更新数据库
    await database.update(
        'labeled_calls',
        {
          'label': label,
        },
        where: 'phonenumber = ?',
        whereArgs: [phoneNumber]);
  }

  // 获取所有标记的号码
  Future<List<LabeledEntry>> getLabeledEntries() {
    return database.query('labeled_calls').then(
        (results) => results.map((row) => LabeledEntry.fromJson(row)).toList());
  }

// 获取所有标签
  Future<List<String>> getAllLabels() async {
    // Retrieve all records from the 'labeled_calls' table
    final labels = await database.query('labeled_calls').then(
        (results) => results.map((row) => row['label'] as String).toList());

    // Return unique labels
    return labels.toSet().toList();
  }

  // 如果没有标签则插入
  Future<void> insertPredefinedLabelsIfNotExists(Database database) async {
    final count =
        await database.query('labeled_calls').then((results) => results.length);
    if (count == 0) {
      final batch = database.batch();
      for (final label in predefinedLabels) {
        batch.insert('labeled_calls', label);
      }
      await batch.commit();
    }
  }

  // 删除号码的标签
  Future<void> deleteLabelFromPhoneNumber(String phoneNumber) async {
    await database.delete('labeled_calls',
        where: 'phonenumber = ?', whereArgs: [phoneNumber]);
  }

  // 根据号码查询标签
// 根据号码查询标签
Future<LabeledEntry?> getLabelFromPhoneNumber(String phoneNumber) async {
  // 直接查询数据库，号码进行匹配
  final result = await database.query(
    'labeled_calls',
    where: 'phonenumber IN (?, ?)',
    whereArgs: [phoneNumber],
  );

  // 如果找到匹配的标签，则返回 LabeledEntry 对象
  return result.isNotEmpty ? LabeledEntry.fromJson(result.first) : null;
}

  /*// 获取号码的标签
  Future<List<String>> getLabelByPhoneNumber(String phoneNumber) async {
    // 3. 解析电话号码
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
    // 4. 格式化为 E.164 格式和本地格式的号码
    final e164Number = PhoneNumberUtil.instance
        .format(parsedPhoneNumber, PhoneNumberFormat.e164);
    final nationalNumber = PhoneNumberUtil.instance
        .format(parsedPhoneNumber, PhoneNumberFormat.national);
    // Get labels from database1. 首先从数据库获取所有标签
    final labels = await getAllLabels();

    // 5. 尝试匹配带国家代码的号码
    List<LabeledEntry> matchedLabels =
        labels.where((label) => LabeledEntry.phoneNumber == e164Number).toList();

    // 6. 如果没有匹配到，则尝试匹配本地号码
    if (matchedLabels.isEmpty) {
      matchedLabels =
          labels.where((label) => LabeledEntry.phoneNumber == nationalNumber).toList();
    }

    // 7. 翻译标签名称
    // final Locale locale = Localizations.localeOf(context);
    // 使用 intl 包提供的 `Intl.message` 方法翻译文本
    //for (var i = 0; i < labels.length; i++) {
    //  labels[i].name = Intl.message(
    //   labels[i].name,
    //   locale: locale,
    //  args: labels[i].args,
    // );
    // }

    // 6. 根据号码属性选择预设头像
    for (final LabeledEntry label in labels) {
      if (phoneNumber.contains(label.label)) {
        label.avatar = 'assets/avatars/${label.label}.png';
        break;
      }
    }
    return matchedLabels;
  }*/

// 添加标签与通话记录的关联关系
  Future<void> addLabelCallLogRelation(String label, String phoneNumber) async {
    await database.insert('labeled_calls', {
      'label': label,
      'phonenumber': phoneNumber,
    });
  }

// 更新标签与通话记录的关联关系
  Future<void> updateLabelCallLogRelation(
      String label, String phoneNumber) async {
    await database.update(
        'labeled_calls',
        {
          'label': label,
        },
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber]);
  }

// 删除标签与通话记录的关联关系
  Future<void> deleteLabelCallLogRelation(String phoneNumber) async {
    await database.delete('labeled_calls',
        where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
  }

// 获取数据库中所有信息列表
  Future<List<Map<String, dynamic>>> getLabeledData() async {
    final List<Map<String, dynamic>> labelMaps =
        await database.query('labeled_calls'); // 数据表名为 'labeled_calls'
    return labelMaps;
  }
}

// 添加导出为 CSV 格式的功能
Future<void> exportLabeledToCSV(
    List<LabeledEntry> entries, String directoryPath) async {
  final now = DateTime.now();
  final dateStr = now.toString().split(' ')[0];
  final filePath = '$directoryPath/whitelist_entries_$dateStr.csv';

  final csvData = ListToCsvConverter().convert(entries
      .map((entry) => [
            entry.phoneNumber,
            entry.label,
            entry.name ?? '',
            entry.avatar ?? ''
          ])
      .toList());

  final file = File(filePath);
  await file.writeAsString(csvData);
}

// 添加导出为 JSON 格式的功能
Future<void> exportLabeledToJson(
    List<LabeledEntry> entries, String directoryPath) async {
  final now = DateTime.now();
  final dateStr = now.toString().split(' ')[0];
  final filePath = '$directoryPath/whitelist_entries_$dateStr.json';

  final jsonData = {
    'entries': entries.map((entry) => entry.toJson()).toList(),
  };

  final file = File(filePath);
  await file.writeAsString(jsonEncode(jsonData));
}


/*
// 导出数据库信息为CSV文件
Future<void> exportLabeledNumbersToCSV(
    {String? filePath, required String directory}) async {
  final database = await _initDatabase();
  final List<Map<String, dynamic>> labeledData =
      await database.query('labeled_calls'); // 直接查询数据库获取数据
  final csvFile = File(filePath ?? 'labeled_calls.csv');
  final csvList = [
    ['phoneNumber', 'name', 'avatar', 'label'],
    for (final data in labeledData)
      [
        data['phoneNumber'],
        data['name'] ?? '',
        data['avatar'] ?? '',
        data['label']
      ]
  ];
  final csvString = const ListToCsvConverter().convert(csvList);
  await csvFile.writeAsString(csvString);
}

// 导出数据库信息为JSON文件
Future<void> exportLabeledNumbersToJson(
    {String? filePath, required String directory}) async {
  final database = await _initDatabase();
  final List<Map<String, dynamic>> labeledData =
      await database.query('labeled_calls'); // 直接查询数据库获取数据;
  final jsonFile = File(filePath ?? 'labeled_calls.json');
  final jsonString = json.encode(labeledData);
  await jsonFile.writeAsString(jsonString);
}
*/

List<Map<String, dynamic>> parseCsvData(String data) {
  final csvList = const CsvToListConverter().convert(data);
  return csvList
      .map((parts) =>
          {'label': parts[0], 'phoneNumber': parts[1], 'name': parts[2]})
      .toList();
}

List<Map<String, dynamic>> parseJsonData(String data) {
  final jsonData = jsonDecode(data) as List<dynamic>;
  final List<Map<String, dynamic>> entries = [];
  for (final entry in jsonData) {
    // 检查是否包含必要的字段
    if (!entry.containsKey('label') ||
        !entry.containsKey('phoneNumber') ||
        !entry.containsKey('name')) {
      continue;
    }
    final Map<String, dynamic> mappedEntry = {
      'label': entry['label'],
      'phoneNumber': entry['phoneNumber'],
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
    // 检查是否包含必要的字段
    if (line.isEmpty || line.split(',').length < 3) {
      continue;
    }
    final parts = line.split(',');
    final Map<String, dynamic> mappedEntry = {
      'label': parts[0],
      'phoneNumber': parts[1],
      'name': parts[2],
    };
    entries.add(mappedEntry);
  }
  return entries;
}

List<Map<String, dynamic>> parseYamlData(String data) {
  final yamlData = loadYaml(data) as List<dynamic>;
  final List<Map<String, dynamic>> entries = [];
  for (final entry in yamlData) {
    // 检查是否包含必要的字段
    if (!entry.containsKey('label') ||
        !entry.containsKey('phoneNumber') ||
        !entry.containsKey('name')) {
      continue;
    }
    final Map<String, dynamic> mappedEntry = {
      'label': entry['label'],
      'phoneNumber': entry['phoneNumber'],
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

Future<void> importLabeledNumbersFromUrl(String url) async {
  final entries = await parseFromUrl(url);
  final database = await _initDatabase(); // 获取数据库实例
  await _batchInsert('labels_database.db', entries, database);
}

Future<void> importLabeledNumbersFromLocal(String filePath) async {
  final entries = await parseFromLocal(filePath);
  final database = await _initDatabase(); // 获取数据库实例
  await _batchInsert('labels_database.db', entries, database);
}



Future<void> _batchInsert(String tableName, List<Map<String, dynamic>> entries,
    Database database) async {
  final batch = database.batch();
  for (final entry in entries) {
    batch.insert(tableName, entry);
  }
  await batch.commit();
}
