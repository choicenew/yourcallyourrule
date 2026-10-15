// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_regex_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SmsRegexRule _$SmsRegexRuleFromJson(Map<String, dynamic> json) =>
    _SmsRegexRule(
      id: json['id'] as String,
      name: json['name'] as String,
      action: const RuleActionConverter().fromJson(json['action'] as String),
      contentRegex: json['contentRegex'] as String,
      senderRegex: json['senderRegex'] as String?,
      priority: json['priority'] == null
          ? RulePriority.medium
          : const RulePriorityConverter().fromJson(json['priority']),
      isEnabled: json['isEnabled'] as bool? ?? true,
      labelId: json['labelId'] as String? ?? '',
      ruleType: json['ruleType'] as String? ?? RuleTypeKeys.smsRegex,
    );

Map<String, dynamic> _$SmsRegexRuleToJson(_SmsRegexRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'action': const RuleActionConverter().toJson(instance.action),
      'contentRegex': instance.contentRegex,
      'senderRegex': instance.senderRegex,
      'priority': const RulePriorityConverter().toJson(instance.priority),
      'isEnabled': instance.isEnabled,
      'labelId': instance.labelId,
      'ruleType': instance.ruleType,
    };
