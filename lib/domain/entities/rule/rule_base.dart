import '../base/entity.dart';
import '../../value_objects/rule_priority.dart';
import '../../value_objects/rule_action.dart';

/// 规则基类
/// 所有规则类型都应该继承自这个基类
abstract class RuleBase extends Entity {
  final String name;
  final String description;
  final bool isEnabled;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final RulePriority priority;
  final RuleAction action;
  final String source; // 用户添加/订阅
  
  const RuleBase({
    required super.id,
    required this.name,
    this.description = '',
    required this.isEnabled,
    required this.createdAt,
    this.updatedAt,
    required this.priority,
    required this.action,
    required this.source,
  });
  
  /// 检查规则是否匹配给定的输入
  /// 子类必须实现此方法
  bool matches(String input);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RuleBase &&
        other.id == id &&
        other.name == name &&
        other.priority == priority &&
        other.action == action;
  }
  
  @override
  int get hashCode => Object.hash(id, name, priority, action);
}