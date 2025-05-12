// 规则数据模型，用于数据层与领域层之间的转换

import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/models/rule_model.dart';


import '../../core/entities/rule/regex_rule.dart';
import '../../core/value_objects/rule_priority.dart';
import '../../core/value_objects/rule_action.dart';




// 允许/阻止规则模型
class AllowedBlockedRuleModel extends RuleModel {
  final String phoneNumber;
  final String labelId;
  final bool isSubscribed;
  final int count;
  final String? avatar;

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
    super.isEnabled,
  }) : super(
            ruleType:
                'allow_block'); // ruleType will be 'allow' or 'block' based on action

  factory AllowedBlockedRuleModel.fromMap(Map<String, dynamic> map) {
    return AllowedBlockedRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'],
      phoneNumber: map['phoneNumber'],
      labelId: map['labelId'],
      isSubscribed: map['isSubscribed'] ?? false,
      count: map['count'] ?? 0,
      avatar: map['avatar'],
      isEnabled: map['isEnabled'] ?? true,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'labelId': labelId,
      'isSubscribed': isSubscribed,
      'count': count,
      'avatar': avatar,
    });
    return map;
  }

  @override
  AllowedBlockedRule toEntity() {
    return AllowedBlockedRule(
      id: id,
      name: name,
      priority: RulePriority(priority),
      action: RuleAction.fromString(action),
      phoneNumber: PhoneNumber.fromString(phoneNumber),
      labelId: labelId,
      isSubscribed: isSubscribed,
      count: count,
      avatar: avatar,
      isEnabled: isEnabled,
    );
  }

  static AllowedBlockedRuleModel fromEntity(AllowedBlockedRule entity) {
    return AllowedBlockedRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority.value,
      action: entity.action.toString(),
      phoneNumber: entity.phoneNumber.value,
      labelId: entity.labelId,
      isSubscribed: entity.isSubscribed,
      count: entity.count,
      avatar: entity.avatar,
      isEnabled: entity.isEnabled,
    );
  }
}






















































