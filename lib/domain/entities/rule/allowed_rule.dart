import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_priority.dart';
import '../../value_objects/rule_action.dart';
import 'rule_base.dart';
import 'phone_number_rule.dart';

/// 允许规则实体
/// 用于定义允许通过的电话号码规则
class AllowedRule extends RuleBase implements PhoneNumberRule {
  @override
  final PhoneNumber phoneNumber;
  @override
  final String? label;
  @override
  final String? avatar;
  
  const AllowedRule({
    required super.id,
    required super.name,
    super.description,
    required super.isEnabled,
    required super.createdAt,
    super.updatedAt,
    required this.phoneNumber,
    this.label,
    this.avatar,
    required super.source,
  }) : super(
    priority: RulePriority.allowed,
    action: RuleAction.allow,
  );
  
  @override
  bool matches(String input) {
    try {
      final inputPhoneNumber = PhoneNumber(input);
      return phoneNumber.normalized == inputPhoneNumber.normalized;
    } catch (_) {
      return false;
    }
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return super == other &&
        other is AllowedRule &&
        other.phoneNumber == phoneNumber;
  }
  
  @override
  int get hashCode => Object.hash(super.hashCode, phoneNumber);
}