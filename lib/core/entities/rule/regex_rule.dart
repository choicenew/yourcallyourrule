// 正则表达式规则实体，用于表示基于正则表达式的规则

import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';

class RegexRule extends RuleBase {
  static const String ruleType = 'regex';
  final String pattern;


  RegexRule({
    required super.id,
    required super.name,
    required this.pattern,
    required super.action,

    RulePriority? priority, // 添加可选优先级参数
    super.isEnabled = true,
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
  }) {
    return RegexRule(
      id: id ?? this.id,
      name: name ?? this.name,
      pattern: pattern ?? this.pattern,
      action: action ?? this.action,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,

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
    return super.toMap()..addAll({
      'pattern': pattern,
      'ruleType': ruleType,
    });
  }

  factory RegexRule.fromMap(Map<String, dynamic> map) {
    return RegexRule(
      id: map['id'],
      name: map['name'],
      pattern: map['pattern'],
      action: RuleAction.fromString(map['action']),
      priority: RulePriority.fromInt(map['priority']),
      isEnabled: (map['isEnabled'] ?? 1) == 1,

    );
  }
}