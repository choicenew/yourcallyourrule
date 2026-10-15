import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_type.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

part 'allowed_blocked_rule.freezed.dart';

/// 允许/阻止规则领域实体 (@freezed 自动生成不可变数据类)
@freezed
abstract class AllowedBlockedRule with _$AllowedBlockedRule implements RuleBase {
  const AllowedBlockedRule._();

  @Implements<RuleBase>()
  const factory AllowedBlockedRule({
    required String id,
    required String name,
    required RuleAction action,
    required PhoneNumber phoneNumber,
    required String labelId,
    @Default(RuleTypeKeys.allowBlock) String ruleType,
    @Default(RulePriority.high) RulePriority priority,
    @Default(true) bool isEnabled,
    @Default(0) int count,
    String? avatar,
    String? subscriptionId,
  }) = _AllowedBlockedRule;

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
  factory AllowedBlockedRule.fromMap(Map<String, dynamic> map) {
    return AllowedBlockedRule(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      priority: RulePriority.fromInt(map['priority']),
      action: RuleAction.fromString(map['action']),
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']?.toString() ?? ''),
      labelId: map['labelId']?.toString() ?? '',
      isEnabled: (map['isEnabled'] ?? 1) == 1 || map['isEnabled'] == true,
      count: (map['count'] as num?)?.toInt() ?? 0,
      avatar: map['avatar']?.toString(),
      ruleType: map['ruleType']?.toString() ?? RuleTypeKeys.allowBlock,
      subscriptionId: map['subscriptionId']?.toString(),
    );
  }
}
