import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import '../rule/rule_base.dart';

class KeywordRule extends RuleBase {
  static const String ruleType = 'keyword';
  final String keyword;

  KeywordRule({
    required super.id,
    required super.name,
    required this.keyword,
    required super.action,
    RulePriority? priority,
    super.isEnabled = true,
  }) : super(
          priority: priority ?? _defaultPriority(action),
        );

  static RulePriority _defaultPriority(RuleAction action) {
    return action == RuleAction.block 
      ? const RulePriority(10)
      : const RulePriority(5);
  }

  // 保持与RegexRule相同的copyWith模式
  KeywordRule copyWith({
    bool? isEnabled,
    RulePriority? priority,
    RuleAction? action,
    String? keyword,
  }) {
    return KeywordRule(
      id: id,
      name: name,
      keyword: keyword ?? this.keyword,
      action: action ?? this.action,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  bool matches(String input) {
    return isEnabled && input.contains(keyword);
  }

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..addAll({
      'keyword': keyword,
    });
  }

  factory KeywordRule.fromMap(Map<String, dynamic> map) {
    return KeywordRule(
      id: map['id'],
      name: map['name'],
      keyword: map['keyword'],
      action: RuleAction.fromString(map['action']),
      priority: RulePriority.fromInt(map['priority']),
      isEnabled: map['isEnabled'] ?? true,
    );
  }
}