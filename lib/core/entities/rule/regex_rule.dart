// 正则表达式规则实体，用于表示基于正则表达式的规则

import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';

class RegexRule extends RuleBase {
  // 正则表达式模式
  final String pattern;
  
  // 是否区分大小写
  final bool caseSensitive;
  
  // 构造函数
  const RegexRule({
    required String id,
    required String name,
    required this.pattern,
    required RulePriority priority,
    required RuleAction action,
    bool isEnabled = true,
    this.caseSensitive = false,
  }) : super(
          id: id,
          name: name,
          priority: priority,
          action: action,
          isEnabled: isEnabled,
        );
  
  // 实现规则匹配方法
  @override
  bool matches(String input) {
    if (!isEnabled) return false;
    
    try {
      final regex = RegExp(
        pattern,
        caseSensitive: caseSensitive,
      );
      return regex.hasMatch(input);
    } catch (e) {
      // 正则表达式无效
      return false;
    }
  }
  
  // 重写toMap方法，添加正则规则特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'pattern': pattern,
      'caseSensitive': caseSensitive,
    });
    return map;
  }
  
  // 从Map创建实例的工厂构造函数
  factory RegexRule.fromMap(Map<String, dynamic> map) {
    return RegexRule(
      id: map['id'],
      name: map['name'],
      pattern: map['pattern'],
      priority: RulePriority.fromInt(map['priority']),
      action: RuleAction.fromString(map['action']),
      isEnabled: map['isEnabled'] ?? true,
      caseSensitive: map['caseSensitive'] ?? false,
    );
  }
}