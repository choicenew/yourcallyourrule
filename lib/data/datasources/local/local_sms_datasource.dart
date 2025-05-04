// 本地短信数据源实现类，用于处理本地短信数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/sms_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地短信数据源实现
class LocalSmsDataSource implements LocalDataSource<SmsModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;
  
  // 表名
  static const String _tableName = 'sms';
  
  // 构造函数
  LocalSmsDataSource(this._databaseManager);
  
  // 获取所有短信
  @override
  Future<List<SmsModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    
    return List.generate(maps.length, (i) {
      return SmsModel.fromMap(maps[i]);
    });
  }
  
  // 根据ID获取短信
  @override
  Future<SmsModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return SmsModel.fromMap(maps.first);
    }
    return null;
  }
  
  // 根据电话号码获取短信
  Future<List<SmsModel>> getByPhoneNumber(String phoneNumber) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
    
    return List.generate(maps.length, (i) {
      return SmsModel.fromMap(maps[i]);
    });
  }
  
  // 插入短信
  @override
  Future<String> insert(SmsModel sms) async {
    final db = await _databaseManager.database;
    
    // 如果没有ID，生成一个新的UUID
    final String id = sms.id.isEmpty ? const Uuid().v4() : sms.id;
    final SmsModel smsWithId = sms.id.isEmpty
        ? SmsModel(
            id: id,
            phoneNumber: sms.phoneNumber,
            contactName: sms.contactName,
            messageType: sms.messageType,
            content: sms.content,
            timestamp: sms.timestamp,
            isRead: sms.isRead,
            simInfo: sms.simInfo,
            isMarked: sms.isMarked,
            labelIds: sms.labelIds,
          )
        : sms;
    
    // 将labelIds列表转换为JSON字符串
    final Map<String, dynamic> smsMap = smsWithId.toMap();
    if (smsWithId.labelIds != null) {
      smsMap['labelIds'] = jsonEncode(smsWithId.labelIds);
    }
    
    await db.insert(
      _tableName,
      smsMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
    return id;
  }
  
  // 更新短信
  @override
  Future<int> update(SmsModel sms) async {
    final db = await _databaseManager.database;
    
    // 将labelIds列表转换为JSON字符串
    final Map<String, dynamic> smsMap = sms.toMap();
    if (sms.labelIds != null) {
      smsMap['labelIds'] = jsonEncode(sms.labelIds);
    }
    
    return await db.update(
      _tableName,
      smsMap,
      where: 'id = ?',
      whereArgs: [sms.id],
    );
  }
  
  // 删除短信
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 批量插入短信
  @override
  Future<List<String>> insertAll(List<SmsModel> smsList) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final sms in smsList) {
        // 如果没有ID，生成一个新的UUID
        final String id = sms.id.isEmpty ? const Uuid().v4() : sms.id;
        final SmsModel smsWithId = sms.id.isEmpty
            ? SmsModel(
                id: id,
                phoneNumber: sms.phoneNumber,
                contactName: sms.contactName,
                messageType: sms.messageType,
                content: sms.content,
                timestamp: sms.timestamp,
                isRead: sms.isRead,
                simInfo: sms.simInfo,
                isMarked: sms.isMarked,
                labelIds: sms.labelIds,
              )
            : sms;
        
        // 将labelIds列表转换为JSON字符串
        final Map<String, dynamic> smsMap = smsWithId.toMap();
        if (smsWithId.labelIds != null) {
          smsMap['labelIds'] = jsonEncode(smsWithId.labelIds);
        }
        
        await txn.insert(
          _tableName,
          smsMap,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        
        ids.add(id);
      }
    });
    
    return ids;
  }
  
  // 批量更新短信
  @override
  Future<int> updateAll(List<SmsModel> smsList) async {
    int count = 0;
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final sms in smsList) {
        // 将labelIds列表转换为JSON字符串
        final Map<String, dynamic> smsMap = sms.toMap();
        if (sms.labelIds != null) {
          smsMap['labelIds'] = jsonEncode(sms.labelIds);
        }
        
        final int updated = await txn.update(
          _tableName,
          smsMap,
          where: 'id = ?',
          whereArgs: [sms.id],
        );
        
        count += updated;
      }
    });
    
    return count;
  }
  
  // 批量删除短信
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
  
  // 清空所有短信
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }
  
  // 导出短信数据
  @override
  Future<String> exportData() async {
    final smsList = await getAll();
    final List<Map<String, dynamic>> smsMaps = smsList.map((sms) => sms.toMap()).toList();
    return jsonEncode(smsMaps);
  }
  
  // 导入短信数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> smsMaps = jsonDecode(data) as List<dynamic>;
      final List<SmsModel> smsList = smsMaps.map((map) => SmsModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(smsList);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 根据短信类型获取短信
  Future<List<SmsModel>> getByMessageType(String messageType) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'messageType = ?',
      whereArgs: [messageType],
    );
    
    return List.generate(maps.length, (i) {
      return SmsModel.fromMap(maps[i]);
    });
  }
  
  // 获取未读短信
  Future<List<SmsModel>> getUnreadSms() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isRead = ?',
      whereArgs: [0],
    );
    
    return List.generate(maps.length, (i) {
      return SmsModel.fromMap(maps[i]);
    });
  }
  
  // 标记短信为已读
  Future<int> markAsRead(String id) async {
    final db = await _databaseManager.database;
    
    return await db.update(
      _tableName,
      {'isRead': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 获取标记的短信
  Future<List<SmsModel>> getMarkedSms() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'isMarked = ?',
      whereArgs: [1],
    );
    
    return List.generate(maps.length, (i) {
      return SmsModel.fromMap(maps[i]);
    });
  }
  
  // 根据内容搜索短信
  Future<List<SmsModel>> searchByContent(String keyword) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'content LIKE ?',
      whereArgs: ['%$keyword%'],
    );
    
    return List.generate(maps.length, (i) {
      return SmsModel.fromMap(maps[i]);
    });
  }
}