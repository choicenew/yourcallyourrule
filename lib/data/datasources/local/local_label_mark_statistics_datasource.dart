// 本地标记统计数据源实现类，用于处理本地标记统计数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../models/label_mark_statistics_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地标记统计数据源实现
class LocalLabelMarkStatisticsDataSource implements LocalDataSource<LabelMarkRecordModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;
  
  // 表名
  static const String _markTableName = 'label_mark_statistics';
  static const String _countTableName = 'user_mark_count';
  
  // UUID生成器
  final Uuid _uuid = Uuid();
  
  // 标记计数流控制器
  final StreamController<int> _markCountController = StreamController<int>.broadcast();
  
  // 构造函数
  LocalLabelMarkStatisticsDataSource(this._databaseManager);
  
  // 获取标记流
  Stream<int> get markCountStream => _markCountController.stream;
  
  // 记录标记
  Future<bool> recordMark(String phoneNumber, String labelId) async {
    // 检查标签ID是否为"unknown"
    if (labelId.toLowerCase() == 'unknown') {
      return false; // 不记录未知标签
    }
    
    final db = await _databaseManager.database;
    
    // 检查该号码是否已被标记过
    final existingMarks = await db.query(
      _markTableName,
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
    );
    
    // 如果该号码已被标记过，则不再记录
    if (existingMarks.isNotEmpty) {
      return false;
    }
    
    // 记录新的标记
    final markId = _uuid.v4();
    await db.insert(_markTableName, {
      'id': markId,
      'phone_number': phoneNumber,
      'label_id': labelId,
      'marked_at': DateTime.now().toIso8601String(),
      'is_counted': 1
    });
    
    // 更新用户标记计数
    await _incrementMarkCount();
    return true;
  }
  
  // 增加标记计数
  Future<void> _incrementMarkCount() async {
    final db = await _databaseManager.database;
    
    // 获取当前计数
    final countRecords = await db.query(_countTableName, where: 'id = ?', whereArgs: ['user_mark_count']);
    if (countRecords.isEmpty) {
      return;
    }
    
    final currentCount = countRecords.first['total_count'] as int;
    final newCount = currentCount + 1;
    
    // 更新计数
    await db.update(
      _countTableName,
      {
        'total_count': newCount,
        'last_updated': DateTime.now().toIso8601String()
      },
      where: 'id = ?',
      whereArgs: ['user_mark_count']
    );
    
    // 通知监听器
    _markCountController.add(newCount);
  }
  
  // 获取当前标记计数
  Future<int> getMarkCount() async {
    final db = await _databaseManager.database;
    
    final countRecords = await db.query(_countTableName, where: 'id = ?', whereArgs: ['user_mark_count']);
    if (countRecords.isEmpty) {
      return 0;
    }
    
    return countRecords.first['total_count'] as int;
  }
  
  // 重置标记计数
  Future<void> resetMarkCount() async {
    final db = await _databaseManager.database;
    
    await db.update(
      _countTableName,
      {
        'total_count': 0,
        'last_updated': DateTime.now().toIso8601String()
      },
      where: 'id = ?',
      whereArgs: ['user_mark_count']
    );
    
    // 通知监听器
    _markCountController.add(0);
  }
  
  // 获取所有标记记录
  @override
  Future<List<LabelMarkRecordModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_markTableName);
    
    return List.generate(maps.length, (i) {
      return LabelMarkRecordModel.fromMap(maps[i]);
    });
  }

  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_markTableName);
    await db.delete(_countTableName);
  }

  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    return await db.delete(_markTableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    final db = await _databaseManager.database;
    int count = 0;
    await db.transaction((txn) async {
      for (final id in ids) {
        count += await txn.delete(_markTableName, where: 'id = ?', whereArgs: [id]);
      }
    });
    return count;
  }

  @override
  Future<String> exportData() async {
    final marks = await getAll();
    final List<Map<String, dynamic>> markMaps = marks.map((mark) => mark.toMap()).toList();
    return jsonEncode(markMaps);
  }

  @override
  Future<LabelMarkRecordModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _markTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return LabelMarkRecordModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> markMaps = jsonDecode(data) as List<dynamic>;
      final List<LabelMarkRecordModel> marks = markMaps.map((map) => LabelMarkRecordModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(marks);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> insert(LabelMarkRecordModel item) async {
    final db = await _databaseManager.database;
    final id = item.id.isEmpty ? _uuid.v4() : item.id;
    final newItem = LabelMarkRecordModel(
      id: id,
      phoneNumber: item.phoneNumber,
      labelId: item.labelId,
      markedAt: item.markedAt,
      isCounted: item.isCounted,
    );
    await db.insert(_markTableName, newItem.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  @override
  Future<List<String>> insertAll(List<LabelMarkRecordModel> items) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      for (final item in items) {
        final id = item.id.isEmpty ? _uuid.v4() : item.id;
        final newItem = LabelMarkRecordModel(
          id: id,
          phoneNumber: item.phoneNumber,
          labelId: item.labelId,
          markedAt: item.markedAt,
          isCounted: item.isCounted,
        );
        await txn.insert(_markTableName, newItem.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
        ids.add(id);
      }
    });
    return ids;
  }

  @override
  Future<int> update(LabelMarkRecordModel item) async {
    final db = await _databaseManager.database;
    return await db.update(
      _markTableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> updateAll(List<LabelMarkRecordModel> items) async {
    int count = 0;
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      for (final item in items) {
        count += await txn.update(
          _markTableName,
          item.toMap(),
          where: 'id = ?',
          whereArgs: [item.id],
        );
      }
    });
    return count;
  }
  
  // 释放资源
  void dispose() {
    _markCountController.close();
  }
}