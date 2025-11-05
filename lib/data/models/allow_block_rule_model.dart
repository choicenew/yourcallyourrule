// 规则数据模型，用于数据层与领域层之间的转换

import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/models/rule_model.dart';


import '../../core/value_objects/rule_priority.dart';
import '../../core/value_objects/rule_action.dart';




// 允许/阻止规则模型
class AllowedBlockedRuleModel extends RuleModel {
  final String phoneNumber;
  final String labelId;
  final bool isSubscribed;
  final int count;
  final String? avatar;
  final String? subscriptionId;

  const AllowedBlockedRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action, // action is crucial here
    required this.phoneNumber,
    required this.labelId,
    required this.isSubscribed,
    required this.count,
    this.avatar,
    this.subscriptionId,
    super.isEnabled,
    String? ruleType, // Make ruleType optional
  }) : super(
            ruleType: ruleType ??
                'allow_block'); // ruleType will be 'allow' or 'block' based on action

  factory AllowedBlockedRuleModel.fromMap(Map<String, dynamic> map) {
    return AllowedBlockedRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'], // action is already a string here
      phoneNumber: map['phoneNumber'],
      labelId: map['labelId'],
      isSubscribed: (map['isSubscribed'] ?? 0) == 1,
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
      'isSubscribed': isSubscribed ? 1 : 0,
      'count': count,
      'avatar': avatar,
      'subscriptionId': subscriptionId,
    });
    return map;
  }

  @override
  AllowedBlockedRule toEntity() {
    return AllowedBlockedRule(
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

  static AllowedBlockedRuleModel fromEntity(AllowedBlockedRule entity) {
    return AllowedBlockedRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority.value,
      action: entity.action.toString(), // Use toString() to get the string representation
      phoneNumber: entity.phoneNumber.value,
      labelId: entity.labelId,
      isSubscribed: entity.isSubscribed,
      count: entity.count,
      avatar: entity.avatar,
      subscriptionId: entity.subscriptionId,
      isEnabled: entity.isEnabled,
    );
  }
}






















































