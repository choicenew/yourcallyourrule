import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

import '../../lib/core/entities/value_objects/rule_action.dart';
import '../../lib/core/entities/value_objects/rule_priority.dart';


class KeywordRule extends RuleBase {
  final String keyword;

  KeywordRule({
    required super.id,
    required super.name,
    required this.keyword,
    required super.action,
    super.priority,
    super.isEnabled = true,
  });

  @override
  KeywordRule copyWith({
    bool? isEnabled,
    RulePriority? priority,
    RuleAction? action,
  }) {
    return KeywordRule(
      id: id,
      name: name,
      keyword: keyword,
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