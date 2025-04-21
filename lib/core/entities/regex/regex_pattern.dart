import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

class RegExPattern {
  final String pattern;
  final RuleAction action;
  final String name;

  const RegExPattern({
    required this.pattern,
    required this.action,
    required this.name,
  });

  bool get isValid {
    try {
      RegExp(pattern);
      return true;
    } catch (e) {
      return false;
    }
  }
}