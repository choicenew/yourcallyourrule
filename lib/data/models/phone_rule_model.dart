import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

import 'rule_model.dart';

// 电话规则模型
class PhoneRuleModel extends RuleModel {
  final String phoneNumber;
  final String labelId;
  final int count;
  final String? avatar;
  final String? subscriptionId;

  const PhoneRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.phoneNumber,
    required this.labelId,
    required this.count,
    this.avatar,
    this.subscriptionId,
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

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'labelId': labelId,
      'count': count,
      'avatar': avatar,
      'subscriptionId': subscriptionId,
    });
    return map;
  }

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
}