// 规则基类，所有规则实体都应该继承自这个类

import '../../base/base_entity.dart';
import '../../value_objects/rule_priority.dart';
import '../../value_objects/rule_action.dart';

abstract class RuleBase extends BaseEntity {
  // 规则名称
  final String name;
  
  // 规则优先级
  final RulePriority priority;
  
  // 规则动作
  final RuleAction action;
  
  // 规则是否启用
  final bool isEnabled;
  
  // 构造函数
  const RuleBase({
    required super.id,
    required this.name,
    required this.priority,
    required this.action,
    this.isEnabled = true,
  });
  
  // 抽象copyWith方法，子类必须实现
  RuleBase copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
  });
  
  // 规则匹配方法，子类必须实现此方法
  bool matches(String input);
  
  // 重写toMap方法，添加规则特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'name': name,
      'priority': priority.value,
      'action': action.toString(),
      'isEnabled': isEnabled,
    });
    return map;
  }
}