// 本地标记统计数据源实现类，用于处理本地标记统计数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../models/label_mark_statistics_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地标记统计数据源实现
class LocalLabelMarkStatisticsDataSource {
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
  LocalLabelMarkStatisticsDataSource(this._databaseManager) {
    _initDatabase();
  }
  
  // 初始化数据库
  Future<void> _initDatabase() async {
    final db = await _databaseManager.database;
    
    // 创建标记统计表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_markTableName (
        id TEXT PRIMARY KEY,
        phone_number TEXT NOT NULL,
        label_id TEXT NOT NULL,
        marked_at TEXT NOT NULL,
        is_counted INTEGER NOT NULL DEFAULT 1
      )
    ''');
    
    // 创建用户标记计数表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_countTableName (
        id TEXT PRIMARY KEY,
        total_count INTEGER NOT NULL DEFAULT 0,
        last_updated TEXT NOT NULL
      )
    ''');
    
    // 初始化用户标记计数
    final countRecords = await db.query(_countTableName);
    if (countRecords.isEmpty) {
      await db.insert(_countTableName, {
        'id': 'user_mark_count',
        'total_count': 0,
        'last_updated': DateTime.now().toIso8601String()
      });
    }
  }
  
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
  Future<List<LabelMarkRecordModel>> getAllMarks() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_markTableName);
    
    return List.generate(maps.length, (i) {
      return LabelMarkRecordModel.fromMap(maps[i]);
    });
  }
  
  // 释放资源
  void dispose() {
    _markCountController.close();
  }
}