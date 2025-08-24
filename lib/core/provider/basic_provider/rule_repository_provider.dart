import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_rule_datasource_provider.dart';
import 'package:yourcallyourrule/data/datasources/local/local_rule_datasource.dart';
import 'package:yourcallyourrule/data/models/allow_block_rule_model.dart';
import 'package:yourcallyourrule/data/models/phone_rule_model.dart';
import 'package:yourcallyourrule/data/models/regex_rule_model.dart';
import 'package:yourcallyourrule/data/models/rule_model.dart';

/// 规则仓库提供者
final ruleRepositoryProvider = Provider<RuleRepository>((ref) {
  final localRuleDataSource = ref.watch(localRuleDataSourceProvider);
  // 返回规则仓库实现
  return RuleRepositoryImpl(localRuleDataSource);
});

/// 规则仓库实现类
class RuleRepositoryImpl implements RuleRepository {
  final LocalRuleDataSource _localRuleDataSource;

  RuleRepositoryImpl(this._localRuleDataSource);

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

  Future<List<RuleBase>> getAllByType(String type) async {
    final rules = await _localRuleDataSource.getByRuleType(type);
    // 将RuleModel转换为RuleBase
    return rules.map((model) => createRuleFromMap(model.toMap())).toList();
  }

  @override
  Future<List<RuleBase>> getAllDisabled() async {
    final rules = await _localRuleDataSource.getDisabledRules();
    // 将RuleModel转换为RuleBase
    return rules.map((model) => createRuleFromMap(model.toMap())).toList();
  }

  @override
  Future<List<RuleBase>> getAllEnabled() async {
    final rules = await _localRuleDataSource.getEnabledRules();
    // 将RuleModel转换为RuleBase
    return rules.map((model) => createRuleFromMap(model.toMap())).toList();
  }

  @override
  Future<List<RuleBase>> getAll() async {
    final rules = await _localRuleDataSource.getAll();
    // 将RuleModel转换为RuleBase
    return rules.map((model) => createRuleFromMap(model.toMap())).toList();
  }

  @override
  Future<RuleBase?> getById(String id) async {
    final rule = await _localRuleDataSource.getById(id);
    // 将RuleModel转换为RuleBase
    return rule != null ? createRuleFromMap(rule.toMap()) : null;
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
    // 将RuleBase转换为RuleModel
    final map = entity.toMap();
    final model = _createModelFromMap(map);
    await _localRuleDataSource.insert(model);
    return entity;
  }

  // 辅助方法：根据map创建对应的RuleModel
  RuleModel _createModelFromMap(Map<String, dynamic> map) {
    final ruleType = map['ruleType'] as String;
    
    switch (ruleType) {
      case 'phone_rule':
      case 'white_black': // 兼容旧数据
        return PhoneRuleModel.fromMap(map);
      case 'regex':
        return RegexRuleModel.fromMap(map);
      case 'allow_block':
        return AllowedBlockedRuleModel.fromMap(map);
      default:
        throw Exception('Unknown rule type: $ruleType');
    }
  }

  @override
  Future<void> saveRule(RuleBase rule) async {
    await save(rule);
  }

  @override
  Future<List<RuleBase>> searchByName(String name) async {
    final rules = await _localRuleDataSource.searchByName(name);
    // 将RuleModel转换为RuleBase
    return rules.map((model) => createRuleFromMap(model.toMap())).toList();
  }

  @override
  Future<RuleBase> update(RuleBase entity) async {
    // 将RuleBase转换为RuleModel
    final map = entity.toMap();
    final model = _createModelFromMap(map);
    await _localRuleDataSource.update(model);
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
    await _localRuleDataSource.delete(id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<RuleBase> entities) async {
    await _localRuleDataSource.deleteAll(entities.map((e) => e.id).toList());
    return true;
  }

  @override
  Future<List<RuleBase>> saveAll(List<RuleBase> entities) async {
    // 将所有实体转换为模型
    final models = entities.map((entity) => _createModelFromMap(entity.toMap())).toList();
    await _localRuleDataSource.insertAll(models);
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

  @override
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumberStr) {
    // Not applicable for local rules
    throw UnimplementedError();
  }

  @override
  Future<bool> syncRemoteNumbers() {
    // Not applicable for local rules
    throw UnimplementedError();
  }
}