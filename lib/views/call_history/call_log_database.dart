import 'dart:convert';

import 'package:call_log/call_log.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../services/caller_id_service.dart';

class CallLogDatabase {
  static final CallLogDatabase instance = CallLogDatabase._init();
  static Database? _database;

  CallLogDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('call_logs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // 通话记录表
    await db.execute('''
      CREATE TABLE call_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        number TEXT,
        formattedNumber TEXT,
        callType INTEGER,
        duration INTEGER,
        timestamp INTEGER,
        cachedNumberType INTEGER,
        cachedNumberLabel TEXT,
        simDisplayName TEXT,
        phoneAccountId TEXT,
        simSlotIndex TEXT
      )
    ''');

    // CallerID表 - 保持简单但包含必要字段
    await db.execute('''
      CREATE TABLE caller_id (
        phoneNumber TEXT PRIMARY KEY,
        countryName TEXT,
        region TEXT,
        carrier TEXT,
        numberType TEXT,
        labels TEXT,  
        name TEXT,
        avatar TEXT,
        count INTEGER      -- lastUpdated INTEGER
     
      )
    ''');

    // 创建索引提升查询性能
    await db.execute('CREATE INDEX idx_timestamp ON call_logs(timestamp)');
  }

  // 插入通话记录
  Future<void> insertCallLog(CallLogEntry log) async {
    final db = await database;
    await db.insert(
      'call_logs',
      {
        'name': log.name,
        'number': log.number,
        'formattedNumber': log.formattedNumber,
        'callType': log.callType?.index, // 存储 CallType 的 index 值
        'duration': log.duration,
        'timestamp': log.timestamp,
        'cachedNumberType': log.cachedNumberType,
        'cachedNumberLabel': log.cachedNumberLabel,
        'simDisplayName': log.simDisplayName,
        'phoneAccountId': log.phoneAccountId,
        'simSlotIndex': log.simSlotIndex,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 批量插入通话记录
  Future<void> insertCallLogs(List<CallLogEntry> logs) async {
    final db = await database;
    final batch = db.batch();
    
    for (var log in logs) {
      batch.insert(
        'call_logs',
        {
          'name': log.name,
          'number': log.number,
          'formattedNumber': log.formattedNumber,
          'callType': log.callType?.index, // 存储 CallType 的 index 值
          'duration': log.duration,
          'timestamp': log.timestamp,
          'cachedNumberType': log.cachedNumberType,
          'cachedNumberLabel': log.cachedNumberLabel,
          'simDisplayName': log.simDisplayName,
          'phoneAccountId': log.phoneAccountId,
          'simSlotIndex': log.simSlotIndex,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    
    await batch.commit(noResult: true);
  }






  // 获取最近的通话记录
  Future<List<CallLogEntry>> getRecentLogs({int limit = 100}) async {
    final db = await database;
    final result = await db.query(
      'call_logs',
      orderBy: 'timestamp DESC',
      limit: limit,
    );

    return result.map((map) => CallLogEntry(
      name: map['name'] as String?,
      number: map['number'] as String?,
      formattedNumber: map['formattedNumber'] as String?,
      callType: map['callType'] != null ? CallType.values[map['callType'] as int] : null, // 转换 CallType
      duration: map['duration'] as int?,
      timestamp: map['timestamp'] as int?,
      cachedNumberType: map['cachedNumberType'] as int?,
      cachedNumberLabel: map['cachedNumberLabel'] as String?,
      simDisplayName: map['simDisplayName'] as String?,
      phoneAccountId: map['phoneAccountId'] as String?,
      simSlotIndex: map['simSlotIndex'] as String?,
    )).toList();
  }

  // 根据电话号码获取通话记录
  Future<List<CallLogEntry>> getLogsByPhoneNumber(String phoneNumber, {int limit = 50}) async {
    final db = await database;
    final result = await db.query(
      'call_logs',
      where: 'number = ?',
      whereArgs: [phoneNumber],
      orderBy: 'timestamp DESC',
      limit: limit,
    );

    return result.map((map) => CallLogEntry(
      name: map['name'] as String?,
      number: map['number'] as String?,
      formattedNumber: map['formattedNumber'] as String?,
      callType: map['callType'] != null ? CallType.values[map['callType'] as int] : null, // 转换 CallType
      duration: map['duration'] as int?,
      timestamp: map['timestamp'] as int?,
      cachedNumberType: map['cachedNumberType'] as int?,
      cachedNumberLabel: map['cachedNumberLabel'] as String?,
      simDisplayName: map['simDisplayName'] as String?,
      phoneAccountId: map['phoneAccountId'] as String?,
      simSlotIndex: map['simSlotIndex'] as String?,
    )).toList();
  }

  // 获取所有CallerID数据
  Future<List<CallerIdData>> getAllCallerIdData() async {
    final db = await database;
    final result = await db.query(
      'caller_id',
     // orderBy: 'lastUpdated DESC',
    );

    return result.map((map) => CallerIdData(
      phoneNumber: map['phoneNumber'] as String,
      countryName: map['countryName'] as String,
      region: map['region'] as String?,
      carrier: map['carrier'] as String?,
        numberType: map['numberType'] != null 
            ? PhoneNumberType.values.firstWhere(
                (e) => e.toString() == map['numberType'],
                orElse: () => PhoneNumberType.unknown,
              )
            : null,
      labels: (jsonDecode(map['labels'] as String) as List)
          .map((json) => Label.fromJson(json))
          .toList(),
      name: map['name'] as String,
      avatar: map['avatar'] as String?,
      count: map['count'] as int? ?? 0,

    )).toList();
  }

  // 批量插入CallerID数据
  Future<void> insertCallerIdDataBatch(List<CallerIdData> dataList) async {
    final db = await database;
    final batch = db.batch();
    
    for (var data in dataList) {
      batch.insert(
        'caller_id',
        {
          'phoneNumber': data.phoneNumber,
          'countryName': data.countryName,
          'region': data.region,
          'carrier': data.carrier,
            'numberType': data.numberType?.toString(), // 存储枚举名称
          'labels': jsonEncode(data.labels.map((l) => l.toJson()).toList()),
          'name': data.name,
          'avatar': data.avatar,
          'count': data.count ?? 0,  // 确保提供默认值
         // 'lastUpdated': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    
    await batch.commit(noResult: true);
  }


// 在 CallLogDatabase 中添加
Future<void> insertCallerIdData(CallerIdData data) async {
  print("数据库: ${data.countryName}${data.phoneNumber}"); 
  final db = await database;
  await db.insert(
    'caller_id',
    {
      'phoneNumber': data.phoneNumber,
      'countryName': data.countryName,
      'region': data.region,
      'carrier': data.carrier,
        'numberType': data.numberType?.toString(), // 存储枚举名称
      'labels': jsonEncode(data.labels.map((l) => l.toJson()).toList()),
      'name': data.name,
      'avatar': data.avatar,
     'count': data.count ?? 0,  // 确保提供默认值
     // 'lastUpdated': DateTime.now().millisecondsSinceEpoch,
    },
        
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

  Future<CallerIdData?> getCallerIdDataDatabaseByPhoneNumber(String phoneNumber) async {
    final db = await database;
    final result = await db.query(
      'caller_id',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );

    if (result.isNotEmpty) {

      // 将 fromMap 方法的逻辑直接放在这里
      final phoneNumber = result.first['phoneNumber'] as String;
      print("读取库号码: $phoneNumber"); // 添加 print 语句
  final map = result.first;
      // 将 fromMap 方法的逻辑直接放在这里
    return CallerIdData(
        phoneNumber: map['phoneNumber'] as String,
        countryName: map['countryName'] as String,
        region: map['region'] as String?,
        carrier: map['carrier'] as String?,
        numberType: map['numberType'] != null 
            ? PhoneNumberType.values.firstWhere(
                (e) => e.toString() == map['numberType'],
                orElse: () => PhoneNumberType.unknown,
              )
            : null,
        labels: (jsonDecode(map['labels'] as String) as List)
            .map((json) => Label.fromJson(json))
            .toList(),
        name: map['name'] as String,
        avatar: map['avatar'] as String?,
        count: map['count'] as int?,
      );
    }
    return null;
  }

Future<void> updateCallerIdDataByFields(String phoneNumber, Map<String, dynamic> fieldsToUpdate) async {
  final db = await database;
  await db.update(
    'caller_id',
    fieldsToUpdate,
    where: 'phoneNumber = ?',
    whereArgs: [phoneNumber],
  );
}

  // 清理数据库
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}