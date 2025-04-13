import '../../value_objects/rule_priority.dart';
import '../../value_objects/rule_action.dart';
import 'rule_base.dart';

/// 正则表达式规则实体
/// 用于基于模式的规则匹配
class RegexRule extends RuleBase {
  final String pattern;
  final bool caseSensitive;
  
  const RegexRule({
    required super.id,
    required super.name,
    super.description,
    required super.isEnabled,
    required super.createdAt,
    super.updatedAt,
    required this.pattern,
    this.caseSensitive = false,
    required super.action,
    required super.source,
  }) : super(
    priority: RulePriority.regex,
  );
  
  @override
  bool matches(String input) {
    try {
      final regex = RegExp(
        pattern,
        caseSensitive: caseSensitive,
      );
      return regex.hasMatch(input);
    } catch (_) {
      return false;
    }
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return super == other &&
        other is RegexRule &&
        other.pattern == pattern &&
        other.caseSensitive == caseSensitive;
  }
  
  @override
  int get hashCode => Object.hash(super.hashCode, pattern, caseSensitive);
}