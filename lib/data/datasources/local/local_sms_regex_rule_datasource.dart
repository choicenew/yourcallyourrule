// local_sms_regex_rule_data_source.dart (Drift 优化版)

import 'dart:async';
import 'dart:convert';
import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

import '../../../data/models/sms_regex_rule_model.dart';
import '../datasource_interface.dart';

class LocalSmsRegexRuleDataSource implements LocalDataSource<SmsRegexRuleModel> {
  
  final LocalDatabase _database;
  final Uuid _uuid = const Uuid();

  LocalSmsRegexRuleDataSource(this._database);

  // --- 辅助方法: 数据转换 ---

  /// 将 Drift 生成的 SmsRuleData (数据库行数据) 转换为 SmsRegexRuleModel
  SmsRegexRuleModel _fromData(SmsRuleData data) {
    return SmsRegexRuleModel(
      // 修正：增加防御性检查，确保 ID 非空
      id: data.id ?? _uuid.v4(),
      name: data.name,
      priority: data.priority,
      action: data.action,
      contentRegex: data.contentRegex,
      senderRegex: data.senderRegex,
      isEnabled: data.isEnabled == 1,
    );
  }

  /// 将 SmsRegexRuleModel (应用模型) 转换为 Drift Companion (用于写入数据库)
  SmsRulesCompanion _toCompanion(SmsRegexRuleModel model) {
    return SmsRulesCompanion(
      id: Value(model.id),
      name: Value(model.name),
      priority: Value(model.priority),
      action: Value(model.action),
      contentRegex: Value(model.contentRegex),
      senderRegex: Value(model.senderRegex),
      isEnabled: Value(model.isEnabled ? 1 : 0),
      ruleType: Value(model.ruleType), // 继承自 RuleModel
    );
  }

  // --- 核心 CRUD ---

  @override
  Future<List<SmsRegexRuleModel>> getAll() async {
    final results = await _database.select(_database.smsRules).get();
    return results.map(_fromData).toList();
  }

  @override
  Future<SmsRegexRuleModel?> getById(String id) async {
    final result = await (_database.select(_database.smsRules)
      ..where((tbl) => tbl.id.equals(id)))
      .getSingleOrNull();
      
    return result != null ? _fromData(result) : null;
  }

  @override
  Future<String> insert(SmsRegexRuleModel rule) async {
    _validateRegex(rule);
    
    final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
    
    // 1. 创建 Companion
    final companion = _toCompanion(rule);
    // 2. 注入 ID
    final companionWithId = companion.copyWith(id: Value(id));

    // 使用 insertOnConflictUpdate 实现 ConflictAlgorithm.replace
    await _database.into(_database.smsRules).insertOnConflictUpdate(companionWithId);
    
    return id;
  }

  @override
  Future<int> update(SmsRegexRuleModel rule) async {
    _validateRegex(rule);
    final companion = _toCompanion(rule);
    
    return await (_database.update(_database.smsRules)
      ..where((tbl) => tbl.id.equals(rule.id)))
      .write(companion);
  }

  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.smsRules)
      ..where((tbl) => tbl.id.equals(id)))
      .go();
  }

  // 批量操作方法
  @override
  Future<List<String>> insertAll(List<SmsRegexRuleModel> rules) async {
    final List<String> ids = [];

    await _database.batch((batch) {
      for (final rule in rules) {
        _validateRegex(rule); // 仍然需要在批量插入时进行验证
        
        final String id = rule.id.isEmpty ? _uuid.v4() : rule.id;
        ids.add(id);

        final companion = _toCompanion(rule);
        final companionWithId = companion.copyWith(id: Value(id));

        batch.insert(
          _database.smsRules,
          companionWithId,
          mode: InsertMode.insertOrReplace,
        );
      }
    });
    return ids;
  }

  @override
  Future<int> updateAll(List<SmsRegexRuleModel> rules) async {
    // 尽管我们使用 batch，但验证仍需在循环内完成
    for (final rule in rules) {
      _validateRegex(rule);
    }
    
    await _database.batch((batch) {
      for (final rule in rules) {
        batch.update(
          _database.smsRules,
          _toCompanion(rule),
          where: (tbl) => tbl.id.equals(rule.id),
        );
      }
    });
    // 返回尝试更新的记录数
    return rules.length;
  }

  void _validateRegex(SmsRegexRuleModel rule) {
    // 业务逻辑验证，保持不变
    try {
      RegExp(rule.contentRegex);
      if (rule.senderRegex != null) RegExp(rule.senderRegex!);
    } catch (e) {
      throw FormatException('Invalid regex pattern: ${e.toString()}');
    }
  }

  // 其他必要接口实现
  @override
  Future<void> clear() async {
    await _database.delete(_database.smsRules).go();
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    
    // 使用 whereIn 优化批量删除
    return await (_database.delete(_database.smsRules)
      ..where((tbl) => tbl.id.isIn(ids)))
      .go();
  }

  @override
  Future<String> exportData() async {
    final rules = await getAll();
    return jsonEncode(rules.map((r) => r.toMap()).toList());
  }

  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> jsonList = jsonDecode(data) as List<dynamic>;
      final rules = jsonList.map((j) => SmsRegexRuleModel.fromMap(j as Map<String, dynamic>)).toList();
      await insertAll(rules);
      return true;
    } catch (e) {
      // 错误处理
      return false;
    }
  }
}