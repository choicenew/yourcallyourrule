// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regex_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegexRule _$RegexRuleFromJson(Map<String, dynamic> json) => _RegexRule(
  id: json['id'] as String,
  name: json['name'] as String,
  pattern: json['pattern'] as String,
  action: const RuleActionConverter().fromJson(json['action'] as String),
  priority: json['priority'] == null
      ? RulePriority.medium
      : const RulePriorityConverter().fromJson(json['priority']),
  isEnabled: json['isEnabled'] as bool? ?? true,
  ruleType: json['ruleType'] as String? ?? RuleTypeKeys.regex,
  subscriptionId: json['subscriptionId'] as String?,
);

Map<String, dynamic> _$RegexRuleToJson(_RegexRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pattern': instance.pattern,
      'action': const RuleActionConverter().toJson(instance.action),
      'priority': const RulePriorityConverter().toJson(instance.priority),
      'isEnabled': instance.isEnabled,
      'ruleType': instance.ruleType,
      'subscriptionId': instance.subscriptionId,
    };
