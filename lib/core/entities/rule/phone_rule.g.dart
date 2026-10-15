// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneRule _$PhoneRuleFromJson(Map<String, dynamic> json) => _PhoneRule(
  id: json['id'] as String,
  name: json['name'] as String,
  action: const RuleActionConverter().fromJson(json['action'] as String),
  phoneNumber: const PhoneNumberConverter().fromJson(
    json['phoneNumber'] as String,
  ),
  labelId: json['labelId'] as String,
  ruleType: json['ruleType'] as String? ?? RuleTypeKeys.phone,
  priority: json['priority'] == null
      ? RulePriority.medium
      : const RulePriorityConverter().fromJson(json['priority']),
  isEnabled: json['isEnabled'] as bool? ?? true,
  count: (json['count'] as num?)?.toInt() ?? 0,
  avatar: json['avatar'] as String?,
  subscriptionId: json['subscriptionId'] as String?,
);

Map<String, dynamic> _$PhoneRuleToJson(_PhoneRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'action': const RuleActionConverter().toJson(instance.action),
      'phoneNumber': const PhoneNumberConverter().toJson(instance.phoneNumber),
      'labelId': instance.labelId,
      'ruleType': instance.ruleType,
      'priority': const RulePriorityConverter().toJson(instance.priority),
      'isEnabled': instance.isEnabled,
      'count': instance.count,
      'avatar': instance.avatar,
      'subscriptionId': instance.subscriptionId,
    };
