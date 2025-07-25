import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// 规则仓库提供者
final ruleRepositoryProvider = Provider<RuleRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回规则仓库实现
  return RuleRepositoryImpl(databaseService);
});

/// 规则仓库实现类
class RuleRepositoryImpl implements RuleRepository {
  final DatabaseService _databaseService;

  RuleRepositoryImpl(this._databaseService);

  @override
  RuleBase createEmptyRule() {
    throw UnimplementedError();
  }

  @override
  RuleBase createRuleFromMap(Map<String, dynamic> map) {
    final ruleType = map['ruleType'] as String;
    
    switch (ruleType) {
      case 'phone_rule':
      case 'white_black': // 兼容旧数据
        return PhoneRule.fromMap(map);
      case 'regex':
        return RegexRule.fromMap(map);
      case 'alloworblock':
      case 'allow_block':
        return AllowedBlockedRule.fromMap(map);
      default:
        throw Exception('Unknown rule type: $ruleType');
    }
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    await deleteById(ruleId);
  }

  @override
  Future<List<RuleBase>> getAllByType(String type) async {
    final maps = await _databaseService.queryWhere('rules', 'ruleType', type);
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<List<RuleBase>> getAllDisabled() async {
    final maps = await _databaseService.queryWhere('rules', 'isEnabled', false);
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<List<RuleBase>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('rules', 'isEnabled', true);
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<List<RuleBase>> getAll() async {
    final maps = await _databaseService.queryAll('rules');
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<RuleBase?> getById(String id) async {
    final map = await _databaseService.queryById('rules', id);
    if (map == null) return null;
    return createRuleFromMap(map);
  }

  @override
  Future<RuleBase?> getRuleById(String ruleId) async {
    return getById(ruleId);
  }

  @override
  Future<List<RuleBase>> getRulesByType(String type) async {
    return getAllByType(type);
  }

  @override
  Future<RuleBase> save(RuleBase entity) async {
    await _databaseService.insert('rules', entity.toMap());
    return entity;
  }

  @override
  Future<void> saveRule(RuleBase rule) async {
    await save(rule);
  }

  @override
  Future<List<RuleBase>> searchByName(String name) async {
    final maps = await _databaseService.queryLike('rules', 'name', name);
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<RuleBase> update(RuleBase entity) async {
    await _databaseService.update('rules', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<void> updateRule(RuleBase rule) async {
    await update(rule);
  }

  @override
  Future<RuleBase> updateEnabledStatus(String id, bool isEnabled) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found');
    }
    // 使用copyWith方法创建新的规则对象，而不是直接修改final字段
    final updatedRule = rule.copyWith(isEnabled: isEnabled);
    await update(updatedRule);
    return updatedRule;
  }

  @override
  Future<RuleBase> updatePriority(String id, int priority) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found');
    }
    // 使用copyWith方法创建新的规则对象，而不是直接修改final字段
    final updatedRule = rule.copyWith(priority: RulePriority.fromInt(priority));
    await update(updatedRule);
    return updatedRule;
  }

  @override
  Future<bool> delete(RuleBase entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('rules', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<RuleBase> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<RuleBase>> saveAll(List<RuleBase> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final rules = await getAll();
    return rules.length;
  }

  @override
  RuleBase fromMap(Map<String, dynamic> map) {
    return createRuleFromMap(map);
  }
}