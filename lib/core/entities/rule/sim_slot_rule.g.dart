// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimSlotRule _$SimSlotRuleFromJson(Map<String, dynamic> json) => _SimSlotRule(
  id: json['id'] as String,
  name: json['name'] as String,
  phoneNumber: const PhoneNumberConverter().fromJson(
    json['phoneNumber'] as String,
  ),
  simSlotIndex: (json['simSlotIndex'] as num).toInt(),
  priority: json['priority'] == null
      ? RulePriority.medium
      : const RulePriorityConverter().fromJson(json['priority']),
  labelId: json['labelId'] as String? ?? '',
  avatar: json['avatar'] as String?,
  ruleType: json['ruleType'] as String? ?? RuleTypeKeys.simSlot,
  action: json['action'] == null
      ? RuleAction.block
      : const RuleActionConverter().fromJson(json['action'] as String),
  isEnabled: json['isEnabled'] as bool? ?? true,
);

Map<String, dynamic> _$SimSlotRuleToJson(_SimSlotRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': const PhoneNumberConverter().toJson(instance.phoneNumber),
      'simSlotIndex': instance.simSlotIndex,
      'priority': const RulePriorityConverter().toJson(instance.priority),
      'labelId': instance.labelId,
      'avatar': instance.avatar,
      'ruleType': instance.ruleType,
      'action': const RuleActionConverter().toJson(instance.action),
      'isEnabled': instance.isEnabled,
    };
