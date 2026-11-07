// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_slot_rule_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimSlotRuleEntity _$SimSlotRuleEntityFromJson(Map<String, dynamic> json) =>
    _SimSlotRuleEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      simSlotIndex: (json['simSlotIndex'] as num).toInt(),
      labelId: json['labelId'] as String? ?? '',
      avatar: json['avatar'] as String?,
      actionType: json['actionType'] as String? ?? 'block',
      priority: (json['priority'] as num?)?.toInt() ?? 100,
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$SimSlotRuleEntityToJson(_SimSlotRuleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'simSlotIndex': instance.simSlotIndex,
      'labelId': instance.labelId,
      'avatar': instance.avatar,
      'actionType': instance.actionType,
      'priority': instance.priority,
      'isEnabled': instance.isEnabled,
    };
