import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_type.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

import 'package:yourcallyourrule/common/utils/bool_parser.dart';

part 'allowed_blocked_rule.freezed.dart';
part 'allowed_blocked_rule.g.dart';

/// 允许/阻止规则领域实体 (@freezed + @JsonSerializable 100% 自动生成序列化)
@freezed
abstract class AllowedBlockedRule with _$AllowedBlockedRule implements RuleBase {
  const AllowedBlockedRule._();

  @Implements<RuleBase>()
  const factory AllowedBlockedRule({
    required String id,
    required String name,
    @RuleActionConverter() required RuleAction action,
    @PhoneNumberConverter() required PhoneNumber phoneNumber,
    required String labelId,
    @Default(RuleTypeKeys.allowBlock) String ruleType,
    @RulePriorityConverter() @Default(RulePriority.high) RulePriority priority,
    @Default(true) bool isEnabled,
    @Default(0) int count,
    String? avatar,
    String? subscriptionId,
  }) = _AllowedBlockedRule;

  /// 计算属性：判断是否关联订阅
  bool get isSubscribed => subscriptionId != null;

  /// 号码过滤匹配逻辑
  @override
  bool matches(String input) {
    return isEnabled && phoneNumber.value == input;
  }

  /// 100% 自动生成 JSON 反序列化
  factory AllowedBlockedRule.fromJson(Map<String, dynamic> json) =>
      _$AllowedBlockedRuleFromJson(json);

  /// 转换 Map (委托给自动生成的 toJson)
  @override
  Map<String, dynamic> toMap() => toJson();

  /// 从 Map 反序列化 (注入动态默认优先级：ALLOW = 100 > BLOCK = 50)
  factory AllowedBlockedRule.fromMap(Map<String, dynamic> map) {
    final jsonMap = Map<String, dynamic>.from(map);
    if (jsonMap.containsKey('isEnabled')) {
      jsonMap['isEnabled'] = parseBool(jsonMap['isEnabled']);
    }
    if (jsonMap['priority'] == null) {
      final action = RuleAction.fromString(jsonMap['action']?.toString() ?? '');
      jsonMap['priority'] = action.type == RuleActionType.allow
          ? RulePriority.highest.value
          : RulePriority.veryHigh.value;
    }
    return AllowedBlockedRule.fromJson(jsonMap);
  }
}
