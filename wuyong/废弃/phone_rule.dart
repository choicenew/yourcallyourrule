import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

import '../../lib/core/value_objects/rule_action.dart';
import '../../lib/core/value_objects/rule_priority.dart';
import '../../lib/core/entities/rule_base.dart';

class PhoneRule extends RuleBase {
  final String numberPattern;

  PhoneRule({
    required super.id,
    required super.name,
    required this.numberPattern,
    required super.action,
    super.priority,
    super.isEnabled = true,
  });

  @override
  PhoneRule copyWith({
    bool? isEnabled,
    RulePriority? priority,
    RuleAction? action,
  }) {
    return PhoneRule(
      id: id,
      name: name,
      numberPattern: numberPattern,
      action: action ?? this.action,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  // 其他必要方法...
}