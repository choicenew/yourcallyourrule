// 正则表达式规则实体，用于表示基于正则表达式的规则

import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';

class RegexRule extends RuleBase {
  static const String ruleType = 'regex';
  final String pattern;
  final String? subscriptionId;
  
  // 将 isSubscribed 改为计算属性
  bool get isSubscribed => subscriptionId != null;


  RegexRule({
    required super.id,
    required super.name,
    required this.pattern,
    required super.action,
    RulePriority? priority, // 添加可选优先级参数
    super.isEnabled = true,
    this.subscriptionId, // 添加subscriptionId参数
  }) : super(
          priority: priority ?? _defaultPriority(action), // 优先使用传入的优先级
        );


  static RulePriority _defaultPriority(RuleAction action) {
    switch (action.type) {
      case RuleActionType.allow:
        return RulePriority.high;  // 使用预定义常量，优先级10
      case RuleActionType.block:
        return RulePriority.medium;  // 使用预定义常量，优先级5
      case RuleActionType.silence:
        return RulePriority.silenceAction;  // 使用预定义常量，优先级1
      case RuleActionType.none:
      default:
        return RulePriority.noneAction;  // 使用预定义常量，优先级0
    }
  }

  @override
  RegexRule copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
    String? ruleType,
    String? pattern,
    String? subscriptionId,
  }) {
    return RegexRule(
      id: id ?? this.id,
      name: name ?? this.name,
      pattern: pattern ?? this.pattern,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      subscriptionId: subscriptionId ?? this.subscriptionId,
    );
  }

  @override
  bool matches(String input) {
    if (!isEnabled) return false;
    try {
      return RegExp(pattern).hasMatch(input);
    } catch (e) {
      return false;
    }
  }

  // 添加缺失的序列化方法
  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'pattern': pattern,
        'subscriptionId': subscriptionId,
      });
  }

  factory RegexRule.fromMap(Map<String, dynamic> map) {
    return RegexRule(
      id: map['id'],
      name: map['name'],
      pattern: map['pattern'],
      priority: RulePriority.fromInt(map['priority']),
      action: RuleAction.fromString(map['action']),
      isEnabled: (map['isEnabled'] ?? 1) == 1,
      subscriptionId: map['subscriptionId'],
    );
  }
}