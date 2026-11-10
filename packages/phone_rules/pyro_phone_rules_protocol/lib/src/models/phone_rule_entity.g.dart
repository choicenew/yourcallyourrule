// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_rule_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneRuleEntity _$PhoneRuleEntityFromJson(Map<String, dynamic> json) =>
    _PhoneRuleEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      labelId: json['labelId'] as String? ?? '',
      avatar: json['avatar'] as String?,
      subscriptionId: json['subscriptionId'] as String?,
      actionType: json['actionType'] as String? ?? 'block',
      priority: (json['priority'] as num?)?.toInt() ?? 100,
      count: (json['count'] as num?)?.toInt() ?? 0,
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$PhoneRuleEntityToJson(_PhoneRuleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'labelId': instance.labelId,
      'avatar': instance.avatar,
      'subscriptionId': instance.subscriptionId,
      'actionType': instance.actionType,
      'priority': instance.priority,
      'count': instance.count,
      'isEnabled': instance.isEnabled,
    };
