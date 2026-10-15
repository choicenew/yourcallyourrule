import 'package:freezed_annotation/freezed_annotation.dart';
import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';
import 'rule_type.dart';

part 'phone_rule.freezed.dart';

/// 电话号码过滤规则领域实体 (@freezed 自动生成不可变数据类)
@freezed
abstract class PhoneRule with _$PhoneRule implements RuleBase {
  const PhoneRule._();

  @Implements<RuleBase>()
  const factory PhoneRule({
    required String id,
    required String name,
    required RuleAction action,
    required PhoneNumber phoneNumber,
    required String labelId,
    @Default(RuleTypeKeys.phone) String ruleType,
    @Default(RulePriority.medium) RulePriority priority,
    @Default(true) bool isEnabled,
    @Default(0) int count,
    String? avatar,
    String? subscriptionId,
  }) = _PhoneRule;

  /// 计算属性：判断是否关联订阅
  bool get isSubscribed => subscriptionId != null;

  @override
  String toJson() => toMap().toString();

  /// 号码过滤匹配逻辑
  @override
  bool matches(String input) {
    return isEnabled && phoneNumber.value == input;
  }

  /// 格式化转换 Map
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'action': action.toString(),
      'phoneNumber': phoneNumber.value,
      'labelId': labelId,
      'priority': priority.value,
      'isEnabled': isEnabled ? 1 : 0,
      'count': count,
      'avatar': avatar,
      'ruleType': ruleType,
      'subscriptionId': subscriptionId,
    };
  }

  /// 从 Map 反序列化生成实体
  factory PhoneRule.fromMap(Map<String, dynamic> map) {
    return PhoneRule(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      priority: RulePriority.fromInt(map['priority']),
      action: RuleAction.fromString(map['action']),
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']?.toString() ?? ''),
      labelId: map['labelId']?.toString() ?? '',
      isEnabled: (map['isEnabled'] ?? 1) == 1 || map['isEnabled'] == true,
      count: (map['count'] as num?)?.toInt() ?? 0,
      avatar: map['avatar']?.toString(),
      ruleType: map['ruleType']?.toString() ?? RuleTypeKeys.phone,
      subscriptionId: map['subscriptionId']?.toString(),
    );
  }
}
