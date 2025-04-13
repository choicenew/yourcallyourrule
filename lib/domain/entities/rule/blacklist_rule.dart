import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_priority.dart';
import '../../value_objects/rule_action.dart';
import 'rule_base.dart';

/// 黑名单规则实体
/// 用于定义订阅的黑名单规则
class BlacklistRule extends RuleBase {
  final PhoneNumber phoneNumber;
  final String? category; // 可选的分类信息
  
  const BlacklistRule({
    required super.id,
    required super.name,
    super.description,
    required super.isEnabled,
    required super.createdAt,
    super.updatedAt,
    required this.phoneNumber,
    this.category,
    required super.source,
  }) : super(
    priority: RulePriority.blacklist,
    action: RuleAction.block,
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
        other is BlacklistRule &&
        other.phoneNumber == phoneNumber &&
        other.category == category;
  }
  
  @override
  int get hashCode => Object.hash(super.hashCode, phoneNumber, category);
}