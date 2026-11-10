// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regex_rule_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegexRuleEntity _$RegexRuleEntityFromJson(Map<String, dynamic> json) =>
    _RegexRuleEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      pattern: json['pattern'] as String,
      actionType: json['actionType'] as String? ?? 'block',
      priority: (json['priority'] as num?)?.toInt() ?? 100,
      subscriptionId: json['subscriptionId'] as String?,
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$RegexRuleEntityToJson(_RegexRuleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pattern': instance.pattern,
      'actionType': instance.actionType,
      'priority': instance.priority,
      'subscriptionId': instance.subscriptionId,
      'isEnabled': instance.isEnabled,
    };
