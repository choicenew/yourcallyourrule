import 'package:drift/drift.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

/// 自动可生成的规则映射器工具 (PhoneRuleEntity <-> Drift Companion/Data)
abstract class PhoneRuleModelMapper {
  static PhoneRuleEntity fromPhoneRuleData(PhoneRuleData data) {
    return PhoneRuleEntity(
      id: data.id ?? '',
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

  static PhoneRulesCompanion toPhoneRulesCompanion(PhoneRuleEntity entity) {
    return PhoneRulesCompanion(
      id: Value(entity.id),
      name: Value(entity.name),
      priority: Value(entity.priority),
      action: Value(entity.action),
      phoneNumber: Value(entity.phoneNumber),
      labelId: Value(entity.labelId),
      count: Value(entity.count),
      avatar: Value(entity.avatar),
      subscriptionId: Value(entity.subscriptionId),
      isEnabled: Value(entity.isEnabled ? 1 : 0),
      ruleType: Value(entity.ruleType),
    );
  }

  static PhoneRuleEntity fromRegexRuleData(RegexRuleData data) {
    return PhoneRuleEntity(
      id: data.id ?? '',
      name: data.name,
      priority: data.priority,
      action: data.action,
      pattern: data.pattern,
      subscriptionId: data.subscriptionId,
      isEnabled: data.isEnabled == 1,
      ruleType: data.ruleType,
    );
  }

  static RegexRulesCompanion toRegexRulesCompanion(PhoneRuleEntity entity) {
    return RegexRulesCompanion(
      id: Value(entity.id),
      name: Value(entity.name),
      priority: Value(entity.priority),
      action: Value(entity.action),
      pattern: Value(entity.pattern ?? ''),
      isEnabled: Value(entity.isEnabled ? 1 : 0),
      subscriptionId: Value(entity.subscriptionId),
      ruleType: Value(entity.ruleType),
    );
  }
}