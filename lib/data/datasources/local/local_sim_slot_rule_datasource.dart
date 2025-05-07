// SIM卡槽位规则本地数据源，用于处理SIM卡槽位规则的CRUD操作

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/sim_slot_rule_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';

/// SIM卡槽位规则本地数据源
/// 用于处理SIM卡槽位规则的CRUD操作
class LocalSimSlotRuleDataSource implements LocalDataSource<SimSlotRuleModel> {
  // 数据库管理器
  final LocalDatabaseManager _databaseManager;
  
  // 表名
  static const String _tableName = 'sim_slot_rules';
  
  // 构造函数
  LocalSimSlotRuleDataSource(this._databaseManager);
  
  // 获取所有SIM卡槽位规则
  @override
  Future<List<SimSlotRuleModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    
    return List.generate(maps.length, (i) {
      return SimSlotRuleModel.fromMap(maps[i]);
    });
  }
  
  // 根据ID获取SIM卡槽位规则
  @override
  Future<SimSlotRuleModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    if (maps.isEmpty) {
      return null;
    }
    
    return SimSlotRuleModel.fromMap(maps.first);
  }
  
  // 插入SIM卡槽位规则
  @override
  Future<String> insert(SimSlotRuleModel model) async {
    final db = await _databaseManager.database;
    await db.insert(
      _tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return model.id;
  }
  
  // 保存SIM卡槽位规则（兼容旧接口）
  Future<void> save(SimSlotRuleModel model) async {
    await insert(model);
  }
  
  // 更新SIM卡槽位规则
  @override
  Future<int> update(SimSlotRuleModel model) async {
    final db = await _databaseManager.database;
    return await db.update(
      _tableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }
  
  // 删除SIM卡槽位规则
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // 根据SIM卡槽位索引获取规则
  Future<List<SimSlotRuleModel>> getBySimSlotIndex(int simSlotIndex) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'simSlotIndex = ?',
      whereArgs: [simSlotIndex],
    );
    
    return List.generate(maps.length, (i) {
      return SimSlotRuleModel.fromMap(maps[i]);
    });
  }
  
  // 根据电话号码获取规则
  Future<List<SimSlotRuleModel>> getByPhoneNumber(String phoneNumber) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
    
    return List.generate(maps.length, (i) {
      return SimSlotRuleModel.fromMap(maps[i]);
    });
  }
  
  // 清空所有SIM卡槽位规则
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);
  }
  
  // 兼容旧接口
  Future<void> clearAll() async {
    await clear();
  }
  
  // 批量插入数据
  @override
  Future<List<String>> insertAll(List<SimSlotRuleModel> items) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      for (var item in items) {
        await txn.insert(
          _tableName,
          item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        ids.add(item.id);
      }
    });
    return ids;
  }
  
  // 批量更新数据
  @override
  Future<int> updateAll(List<SimSlotRuleModel> items) async {
    int count = 0;
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      for (var item in items) {
        count += await txn.update(
          _tableName,
          item.toMap(),
          where: 'id = ?',
          whereArgs: [item.id],
        );
      }
    });
    return count;
  }
  
  // 批量删除数据
  @override
  Future<int> deleteAll(List<String> ids) async {
    int count = 0;
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      for (var id in ids) {
        count += await txn.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );
      }
    });
    return count;
  }
  
  // 导出数据
  @override
  Future<String> exportData() async {
    final rules = await getAll();
    final List<Map<String, dynamic>> maps = rules.map((rule) => rule.toMap()).toList();
    return jsonEncode(maps);
  }
  
  // 导入数据
  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data);
      final List<SimSlotRuleModel> rules = maps.map((map) => SimSlotRuleModel.fromMap(map)).toList();
      await clear();
      await insertAll(rules);
      return true;
    } catch (e) {
      return false;
    }
  }
}