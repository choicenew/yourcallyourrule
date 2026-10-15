import 'package:freezed_annotation/freezed_annotation.dart';
import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import 'rule_base.dart';
import 'rule_type.dart';

part 'sim_slot_rule.freezed.dart';

/// SIM卡槽位规则实体 (@freezed 自动生成不可变数据类)
@freezed
abstract class SimSlotRule with _$SimSlotRule implements RuleBase {
  const SimSlotRule._();

  @Implements<RuleBase>()
  const factory SimSlotRule({
    required String id,
    required String name,
    required PhoneNumber phoneNumber,
    required int simSlotIndex,
    @Default(RulePriority.medium) RulePriority priority,
    @Default('') String labelId,
    String? avatar,
    @Default(RuleTypeKeys.simSlot) String ruleType,
    @Default(RuleAction.block) RuleAction action,
    @Default(true) bool isEnabled,
  }) = _SimSlotRule;

  /// 号码过滤匹配逻辑
  @override
  bool matches(String input) {
    return isEnabled && phoneNumber.value == input;
  }

  @override
  String toJson() => toMap().toString();

  /// 格式化转换 Map
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'priority': priority.value,
      'phoneNumber': phoneNumber.value,
      'simSlotIndex': simSlotIndex,
      'labelId': labelId,
      'avatar': avatar,
      'isEnabled': isEnabled ? 1 : 0,
      'ruleType': ruleType,
      'action': action.toString(),
    };
  }

  /// 从 Map 反序列化生成实体
  factory SimSlotRule.fromMap(Map<String, dynamic> map) {
    return SimSlotRule(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      priority: RulePriority.fromInt(map['priority']),
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']?.toString() ?? ''),
      simSlotIndex: (map['simSlotIndex'] as num?)?.toInt() ?? 0,
      labelId: map['labelId']?.toString() ?? '',
      avatar: map['avatar']?.toString(),
      ruleType: map['ruleType']?.toString() ?? RuleTypeKeys.simSlot,
      action: RuleAction.fromString(map['action']),
      isEnabled: (map['isEnabled'] ?? 1) == 1 || map['isEnabled'] == true,
    );
  }
}
