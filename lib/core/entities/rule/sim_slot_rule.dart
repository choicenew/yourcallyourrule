import 'package:freezed_annotation/freezed_annotation.dart';
import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';
import 'rule_type.dart';

part 'sim_slot_rule.freezed.dart';
part 'sim_slot_rule.g.dart';

/// SIM卡槽位规则实体 (@freezed + @JsonSerializable 100% 自动生成序列化)
@freezed
abstract class SimSlotRule with _$SimSlotRule implements RuleBase {
  const SimSlotRule._();

  @Implements<RuleBase>()
  const factory SimSlotRule({
    required String id,
    required String name,
    @PhoneNumberConverter() required PhoneNumber phoneNumber,
    required int simSlotIndex,
    @RulePriorityConverter() @Default(RulePriority.medium) RulePriority priority,
    @Default('') String labelId,
    String? avatar,
    @Default(RuleTypeKeys.simSlot) String ruleType,
    @RuleActionConverter() @Default(RuleAction.block) RuleAction action,
    @Default(true) bool isEnabled,
  }) = _SimSlotRule;

  /// 号码过滤匹配逻辑
  @override
  bool matches(String input) {
    return isEnabled && phoneNumber.value == input;
  }

  /// 100% 自动生成 JSON 反序列化
  factory SimSlotRule.fromJson(Map<String, dynamic> json) =>
      _$SimSlotRuleFromJson(json);

  /// 转换 Map (委托给自动生成的 toJson)
  @override
  Map<String, dynamic> toMap() => toJson();

  /// 从 Map 反序列化
  factory SimSlotRule.fromMap(Map<String, dynamic> map) => SimSlotRule.fromJson(map);
}
