// local_regex_rule_data_source.dart (优化版)

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

import '../../../data/models/regex_rule_model.dart';
import '../datasource_interface.dart';

/// 本地正则规则数据源实现 (使用 Drift)
class LocalRegexRuleDataSource implements LocalDataSource<RegexRuleModel> {
  
  // 使用具体的 Drift 数据库实例
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid(); // 使用 Uuid 实例
  
  // 构造函数
  LocalRegexRuleDataSource(this._database);
  
  // --- 辅助方法: 数据转换 ---

  /// 将 Drift 生成的 RegexRuleData (数据库行数据) 转换为 RegexRuleModel
  RegexRuleModel _fromData(RegexRuleData data) {
    return RegexRuleModel(
      // 这里的 id 应该是非空的，但在 fromData 中处理一下 null-safety
      id: data.id ?? const Uuid().v4(), // id 可能为 null，但我们通常保证它存在 
      name: data.name,
      priority: data.priority,
      action: data.action,
      pattern: data.pattern,
      isEnabled: data.isEnabled == 1,
      subscriptionId: data.subscriptionId,
      ruleType: data.ruleType,
    );
  }

  /// 将 RegexRuleModel (应用模型) 转换为 Drift Companion (用于写入数据库)
  /// 注意：这里只负责映射字段，不负责 ID 的生成或修正。
  RegexRulesCompanion _toCompanion(RegexRuleModel model) {
    return RegexRulesCompanion(
      id: Value(model.id),
      name: Value(model.name),
      priority: Value(model.priority),
      action: Value(model.action),
      pattern: Value(model.pattern),
      isEnabled: Value(model.isEnabled ? 1 : 0),
      subscriptionId: Value(model.subscriptionId),
      ruleType: Value(model.ruleType),
    );
  }
  
  // --- 核心 CRUD / 业务逻辑 ---
  
  /// 通用保存/插入逻辑
  Future<String> _save(RegexRuleModel rule) async {
    final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    
    // 1. 创建 Companion
    final companion = _toCompanion(rule);
    
    // 2. 使用 Companion.copyWith 注入生成的 ID
    final companionWithId = companion.copyWith(id: Value(id));

    // 使用 insertOnConflictUpdate 实现 ConflictAlgorithm.replace 的效果
    await _database.into(_database.regexRules).insertOnConflictUpdate(companionWithId);
    
    return id;
  }
  

  // 获取所有正则规则
  @override
  Future<List<RegexRuleModel>> getAll() async {
    final results = await _database.select(_database.regexRules).get();
    return results.map(_fromData).toList();
  }

  // 根据ID获取正则规则
  @override
  Future<RegexRuleModel?> getById(String id) async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1);
      
    final result = await query.getSingleOrNull();

    return result != null ? _fromData(result) : null;
  }

  // 插入单个规则
  @override
  Future<String> insert(RegexRuleModel model) async {
    return _save(model);
  }
  
  // 保存正则规则 (与 insert 逻辑相同，用于兼容接口)
  @override
  Future<String> save(RegexRuleModel rule) async {
    return _save(rule);
  }


  // 更新正则规则
  @override
  Future<int> update(RegexRuleModel rule) async {
    final companion = _toCompanion(rule);
    
    // 针对特定 ID 的记录执行更新
    final updatedRows = await (_database.update(_database.regexRules)
      ..where((tbl) => tbl.id.equals(rule.id)))
      .write(companion);
      
    return updatedRows;
  }
  
  // 删除正则规则
  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.regexRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }
  
  // 批量插入规则
  @override
  Future<List<String>> insertAll(List<RegexRuleModel> models) async {
    final List<String> ids = [];
    
    // 使用 batch 实现高效的批量插入
    await _database.batch((batch) {
      for (final rule in models) {
        final id = rule.id.isEmpty ? _uuid.v4() : rule.id;
        ids.add(id);

        final companion = _toCompanion(rule);
        final companionWithId = companion.copyWith(id: Value(id)); // 使用 Companion.copyWith

        batch.insert(
          _database.regexRules,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }
  
  // 批量保存正则规则 (与 insertAll 逻辑一致，仅名称不同)
  @override
  Future<List<String>> saveAll(List<RegexRuleModel> rules) async {
    return insertAll(rules);
  }


  // 批量更新正则规则
  @override
  Future<int> updateAll(List<RegexRuleModel> rules) async {
    // 使用 batch 进行批量更新
    await _database.batch((batch) {
      for (final rule in rules) {
        batch.update(
          _database.regexRules,
          _toCompanion(rule),
          where: (tbl) => tbl.id.equals(rule.id),
        );
      }
    });

    // 返回尝试更新的记录总数，以保持接口兼容性
    return rules.length;
  }

  // 批量删除正则规则
  @override
  Future<int> deleteAll(List<String> ids) async {
    // 使用 whereIn 优化批量删除
    return await (_database.delete(_database.regexRules)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }
  
  // 清空表 (deleteAllRecords, clear 都是删除所有记录)
  @override
  Future<void> clear() async {
    await _database.delete(_database.regexRules).go();
  }

  // 删除所有正则规则 (实现与 clear 相同)
  Future<int> deleteAllRecords() async {
    return await _database.delete(_database.regexRules).go();
  }

  // 获取正则规则数量
  Future<int> count() async {
    final countExp = _database.regexRules.id.count();
    final query = _database.selectOnly(_database.regexRules)..addColumns([countExp]);
    
    final result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
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
      final List<RegexRuleModel> rules = maps.map((map) => RegexRuleModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      print('导入正则规则数据失败: $e');
      return false;
    }
  }

  // 根据模式获取规则 (pattern 是主键，理论上只有一个)
  Future<RegexRuleModel?> getByPattern(String pattern) async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.pattern.equals(pattern))
      ..limit(1);

    final result = await query.getSingleOrNull();

    return result != null ? _fromData(result) : null;
  }

  // 获取启用的正则规则
  Future<List<RegexRuleModel>> getEnabledRules() async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.isEnabled.equals(1));

    final results = await query.get();
    return results.map(_fromData).toList();
  }

  // 获取禁用的正则规则
  Future<List<RegexRuleModel>> getDisabledRules() async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.isEnabled.equals(0));

    final results = await query.get();
    return results.map(_fromData).toList();
  }

  // 根据优先级获取正则规则
  Future<List<RegexRuleModel>> getByPriority(int priority) async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.priority.equals(priority));

    final results = await query.get();
    return results.map(_fromData).toList();
  }

  // 根据名称搜索正则规则
  Future<List<RegexRuleModel>> searchByName(String name) async {
    final query = _database.select(_database.regexRules)
      ..where((tbl) => tbl.name.like('%$name%'));

    final results = await query.get();
    return results.map(_fromData).toList();
  }
}