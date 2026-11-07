// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_phone_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LabelPhoneEntry _$LabelPhoneEntryFromJson(Map<String, dynamic> json) =>
    _LabelPhoneEntry(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      labelId: json['labelId'] as String,
      name: json['name'] as String? ?? '',
      avatar: json['avatar'] as String?,
      icon: json['icon'] as String?,
      priority: (json['priority'] as num?)?.toInt() ?? 100,
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$LabelPhoneEntryToJson(_LabelPhoneEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'labelId': instance.labelId,
      'name': instance.name,
      'avatar': instance.avatar,
      'icon': instance.icon,
      'priority': instance.priority,
      'isEnabled': instance.isEnabled,
    };
