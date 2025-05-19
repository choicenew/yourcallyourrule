import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

class AllowedBlockedRule extends RuleBase {
  final PhoneNumber phoneNumber;
  final String labelId; // 使用labelId引用PredefinedLabel
  final bool isSubscribed;
  final int count;
  final String? avatar; // 头像字段

  AllowedBlockedRule({
    required super.id,
    required super.name,
    required super.action, // action 现在是必须的，并且由构造函数直接接收
    required this.phoneNumber,
    required this.labelId,
    RulePriority? priority, // 优先级变为可选
    super.isEnabled = true,
    this.isSubscribed = false,
    this.count = 0,
    this.avatar,
  }) : super(
          priority: priority ?? _defaultPriority(action),
        );

  static RulePriority _defaultPriority(RuleAction action) {
    switch (action.type) {
      case RuleActionType.allow:
        return RulePriority.highest;  // 使用预定义常量，优先级100
      case RuleActionType.block:
        return RulePriority.veryHigh;  // 使用预定义常量，优先级50
      case RuleActionType.silence:
        return RulePriority.silenceAction;  // 使用预定义常量，优先级1
      case RuleActionType.none:
      default:
        return RulePriority.noneAction;  // 使用预定义常量，优先级0
    }
  }

  @override
  bool matches(String input) {
    return isEnabled && phoneNumber.value == input;
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'phoneNumber': phoneNumber.value,
        'labelId': labelId,
        'isSubscribed': isSubscribed,
        'count': count,
        'avatar': avatar,
      });
  }

  factory AllowedBlockedRule.fromMap(Map<String, dynamic> map) {
    RuleAction action = RuleAction.fromString(map['action']);
    return AllowedBlockedRule(
      id: map['id'],
      name: map['name'],
      priority: RulePriority.fromInt(map['priority']),
      action: action, // action 从 map 中获取
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      labelId: map['labelId'],
      isEnabled: map['isEnabled'] ?? true,
      isSubscribed: map['isSubscribed'] ?? false,
      count: map['count'] ?? 0,
      avatar: map['avatar'],
    );
  }

  @override
  AllowedBlockedRule copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
    PhoneNumber? phoneNumber,
    String? labelId,
    bool? isSubscribed,
    int? count,
    String? avatar,
  }) {
    return AllowedBlockedRule(
      id: id ?? this.id,
      name: name ?? this.name,
      action: action ?? this.action,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      labelId: labelId ?? this.labelId,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      count: count ?? this.count,
      avatar: avatar ?? this.avatar,
    );
  }
}