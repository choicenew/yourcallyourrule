// 本地标签数据源实现类，用于处理本地标签数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../models/label_phone_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

// 本地标签数据源实现
class LocalLabelDataSource implements LocalDataSource<LabelModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;
  
  // 表名
  static const String _tableName = 'labels';
  
  // 构造函数
  LocalLabelDataSource(this._databaseManager);
  
  // 获取所有标签
  @override
  Future<List<LabelModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    
    return List.generate(maps.length, (i) {
      return LabelModel.fromMap(maps[i]);
    });
  }
  
  // 根据ID获取标签
  @override
  Future<LabelModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return LabelModel.fromMap(maps.first);
    }
    return null;
  }
  
  // 根据电话号码获取标签
  Future<List<LabelModel>> getByPhoneNumber(String phoneNumber) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
    
    return List.generate(maps.length, (i) {
      return LabelModel.fromMap(maps[i]);
    });
  }
  
  // 插入标签
  @override
  Future<String> insert(LabelModel label) async {
    final db = await _databaseManager.database;
    
    // 如果没有ID，生成一个新的UUID
    final String id = label.id.isEmpty ? const Uuid().v4() : label.id;
    final LabelModel labelWithId = label.id.isEmpty
        ? LabelModel(
            id: id,
            name: label.name,
            icon: label.icon,
            phoneNumber: label.phoneNumber,
            labelId: label.labelId,
            avatar: label.avatar,
            priority: label.priority,
            action: label.action,
            isEnabled: label.isEnabled,
          )
        : label;
    
    await db.insert(
      _tableName,
      labelWithId.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
    return id;
  }
  
  // 更新标签
  @override
  Future<int> update(LabelModel label) async {
    final db = await _databaseManager.database;
    
    return await db.update(
      _tableName,
      label.toMap(),
      where: 'id = ?',
      whereArgs: [label.id],
    );
  }
  
  // 删除标签
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 批量插入标签
  @override
  Future<List<String>> insertAll(List<LabelModel> labels) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final label in labels) {
        // 如果没有ID，生成一个新的UUID
        final String id = label.id.isEmpty ? const Uuid().v4() : label.id;
        final LabelModel labelWithId = label.id.isEmpty
            ? LabelModel(
                id: id,
                name: label.name,
                icon: label.icon,
                phoneNumber: label.phoneNumber,
                labelId: label.labelId,
                avatar: label.avatar,
                priority: label.priority,
                action: label.action,
                isEnabled: label.isEnabled,
              )
            : label;
        
        await txn.insert(
          _tableName,
          labelWithId.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        
        ids.add(id);
      }
    });
    
    return ids;
  }
  
  // 批量更新标签
  @override
  Future<int> updateAll(List<LabelModel> labels) async {
    int count = 0;
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final label in labels) {
        final int updated = await txn.update(
          _tableName,
          label.toMap(),
          where: 'id = ?',
          whereArgs: [label.id],
        );
        
        count += updated;
      }
    });
    
    return count;
  }
  
  // 批量删除标签
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
  
  // 清空所有标签
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }
  
  // 导出标签数据
  @override
  Future<String> exportData() async {
    final labels = await getAll();
    final List<Map<String, dynamic>> labelMaps = labels.map((label) => label.toMap()).toList();
    return jsonEncode(labelMaps);
  }
  
  // 导入标签数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> labelMaps = jsonDecode(data) as List<dynamic>;
      final List<LabelModel> labels = labelMaps.map((map) => LabelModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 根据标签文本内容查询标签
  Future<List<LabelModel>> getByLabelText(String labelText) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'label = ?',
      whereArgs: [labelText],
    );
    
    return List.generate(maps.length, (i) {
      return LabelModel.fromMap(maps[i]);
    });
  }
  
  // 根据优先级查询标签
  Future<List<LabelModel>> getByPriority(int priority) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'priority = ?',
      whereArgs: [priority],
    );
    
    return List.generate(maps.length, (i) {
      return LabelModel.fromMap(maps[i]);
    });
  }
  
  // 根据动作查询标签
  Future<List<LabelModel>> getByAction(String action) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'action = ?',
      whereArgs: [action],
    );
    
    return List.generate(maps.length, (i) {
      return LabelModel.fromMap(maps[i]);
    });
  }
}