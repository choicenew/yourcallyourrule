import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';

/// 电话规则仓库接口
abstract class RuleRepository {
  Future<List<PhoneRuleEntity>> getAll();
  Future<PhoneRuleEntity?> getById(String id);
  Future<PhoneRuleEntity> save(PhoneRuleEntity entity);
  Future<PhoneRuleEntity> update(PhoneRuleEntity entity);
  Future<List<PhoneRuleEntity>> saveAll(List<PhoneRuleEntity> entities);
  Future<bool> delete(PhoneRuleEntity entity);
  Future<bool> deleteById(String id);
  Future<bool> deleteAll(List<PhoneRuleEntity> entities);
  Future<bool> exists(String id);
  Future<int> count();

  Future<void> saveRule(PhoneRuleEntity rule);
  Future<void> deleteRule(String ruleId);
  Future<void> updateRule(PhoneRuleEntity rule);
  Future<PhoneRuleEntity?> getRuleById(String ruleId);
  Future<List<PhoneRuleEntity>> getRulesByType(String type);
  Future<List<PhoneRuleEntity>> searchByName(String name);
  Future<PhoneRuleEntity> updateEnabledStatus(String id, bool isEnabled);
  Future<PhoneRuleEntity> updatePriority(String id, int priority);
  Future<List<PhoneRuleEntity>> getAllEnabled();
  Future<List<PhoneRuleEntity>> getAllDisabled();

  // 正则规则操作支持
  Future<List<RegexRuleEntity>> getAllRegexRules();
  Future<RegexRuleEntity?> getRegexRuleById(String id);
  Future<void> saveRegexRule(RegexRuleEntity rule);
  Future<void> deleteRegexRule(String id);
}