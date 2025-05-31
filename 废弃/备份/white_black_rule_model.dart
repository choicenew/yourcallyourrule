import 'package:yourcallyourrule/core/entities/rule/white_black_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

import 'rule_model.dart';

// 白黑名单规则模型
class WhiteBlackRuleModel extends RuleModel {
  final String phoneNumber;
  final String labelId;
  final bool isSubscribed;
  final int count;
  final String? avatar;

  const WhiteBlackRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.phoneNumber,
    required this.labelId,
    required this.isSubscribed,
    required this.count,
    this.avatar,
    super.isEnabled,
  }) : super(
          ruleType: 'white_black',
        );

  factory WhiteBlackRuleModel.fromMap(Map<String, dynamic> map) {
    return WhiteBlackRuleModel(
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
  WhiteBlackRule toEntity() {
    return WhiteBlackRule(
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

  static WhiteBlackRuleModel fromEntity(WhiteBlackRule entity) {
    return WhiteBlackRuleModel(
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