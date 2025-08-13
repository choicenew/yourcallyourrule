// 数据库服务类，用于管理数据库的初始化和提供数据源访问

import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/data/database/local/local_database_manager.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database_manager.dart';

import '../datasources/local/local_contact_datasource.dart';
import '../datasources/local/local_label_datasource.dart';
import '../datasources/remote/remote_number_datasource.dart';
import 'database_manager.dart';

// 数据库服务类
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  
  // 数据库管理器
  late final LocalDatabaseManager _localDatabaseManager;
  late final RemoteDatabaseManager _remoteDatabaseManager;
  
  // 数据源
  late final LocalContactDataSource localContactDataSource;
  late final LocalLabelDataSource localLabelDataSource;
  late final RemoteNumberDataSource remoteNumberDataSource;
  
  // 表变化监听器
  final Map<String, StreamController<List<Map<String, dynamic>>>> _tableControllers = {};
  
  // 私有构造函数
  DatabaseService._internal() {
    _localDatabaseManager = LocalDatabaseManagerImpl();
    _remoteDatabaseManager = RemoteDatabaseManagerImpl();
    
    // 初始化数据源
    localContactDataSource = LocalContactDataSource(_localDatabaseManager);
    localLabelDataSource = LocalLabelDataSource(_localDatabaseManager);
    remoteNumberDataSource = RemoteNumberDataSource(_remoteDatabaseManager);
  }
  
  // 工厂构造函数
  factory DatabaseService() {
    return _instance;
  }
  
  // 初始化数据库
  Future<void> initialize() async {





    try {
      final instance = DatabaseService._instance;
      // 触发数据库初始化
      await instance._localDatabaseManager.database;
      await instance._remoteDatabaseManager.database;
      debugPrint('数据库初始化完成');
    } catch (e) {
      debugPrint('数据库初始化错误: $e');
      rethrow;
    }
  }
  
  // 关闭数据库
  Future<void> close() async {
    // 关闭所有流控制器
    _tableControllers.forEach((_, controller) => controller.close());
    _tableControllers.clear();
    
    await _localDatabaseManager.close();
    await _remoteDatabaseManager.close();
  }
  
  // 监听表变化
  Stream<List<Map<String, dynamic>>> watchTable(String table) {
    if (!_tableControllers.containsKey(table)) {
      _tableControllers[table] = StreamController<List<Map<String, dynamic>>>.broadcast();
      // 初始化时发送一次数据
      queryAll(table).then((data) {
        if (!_tableControllers[table]!.isClosed) {
          _tableControllers[table]!.add(data);
        }
      });
    }
    return _tableControllers[table]!.stream;
  }
  
  // 通知表监听器
  void _notifyTableListeners(String table) {
    if (_tableControllers.containsKey(table) && !_tableControllers[table]!.isClosed) {
      queryAll(table).then((data) {
        if (!_tableControllers[table]!.isClosed) {
          _tableControllers[table]!.add(data);
        }
      });
    }
  }
  
  // 获取本地数据库管理器
  LocalDatabaseManager get localDatabaseManager => _localDatabaseManager;
  
  // 获取远程数据库管理器
  RemoteDatabaseManager get remoteDatabaseManager => _remoteDatabaseManager;
  
  // 同步远程数据到本地
  Future<bool> syncRemoteToLocal() async {
    try {
      // 获取最后同步时间
      final lastSyncTime = await remoteNumberDataSource.getLastSyncTime();
      
      // 如果有最后同步时间，执行增量同步，否则执行全量同步
      if (lastSyncTime != null) {
        return await remoteNumberDataSource.incrementalSync(lastSyncTime);
      } else {
        return await remoteNumberDataSource.syncData();
      }
    } catch (e) {
      return false;
    }
  }
  
  // 电话号码查询服务方法
  Future<List<Map<String, dynamic>>> queryByPhoneNumber(String table, String phoneNumber) async {
    try {
      if (table == 'remote_numbers') {
        return await _remoteDatabaseManager.queryByPhoneNumber(table, phoneNumber);
      }
      return await _localDatabaseManager.queryByPhoneNumber(table, phoneNumber);
    } catch (e) {
      return [];
    }
  }

  // 检查远程号码
  Future<Map<String, dynamic>?> checkRemoteNumber(String phoneNumber) async {
    try {
      // 查询远程号码
      final remoteNumber = await remoteNumberDataSource.getByPhoneNumber(phoneNumber);
      
      // 如果找到远程号码，返回相关信息
      if (remoteNumber != null) {
        return {
          'name': remoteNumber.name,
          'label': remoteNumber.label,
          'priority': remoteNumber.priority,
          'action': remoteNumber.action,
        };
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }

  // 数据库操作方法
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await _localDatabaseManager.database;
    return await db.query(table);
  }

  Future<Map<String, dynamic>?> queryById(String table, String id) async {
    final db = await _localDatabaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<List<Map<String, dynamic>>> queryWhere(String table, String field, dynamic value) async {
    final db = await _localDatabaseManager.database;
    return await db.query(
      table,
      where: '$field = ?',
      whereArgs: [value],
    );
  }

  Future<List<Map<String, dynamic>>> queryLike(String table, String field, String pattern) async {
    final db = await _localDatabaseManager.database;
    return await db.query(
      table,
      where: '$field LIKE ?',
      whereArgs: ['%$pattern%'],
    );
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await _localDatabaseManager.database;
    final result = await db.insert(table, data);
    _notifyTableListeners(table);
    return result;
  }

  Future<int> update(String table, String id, Map<String, dynamic> data) async {
    final db = await _localDatabaseManager.database;
    final result = await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
    _notifyTableListeners(table);
    return result;
  }

  Future<int> delete(String table, String id) async {
    final db = await _localDatabaseManager.database;
    final result = await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    _notifyTableListeners(table);
    return result;
  }

  // 远程数据库操作方法
  Future<List<Map<String, dynamic>>> queryAllRemote(String table) async {
    final db = await _remoteDatabaseManager.database;
    return await db.query(table);
  }

  Future<Map<String, dynamic>?> queryByIdRemote(String table, String id) async {
    final db = await _remoteDatabaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<List<Map<String, dynamic>>> queryWhereRemote(String table, String field, dynamic value) async {
    final db = await _remoteDatabaseManager.database;
    return await db.query(
      table,
      where: '$field = ?',
      whereArgs: [value],
    );
  }

  Future<List<Map<String, dynamic>>> queryLikeRemote(String table, String field, String pattern) async {
    final db = await _remoteDatabaseManager.database;
    return await db.query(
      table,
      where: '$field LIKE ?',
      whereArgs: ['%$pattern%'],
    );
  }

  Future<int> insertRemote(String table, Map<String, dynamic> data) async {
    final db = await _remoteDatabaseManager.database;
    return await db.insert(table, data);
  }

  Future<int> updateRemote(String table, String id, Map<String, dynamic> data) async {
    final db = await _remoteDatabaseManager.database;
    return await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteRemote(String table, String id) async {
    final db = await _remoteDatabaseManager.database;
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}