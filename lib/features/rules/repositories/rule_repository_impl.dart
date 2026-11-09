import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/rules/data/datasources/local_phone_rule_datasource.dart';
import 'package:yourcallyourrule/features/rules/data/datasources/local_regex_rule_datasource.dart';

part 'rule_repository_impl.g.dart';

/// 自动生成的 RuleRepository Provider
@Riverpod(keepAlive: true)
RuleRepository ruleRepository(Ref ref) {
  return RuleRepositoryImpl(
    ref.watch(localPhoneRuleDataSourceProvider),
    ref.watch(localRegexRuleDataSourceProvider),
  );
}

/// 规则仓库实现类
class RuleRepositoryImpl implements RuleRepository {
  final LocalPhoneRuleDataSource _localPhoneRuleDataSource;
  final LocalRegexRuleDataSource _localRegexRuleDataSource;

  RuleRepositoryImpl(
    this._localPhoneRuleDataSource,
    this._localRegexRuleDataSource,
  );

  @override
  Future<List<PhoneRuleEntity>> getAll() async {
    return await _localPhoneRuleDataSource.getAll();
  }

  @override
  Future<PhoneRuleEntity?> getById(String id) async {
    return await _localPhoneRuleDataSource.getById(id);
  }

  @override
  Future<PhoneRuleEntity> save(PhoneRuleEntity entity) async {
    await _localPhoneRuleDataSource.save(entity);
    return entity;
  }

  @override
  Future<PhoneRuleEntity> update(PhoneRuleEntity entity) async {
    await _localPhoneRuleDataSource.update(entity);
    return entity;
  }

  @override
  Future<List<PhoneRuleEntity>> saveAll(List<PhoneRuleEntity> entities) async {
    await _localPhoneRuleDataSource.saveAll(entities);
    return entities;
  }

  @override
  Future<bool> delete(PhoneRuleEntity entity) async {
    await _localPhoneRuleDataSource.delete(entity.id);
    return true;
  }

  @override
  Future<bool> deleteById(String id) async {
    await _localPhoneRuleDataSource.delete(id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<PhoneRuleEntity> entities) async {
    final ids = entities.map((e) => e.id).toList();
    await _localPhoneRuleDataSource.deleteAll(ids);
    return true;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    return await _localPhoneRuleDataSource.count();
  }

  @override
  Future<List<PhoneRuleEntity>> searchByName(String name) async {
    return await _localPhoneRuleDataSource.searchByName(name);
  }

  @override
  Future<PhoneRuleEntity> updateEnabledStatus(String id, bool isEnabled) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found: $id');
    }
    final updated = rule.copyWith(isEnabled: isEnabled);
    await update(updated);
    return updated;
  }

  @override
  Future<PhoneRuleEntity> updatePriority(String id, int priority) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found: $id');
    }
    final updated = rule.copyWith(priority: priority);
    await update(updated);
    return updated;
  }

  @override
  Future<List<PhoneRuleEntity>> getAllEnabled() async {
    return await _localPhoneRuleDataSource.getEnabledRules();
  }

  @override
  Future<List<PhoneRuleEntity>> getAllDisabled() async {
    return await _localPhoneRuleDataSource.getDisabledRules();
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    await deleteById(ruleId);
  }

  @override
  Future<List<PhoneRuleEntity>> getRulesByType(String type) async {
    final all = await getAll();
    return all.where((rule) => rule.actionType == type).toList();
  }

  @override
  Future<PhoneRuleEntity?> getRuleById(String ruleId) async {
    return await getById(ruleId);
  }

  @override
  Future<void> saveRule(PhoneRuleEntity rule) async {
    await save(rule);
  }

  @override
  Future<void> updateRule(PhoneRuleEntity rule) async {
    await update(rule);
  }

  @override
  Future<List<RegexRuleEntity>> getAllRegexRules() async {
    return await _localRegexRuleDataSource.getAll();
  }

  @override
  Future<RegexRuleEntity?> getRegexRuleById(String id) async {
    return await _localRegexRuleDataSource.getById(id);
  }

  @override
  Future<void> saveRegexRule(RegexRuleEntity rule) async {
    await _localRegexRuleDataSource.save(rule);
  }

  @override
  Future<void> deleteRegexRule(String id) async {
    await _localRegexRuleDataSource.delete(id);
  }
}
