import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

import 'rule_model.dart';

// 电话规则模型
class PhoneRuleModel extends PhoneBasedRuleModel {
  const PhoneRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required super.phoneNumber,
    required super.labelId,
    required super.count,
    super.avatar,
    super.subscriptionId,
    super.isEnabled,
    String? ruleType, // Make ruleType optional
  }) : super(ruleType: ruleType ?? 'phone_rule');

  factory PhoneRuleModel.fromMap(Map<String, dynamic> map) {
    return PhoneRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'], // action is already a string here
      phoneNumber: map['phoneNumber'],
      labelId: map['labelId'],
      count: map['count'] ?? 0,
      avatar: map['avatar'],
      subscriptionId: map['subscriptionId'],
      isEnabled: (map['isEnabled'] ?? 1) == 1,
      ruleType: map['ruleType'], // Read ruleType from map
    );
  }

  // PhoneBasedRuleModel已经实现了toMap方法，不需要重复实现

  @override
  PhoneRule toEntity() {
    return PhoneRule(
      id: id,
      name: name,
      priority: RulePriority.fromInt(priority),
      action: RuleAction.fromString(action),
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      labelId: labelId,
      count: count,
      avatar: avatar,
      isEnabled: isEnabled,
      subscriptionId: subscriptionId,
    );
  }

  static PhoneRuleModel fromEntity(PhoneRule entity) {
    return PhoneRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority.value,
      action: entity.action.toString(), // Use toString() to get the string representation
      phoneNumber: entity.phoneNumber.value,
      labelId: entity.labelId,
      count: entity.count,
      avatar: entity.avatar,
      subscriptionId: entity.subscriptionId,
      isEnabled: entity.isEnabled,
    );
  }
  
  // 不再需要fromAllowedBlockedRule方法，因为已经有了RuleModel.fromEntity工厂方法
}