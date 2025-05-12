// 本地预定义标签数据源实现类，用于处理本地预定义标签数据的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../core/entities/label/predefined_label_entry.dart';
import '../../../data/models/predefined_label_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

/// 本地预定义标签数据源实现
class LocalPredefinedLabelDataSource implements LocalDataSource<PredefinedLabelModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;
  
  // 表名
  static const String _tableName = 'predefined_labels';
  
  // 构造函数
  LocalPredefinedLabelDataSource(this._databaseManager);
  
  // 获取所有预定义标签
  @override
  Future<List<PredefinedLabelModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    
    return List.generate(maps.length, (i) {
      return PredefinedLabelModel.fromMap(maps[i]);
    });
  }
  
  // 根据ID获取预定义标签
  @override
  Future<PredefinedLabelModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return PredefinedLabelModel.fromMap(maps.first);
    }
    return null;
  }
  
  // 根据文本获取预定义标签
  Future<List<PredefinedLabelModel>> getByText(String text) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'text LIKE ?',
      whereArgs: ['%$text%'],
    );
    
    return List.generate(maps.length, (i) {
      return PredefinedLabelModel.fromMap(maps[i]);
    });
  }
  
  // 插入预定义标签
  @override
  Future<String> insert(PredefinedLabelModel label) async {
    final db = await _databaseManager.database;
    
    // 如果没有ID，生成一个新的UUID
    final String id = label.id.isEmpty ? const Uuid().v4() : label.id;
    final PredefinedLabelModel labelWithId = label.id.isEmpty
        ? PredefinedLabelModel(
            id: id,
            text: label.text,
            avatar: label.avatar,
            icon: label.icon,
          )
        : label;
    
    await db.insert(
      _tableName,
      labelWithId.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    
    return id;
  }
  
  // 更新预定义标签
  @override
  Future<int> update(PredefinedLabelModel label) async {
    final db = await _databaseManager.database;
    
    return await db.update(
      _tableName,
      label.toMap(),
      where: 'id = ?',
      whereArgs: [label.id],
    );
  }
  
  // 删除预定义标签
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 批量插入预定义标签
  @override
  Future<List<String>> insertAll(List<PredefinedLabelModel> labels) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;
    
    await db.transaction((txn) async {
      for (final label in labels) {
        // 如果没有ID，生成一个新的UUID
        final String id = label.id.isEmpty ? const Uuid().v4() : label.id;
        final PredefinedLabelModel labelWithId = label.id.isEmpty
            ? PredefinedLabelModel(
                id: id,
                text: label.text,
                avatar: label.avatar,
                icon: label.icon,
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
  
  // 批量更新预定义标签
  @override
  Future<int> updateAll(List<PredefinedLabelModel> labels) async {
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
  
  // 批量删除预定义标签
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
  
  // 清空所有预定义标签
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }
  
  // 导出预定义标签数据
  @override
  Future<String> exportData() async {
    final labels = await getAll();
    final List<Map<String, dynamic>> labelMaps = labels.map((label) => label.toMap()).toList();
    return jsonEncode(labelMaps);
  }
  
  // 导入预定义标签数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> labelMaps = jsonDecode(data) as List<dynamic>;
      final List<PredefinedLabelModel> labels = labelMaps.map((map) => PredefinedLabelModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 批量插入预定义标签数据
  Future<bool> insertPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    try {
      final labels = predefinedLabels.map((map) => PredefinedLabelModel.fromMap(map)).toList();
      await insertAll(labels);
      return true;
    } catch (e) {
      return false;
    }
  }
}