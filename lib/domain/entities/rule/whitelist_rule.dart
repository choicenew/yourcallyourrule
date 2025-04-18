import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_priority.dart';
import '../../value_objects/rule_action.dart';
import 'rule_base.dart';
import 'phone_number_rule.dart';

/// 白名单规则实体
/// 用于定义订阅的白名单规则
class WhitelistRule extends RuleBase implements PhoneNumberRule {
  @override
  final PhoneNumber phoneNumber;
  final String? category; // 可选的分类信息
  @override
  final String? label;
  @override
  final String? avatar;
  
  const WhitelistRule({
    required super.id,
    required super.name,
    super.description,
    required super.isEnabled,
    required super.createdAt,
    super.updatedAt,
    required this.phoneNumber,
    this.category,
    this.label,
    this.avatar,
    required super.source,
  }) : super(
    priority: RulePriority.whitelist,
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
        other is WhitelistRule &&
        other.phoneNumber == phoneNumber &&
        other.category == category;
  }
  
  @override
  int get hashCode => Object.hash(super.hashCode, phoneNumber, category);
}