// local_phone_rule_data_source.dart (Drift 优化版)

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
// 假设这是 LocalDatabase 的正确导入路径
import 'package:yourcallyourrule/data/database/local/local_database.dart'; 

import '../../../data/models/phone_rule_model.dart';
import '../datasource_interface.dart';

// 本地电话规则数据源实现
class LocalPhoneRuleDataSource implements LocalDataSource<PhoneRuleModel> {
  
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalPhoneRuleDataSource(this._database);

  // --- 辅助方法: 数据转换 ---

  /// 将 Drift 生成的 PhoneRuleData (数据库行数据) 转换为 PhoneRuleModel
  PhoneRuleModel _fromData(PhoneRuleData data) {
    // 确保 ID 非空
    final String id = data.id ?? _uuid.v4(); 
    
    return PhoneRuleModel(
      id: id,
      name: data.name,
      priority: data.priority,
      action: data.action,
      phoneNumber: data.phoneNumber,
      labelId: data.labelId ?? '',
      count: data.count,
      avatar: data.avatar,
      subscriptionId: data.subscriptionId,
      isEnabled: data.isEnabled == 1,
      ruleType: data.ruleType,
    );
  }

  /// 将 PhoneRuleModel (应用模型) 转换为 Drift Companion
  PhoneRulesCompanion _toCompanion(PhoneRuleModel model) {
    return PhoneRulesCompanion(
      id: Value(model.id), // 保持原样，insert/save 会修正
      name: Value(model.name),
      priority: Value(model.priority),
      action: Value(model.action),
      phoneNumber: Value(model.phoneNumber),
      labelId: Value(model.labelId),
      count: Value(model.count),
      avatar: Value(model.avatar),
      subscriptionId: Value(model.subscriptionId),
      isEnabled: Value(model.isEnabled ? 1 : 0),
      ruleType: Value(model.ruleType),
    );
  }
  
  // --- 核心 CRUD / 兼容方法 ---
  
  /// 通用保存/插入逻辑 (使用 Companion.copyWith 注入 ID)
  Future<String> _save(PhoneRuleModel rule) async {
    final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    
    final companion = _toCompanion(rule);
    final companionWithId = companion.copyWith(id: Value(id));

    // 使用 insertOnConflictUpdate 实现 ConflictAlgorithm.replace 的效果
    await _database.into(_database.phoneRules).insertOnConflictUpdate(companionWithId);
    
    return id;
  }
  
  // 获取所有电话规则
  @override
  Future<List<PhoneRuleModel>> getAll() async {
    final results = await _database.select(_database.phoneRules).get();

    // 原始代码中对 ruleType 的判断是冗余的，因为这个 DataSource 只处理 phone_rules 表，
    // 但为了确保兼容性，我们可以依赖 _fromData 即可。
    return results.map(_fromData).toList();
  }
  
  // 插入单个规则
  @override
  Future<String> insert(PhoneRuleModel model) async {
    return _save(model);
  }
  
  // 批量插入规则 (使用 batch 优化)
  @override
  Future<List<String>> insertAll(List<PhoneRuleModel> models) async {
    final List<String> ids = [];
    
    await _database.batch((batch) {
      for (final model in models) {
        final String id = model.id.isEmpty ? _uuid.v4() : model.id;
        ids.add(id);
        
        final companion = _toCompanion(model);
        final companionWithId = companion.copyWith(id: Value(id));

        batch.insert(
          _database.phoneRules,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }
  
  // 清空表
  @override
  Future<void> clear() async {
    await _database.delete(_database.phoneRules).go();
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
      final List<PhoneRuleModel> rules = maps.map((map) => PhoneRuleModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      print('导入电话规则数据失败: $e');
      return false;
    }
  }

  // 根据ID获取电话规则
  @override
  Future<PhoneRuleModel?> getById(String id) async {
    final result = await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1))
      .getSingleOrNull();

    return result != null ? _fromData(result) : null;
  }

  // 保存电话规则 (兼容旧接口)
  Future<String> save(PhoneRuleModel rule) async {
    return _save(rule);
  }

  // 更新电话规则
  @override
  Future<int> update(PhoneRuleModel rule) async {
    final companion = _toCompanion(rule);

    return await (_database.update(_database.phoneRules)
      ..where((tbl) => tbl.id.equals(rule.id)))
      .write(companion);
  }

  // 删除电话规则
  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.phoneRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  // 批量保存电话规则 (与 insertAll 逻辑一致)
  Future<List<String>> saveAll(List<PhoneRuleModel> rules) async {
    return insertAll(rules);
  }

  // 批量更新电话规则 (使用 batch 优化)
  @override
  Future<int> updateAll(List<PhoneRuleModel> rules) async {
    await _database.batch((batch) {
      for (final rule in rules) {
        batch.update(
          _database.phoneRules,
          _toCompanion(rule),
          where: (tbl) => tbl.id.equals(rule.id),
        );
      }
    });
    // 返回尝试更新的记录数
    return rules.length;
  }

  // 批量删除电话规则
  @override
  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    
    return await (_database.delete(_database.phoneRules)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }

  // 删除所有电话规则 (实现与 clear 相同)
  Future<int> deleteAllRecords() async {
       // 直接执行删除操作，并返回被删除的行数
    return await _database.delete(_database.phoneRules).go();
}







 

  // 获取电话规则数量 (使用 count 优化)
  Future<int> count() async {
    final countExp = _database.phoneRules.id.count();
    final query = _database.selectOnly(_database.phoneRules)..addColumns([countExp]);
    
    final result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
  }

  // 根据电话号码获取规则 (phoneNumber 是主键)
  Future<PhoneRuleModel?> getByPhoneNumber(String phoneNumber) async {
    final result = await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))
      ..limit(1))
      .getSingleOrNull();

    return result != null ? _fromData(result) : null;
  }

  // 获取启用的电话规则
  Future<List<PhoneRuleModel>> getEnabledRules() async {
    final results = await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.isEnabled.equals(1)))
      .get();

    return results.map(_fromData).toList();
  }

  // 获取禁用的电话规则
  Future<List<PhoneRuleModel>> getDisabledRules() async {
    final results = await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.isEnabled.equals(0)))
      .get();

    return results.map(_fromData).toList();
  }

  // 根据优先级获取电话规则
  Future<List<PhoneRuleModel>> getByPriority(int priority) async {
    final results = await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.priority.equals(priority)))
      .get();

    return results.map(_fromData).toList();
  }

  // 根据名称搜索电话规则
  Future<List<PhoneRuleModel>> searchByName(String name) async {
    final results = await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.name.like('%$name%')))
      .get();

    return results.map(_fromData).toList();
  }

  // 根据名称前缀搜索电话规则（用于订阅规则管理）
  Future<List<PhoneRuleModel>> searchByNamePrefix(String prefix) async {
    final results = await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.name.like('$prefix%')))
      .get();

    return results.map(_fromData).toList();
  }

  // 获取所有已订阅的规则 (假设 subscriptionId 非空即为订阅规则)
  Future<List<PhoneRuleModel>> getSubscribedRules() async {
    final results = await (_database.select(_database.phoneRules)
      ..where((tbl) => tbl.subscriptionId.isNotNull()))
      .get();

    return results.map(_fromData).toList();
  }
}