import 'package:pyro_phone_rules_protocol/src/models/phone_rule_entity.dart';

/// 电话规则持久化 Driver 抽象接口契约 (PhoneRuleStorageDriver)
abstract class PhoneRuleStorageDriver {
  Future<PhoneRuleEntity?> getRuleById(String id);
  Future<void> saveRule(PhoneRuleEntity rule);
  Future<void> deleteRule(String id);
  Future<List<PhoneRuleEntity>> getAllRules();
}
