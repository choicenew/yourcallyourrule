// 本地通话记录数据源实现类，用于处理本地通话记录数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/call_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地通话记录数据源实现
class LocalCallDataSource implements LocalDataSource<CallModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;
  
  // 表名
  static const String _tableName = 'calls';
  
  // 构造函数
  LocalCallDataSource(this._databaseManager);
  
  // 获取所有通话记录
  @override
  Future<List<CallModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    
    return List.generate(maps.length, (i) {
      return CallModel.fromMap(maps[i]);
    });
  }
  
  // 根据ID获取通话记录
  @override
  Future<CallModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return CallModel.fromMap(maps.first);
    }
    return null;
  }
  
  // 根据电话号码获取通话记录
  Future<List<CallModel>> getByPhoneNumber(String phoneNumber) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
    
    return List.generate(maps.length, (i) {
      return CallModel.fromMap(maps[i]);
    });
  }
  
  // 插入通话记录
  @override
  Future<String> insert(CallModel call) async {
    final db = await _databaseManager.database;
    
    // 如果没有ID，生成一个新的UUID
    final String id = call.id.isEmpty ? const Uuid().v4() : call.id;
    final CallModel callWithId = call.id.isEmpty
        ? CallModel(
            id: id,
            phoneNumber: call.phoneNumber,
            contactName: call.contactName,
            callType: call.callType,
            startTime: call.startTime,
            endTime: call.endTime,
            duration: call.duration,
            isRead: call.isRead,
            simInfo: call.simInfo,
            note: call.note,
            isMarked: call.isMarked,
            labelIds: call.labelIds,
          )
        : call;
    
    // 将labelIds列表转换为JSON字符串
    final Map<String, dynamic> callMap = callWithId.toMap();
    if (callWithId.labelIds != null) {
      callMap['labelIds'] = jsonEncode(callWithId.labelIds);
    }
    
    await db.insert(
      _tableName,
      callMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
    return id;
  }
  
  // 更新通话记录
  @override
  Future<int> update(CallModel call) async {
    final db = await _databaseManager.database;
    
    // 将labelIds列表转换为JSON字符串
    final Map<String, dynamic> callMap = call.toMap();
    if (call.labelIds != null) {
      callMap['labelIds'] = jsonEncode(call.labelIds);
    }
    
    return await db.update(
      _tableName,
      callMap,
      where: 'id = ?',
      whereArgs: [call.id],
    );
  }
  
  // 删除通话记录
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 批量插入通话记录
  @override
  Future<List<String>> insertAll(List<CallModel> calls) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final call in calls) {
        // 如果没有ID，生成一个新的UUID
        final String id = call.id.isEmpty ? const Uuid().v4() : call.id;
        final CallModel callWithId = call.id.isEmpty
            ? CallModel(
                id: id,
                phoneNumber: call.phoneNumber,
                contactName: call.contactName,
                callType: call.callType,
                startTime: call.startTime,
                endTime: call.endTime,
                duration: call.duration,
                isRead: call.isRead,
                simInfo: call.simInfo,
                note: call.note,
                isMarked: call.isMarked,
                labelIds: call.labelIds,
              )
            : call;
        
        // 将labelIds列表转换为JSON字符串
        final Map<String, dynamic> callMap = callWithId.toMap();
        if (callWithId.labelIds != null) {
          callMap['labelIds'] = jsonEncode(callWithId.labelIds);
        }
        
        await txn.insert(
          _tableName,
          callMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        
        ids.add(id);
      }
    });
    
    return ids;
  }
  
  // 批量更新通话记录
  @override
  Future<int> updateAll(List<CallModel> calls) async {
    int count = 0;
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final call in calls) {
        // 将labelIds列表转换为JSON字符串
        final Map<String, dynamic> callMap = call.toMap();
        if (call.labelIds != null) {
          callMap['labelIds'] = jsonEncode(call.labelIds);
        }
        
        final int updated = await txn.update(
          _tableName,
          callMap,
          where: 'id = ?',
          whereArgs: [call.id],
        );
        
        count += updated;
      }
    });
    
    return count;
  }
  
  // 批量删除通话记录
  @override
  Future<int> deleteAll(List<String> ids) async {
    int count = 0;
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final id in ids) {
        final int deleted = await txn.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );
        
        count += deleted;
      }
    });
    
    return count;
  }
  
  // 清空所有通话记录
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }
  
  // 导出通话记录数据
  @override
  Future<String> exportData() async {
    final calls = await getAll();
    final List<Map<String, dynamic>> callMaps = calls.map((call) => call.toMap()).toList();
    return jsonEncode(callMaps);
  }
  
  // 导入通话记录数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> callMaps = jsonDecode(data) as List<dynamic>;
      final List<CallModel> calls = callMaps.map((map) => CallModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(calls);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 根据通话类型获取通话记录
  Future<List<CallModel>> getByCallType(String callType) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'callType = ?',
      whereArgs: [callType],
    );
    
    return List.generate(maps.length, (i) {
      return CallModel.fromMap(maps[i]);
    });
  }
  
  // 获取未读通话记录
  Future<List<CallModel>> getUnreadCalls() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isRead = ?',
      whereArgs: [0],
    );
    
    return List.generate(maps.length, (i) {
      return CallModel.fromMap(maps[i]);
    });
  }
  
  // 标记通话记录为已读
  Future<int> markAsRead(String id) async {
    final db = await _databaseManager.database;
    
    return await db.update(
      _tableName,
      {'isRead': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 获取标记的通话记录
  Future<List<CallModel>> getMarkedCalls() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isMarked = ?',
      whereArgs: [1],
    );
    
    return List.generate(maps.length, (i) {
      return CallModel.fromMap(maps[i]);
    });
  }
}