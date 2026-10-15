import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';

class WhiteBlackRule extends RuleBase {
  final PhoneNumber phoneNumber;
  final String labelId;
  final bool isSubscribed;
  final int count;
  final String? avatar;
  final String ruleType;

  WhiteBlackRule({
    required super.id,
    required super.name,
    required super.action,
    required this.phoneNumber,
    required this.labelId,
    this.ruleType = 'white_black',
    RulePriority? priority,
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
        return RulePriority.aboveMedium;  // 使用预定义常量，优先级7
      case RuleActionType.block:
        return RulePriority.belowMedium;  // 使用预定义常量，优先级3
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
        'isSubscribed': isSubscribed ? 1 : 0,
        'count': count,
        'avatar': avatar,
        'ruleType': ruleType,
      });
  }

  factory WhiteBlackRule.fromMap(Map<String, dynamic> map) {
    RuleAction action = RuleAction.fromString(map['action']);
    return WhiteBlackRule(
      id: map['id'],
      name: map['name'],
      priority: RulePriority.fromInt(map['priority']),
      action: action,
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      labelId: map['labelId'],
      isEnabled: (map['isEnabled'] ?? 1) == 1,
      isSubscribed: (map['isSubscribed'] ?? 0) == 1,
      count: map['count'] ?? 0,
      avatar: map['avatar'],
      ruleType: map['ruleType'] ?? 'white_black',
    );
  }

  @override
  WhiteBlackRule copyWith({
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
    String? ruleType,
  }) {
    return WhiteBlackRule(
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
      ruleType: ruleType ?? this.ruleType,
    );
  }
}