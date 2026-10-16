import 'package:freezed_annotation/freezed_annotation.dart';
import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';
import 'rule_type.dart';

import 'package:yourcallyourrule/common/utils/bool_parser.dart';

part 'phone_rule.freezed.dart';
part 'phone_rule.g.dart';

/// 电话号码过滤规则领域实体 (@freezed + @JsonSerializable 100% 自动生成序列化)
@freezed
abstract class PhoneRule with _$PhoneRule implements RuleBase {
  const PhoneRule._();

  @Implements<RuleBase>()
  const factory PhoneRule({
    required String id,
    required String name,
    @RuleActionConverter() required RuleAction action,
    @PhoneNumberConverter() required PhoneNumber phoneNumber,
    required String labelId,
    @Default(RuleTypeKeys.phone) String ruleType,
    @RulePriorityConverter() @Default(RulePriority.medium) RulePriority priority,
    @Default(true) bool isEnabled,
    @Default(0) int count,
    String? avatar,
    String? subscriptionId,
  }) = _PhoneRule;

  /// 计算属性：判断是否关联订阅
  bool get isSubscribed => subscriptionId != null;

  /// 号码过滤匹配逻辑
  @override
  bool matches(String input) {
    return isEnabled && phoneNumber.value == input;
  }

  /// 100% 自动生成 JSON 反序列化
  factory PhoneRule.fromJson(Map<String, dynamic> json) =>
      _$PhoneRuleFromJson(json);

  /// 转换 Map (委托给自动生成的 toJson)
  @override
  Map<String, dynamic> toMap() => toJson();

  /// 从 Map 反序列化
  factory PhoneRule.fromMap(Map<String, dynamic> map) {
    final jsonMap = Map<String, dynamic>.from(map);
    if (jsonMap.containsKey('isEnabled')) {
      jsonMap['isEnabled'] = parseBool(jsonMap['isEnabled']);
    }
    return PhoneRule.fromJson(jsonMap);
  }
}
