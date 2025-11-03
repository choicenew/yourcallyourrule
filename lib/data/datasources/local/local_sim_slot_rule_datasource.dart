// local_sim_slot_rule_data_source.dart (最终优化版)

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

import '../../../data/models/sim_slot_rule_model.dart';
import '../datasource_interface.dart';

/// SIM卡槽位规则本地数据源 (使用 Drift)
class LocalSimSlotRuleDataSource implements LocalDataSource<SimSlotRuleModel> {
  
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();
  
  // 构造函数
  LocalSimSlotRuleDataSource(this._database);
  
  // --- 辅助方法: 数据转换 ---

  /// 将 Drift 生成的 SimSlotRuleData (数据库行数据) 转换为 SimSlotRuleModel
  SimSlotRuleModel _fromData(SimSlotRuleData data) {
    return SimSlotRuleModel(
      // 修正：增加防御性检查，确保 ID 非空
      id: data.id ?? _uuid.v4(),
      name: data.name,
      priority: data.priority,
      action: data.action,
      ruleType: data.ruleType,
      phoneNumber: data.phoneNumber,
      simSlotIndex: data.simSlotIndex,
      labelId: data.labelId,
      avatar: data.avatar,
      isEnabled: data.isEnabled == 1,
    );
  }

  /// 将 SimSlotRuleModel (应用模型) 转换为 Drift Companion (用于写入数据库)
  SimSlotRulesCompanion _toCompanion(SimSlotRuleModel model) {
    // 注意：这里只映射字段，ID 的修正留给 insert/insertAll 处理
    return SimSlotRulesCompanion(
      id: Value(model.id),
      name: Value(model.name),
      priority: Value(model.priority),
      action: Value(model.action),
      ruleType: Value(model.ruleType),
      phoneNumber: Value(model.phoneNumber),
      simSlotIndex: Value(model.simSlotIndex),
      labelId: Value(model.labelId),
      avatar: Value(model.avatar),
      isEnabled: Value(model.isEnabled ? 1 : 0),
    );
  }
  
  // --- 核心 CRUD / 业务逻辑 ---
  
  // 获取所有SIM卡槽位规则
  @override
  Future<List<SimSlotRuleModel>> getAll() async {
    final results = await _database.select(_database.simSlotRules).get();
    return results.map(_fromData).toList();
  }
  
  // 根据ID获取SIM卡槽位规则
  @override
  Future<SimSlotRuleModel?> getById(String id) async {
    final result = await (_database.select(_database.simSlotRules)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();
    
    return result != null ? _fromData(result) : null;
  }
  
  // 插入SIM卡槽位规则 (使用 Companion.copyWith 注入 ID)
  @override
  Future<String> insert(SimSlotRuleModel model) async {
    final String id = model.id.isEmpty ? _uuid.v4() : model.id;
    
    final companion = _toCompanion(model);
    final companionWithId = companion.copyWith(id: Value(id));
    
    // 使用 insertOnConflictUpdate 实现 ConflictAlgorithm.replace
    await _database.into(_database.simSlotRules).insertOnConflictUpdate(companionWithId);
    
    return id;
  }
  
  // 保存SIM卡槽位规则（兼容旧接口）
  Future<void> save(SimSlotRuleModel model) async {
    await insert(model);
  }
  
  // 更新SIM卡槽位规则
  @override
  Future<int> update(SimSlotRuleModel model) async {
    final companion = _toCompanion(model);
    
    return await (_database.update(_database.simSlotRules)
      ..where((tbl) => tbl.id.equals(model.id)))
      .write(companion);
  }
  
  // 删除SIM卡槽位规则
  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.simSlotRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  // 根据SIM卡槽位索引获取规则
  Future<List<SimSlotRuleModel>> getBySimSlotIndex(int simSlotIndex) async {
    final query = _database.select(_database.simSlotRules)
      ..where((tbl) => tbl.simSlotIndex.equals(simSlotIndex));
      
    final results = await query.get();
    
    return results.map(_fromData).toList();
  }
  
  // 根据电话号码获取规则
  Future<List<SimSlotRuleModel>> getByPhoneNumber(String phoneNumber) async {
    final query = _database.select(_database.simSlotRules)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
      
    final results = await query.get();
    
    return results.map(_fromData).toList();
  }
  
  // 清空所有SIM卡槽位规则 (clear 和 clearAll 保持一致)
  @override
  Future<void> clear() async {
    await _database.delete(_database.simSlotRules).go();
  }
  
  // 兼容旧接口
  Future<void> clearAll() async {
    await clear();
  }
  
  // 批量插入数据
  @override
  Future<List<String>> insertAll(List<SimSlotRuleModel> items) async {
    final List<String> ids = [];
    
    await _database.batch((batch) {
      for (var item in items) {
        final String id = item.id.isEmpty ? _uuid.v4() : item.id;
        ids.add(id);
        
        final companion = _toCompanion(item);
        final companionWithId = companion.copyWith(id: Value(id)); // 使用 Companion.copyWith

        batch.insert(
          _database.simSlotRules,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }
  
  // 批量更新数据
  @override
  Future<int> updateAll(List<SimSlotRuleModel> items) async {
    await _database.batch((batch) {
      for (var item in items) {
        batch.update(
          _database.simSlotRules,
          _toCompanion(item),
          where: (tbl) => tbl.id.equals(item.id),
        );
      }
    });
    
    return items.length;
  }
  
  // 批量删除数据
  @override
  Future<int> deleteAll(List<String> ids) async {
    return await (_database.delete(_database.simSlotRules)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
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
      final List<dynamic> maps = jsonDecode(data) as List<dynamic>;
      final List<SimSlotRuleModel> rules = maps.map((map) => SimSlotRuleModel.fromMap(map as Map<String, dynamic>)).toList();
      
      await clear(); 
      await insertAll(rules);
      return true;
    } catch (e) {
      // 错误处理，例如日志记录
      return false;
    }
  }
}