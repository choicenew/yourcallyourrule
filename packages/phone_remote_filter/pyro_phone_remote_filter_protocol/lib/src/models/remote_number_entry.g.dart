// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoteNumberEntry _$RemoteNumberEntryFromJson(Map<String, dynamic> json) =>
    _RemoteNumberEntry(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String?,
      label: json['label'] as String?,
      count: (json['count'] as num?)?.toInt() ?? 0,
      actionType: json['actionType'] as String? ?? 'block',
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$RemoteNumberEntryToJson(_RemoteNumberEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'label': instance.label,
      'count': instance.count,
      'actionType': instance.actionType,
      'isEnabled': instance.isEnabled,
    };
