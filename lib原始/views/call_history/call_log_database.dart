import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:path/path.dart';
import '../../services/caller_id_service.dart';
import '../../services/caller_id_monitor_service.dart';


class CallLogEntry {
  int? id;
  String? number;
  int? timestamp;
  String? simDisplayName;
  String? callType;
  int? simSlotIndex;
  String? carrierName;
  String? countryIso;
  int? subscriptionId;

  CallLogEntry({
    this.id,
    this.number,
    this.timestamp,
    this.simDisplayName,
    this.callType,
    this.simSlotIndex,
    this.carrierName,
    this.countryIso,
    this.subscriptionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'timestamp': timestamp,
      'simDisplayName': simDisplayName,
      'callType': callType,
      'simSlotIndex': simSlotIndex,
      'carrierName': carrierName,
      'countryIso': countryIso,
      'subscriptionId': subscriptionId,
    };
  }


  factory CallLogEntry.fromMap(Map<String, dynamic> map) {
    return CallLogEntry(
      id: map['id']?.toInt(),
      number: map['number'],
      timestamp: map['timestamp']?.toInt(),
      simDisplayName: map['simDisplayName'],
      callType: map['callType'],
      simSlotIndex: map['simSlotIndex']?.toInt(),
      carrierName: map['carrierName'],
      countryIso: map['countryIso'],
      subscriptionId: map['subscriptionId']?.toInt(),
    );
  }
    factory CallLogEntry.fromDbMap(Map<String, dynamic> map) {
        return CallLogEntry(
            id: map['id'],
            number: map['number'],
            timestamp: map['timestamp'],
            simDisplayName: map['simDisplayName'],
          callType: map['callType'],
          simSlotIndex: map['simSlotIndex'],
          carrierName:map['carrierName'],
          countryIso: map['countryIso'],
          subscriptionId: map['subscriptionId']
        );
    }


  @override
  String toString() {
    return 'CallLogEntry{id: $id, number: $number, timestamp: $timestamp, simDisplayName: $simDisplayName, callType: $callType, simSlotIndex: $simSlotIndex, carrierName: $carrierName, countryIso: $countryIso, subscriptionId: $subscriptionId}';
  }


}


class CallScreeningDatabase {
  static final CallScreeningDatabase instance = CallScreeningDatabase._init();
  static Database? _database;

  CallScreeningDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('call_screening.db');
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
    // Modified call_logs table to only include data available from CallScreeningService
    await db.execute('''
      CREATE TABLE call_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        number TEXT,
        timestamp INTEGER,
        simDisplayName TEXT,
        callType TEXT,
        simSlotIndex INTEGER,
        carrierName TEXT,
        countryIso TEXT,
        subscriptionId INTEGER
      )
    ''');

    // CallerID表保持不变，因为这是自定义的识别数据
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
        count INTEGER
      )
    ''');

    await db.execute('CREATE INDEX idx_timestamp ON call_logs(timestamp)');
  }

  // Modified to use CallScreeningService data
  Future<void> insertCallScreeningEntry(CallData callData) async {
          print("读取库号码: ${callData.simInfo?.phoneNumber}"); // 添加 print 语句
    final db = await database;
    await db.insert(
      'call_logs',
      {
        'number': callData.simInfo?.phoneNumber,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'simDisplayName': callData.simInfo?.displayName,
        'callType': callData.simInfo?.callType,
        'simSlotIndex': callData.simInfo?.simSlotIndex,
        'carrierName': callData.simInfo?.carrierName,
        'countryIso': callData.simInfo?.countryIso,
        'subscriptionId': callData.simInfo?.subscriptionId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get recent call screening logs
Future<List<CallLogEntry>> getRecentLogs() async {   // limit parameter removed
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'call_logs',
    orderBy: 'timestamp DESC', 
  );
  return maps.map(CallLogEntry.fromDbMap).toList();
}

Future<List<CallLogEntry>> getLogsByPhoneNumber(String phoneNumber) async {  //limit parameter removed
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'call_logs',
    where: 'number = ?',
    whereArgs: [phoneNumber],
    orderBy: 'timestamp DESC',
  );
  return maps.map(CallLogEntry.fromDbMap).toList();
}

  // CallerID related methods remain unchanged
  Future<List<CallerIdData>> getAllCallerIdData() async {
    final db = await database;
    final result = await db.query('caller_id');

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

  Future<void> insertCallerIdData(CallerIdData data) async {
    final db = await database;
    await db.insert(
      'caller_id',
      {
        'phoneNumber': data.phoneNumber,
        'countryName': data.countryName,
        'region': data.region,
        'carrier': data.carrier,
        'numberType': data.numberType?.toString(),
        'labels': jsonEncode(data.labels.map((l) => l.toJson()).toList()),
        'name': data.name,
        'avatar': data.avatar,
        'count': data.count ?? 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<CallerIdData?> getCallerIdDataByPhoneNumber(String phoneNumber) async {
    final db = await database;
    final result = await db.query(
      'caller_id',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );

    if (result.isNotEmpty) {
      final map = result.first;
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



  Future<void> close() async {
    final db = await database;
    db.close();
  }
}