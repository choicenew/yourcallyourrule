// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceEntity _$DeviceEntityFromJson(Map<String, dynamic> json) =>
    _DeviceEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      model: json['model'] as String,
      lastSyncTime: DateTime.parse(json['lastSyncTime'] as String),
      isActive: json['isActive'] as bool? ?? true,
      deviceInfo: json['deviceInfo'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DeviceEntityToJson(_DeviceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'lastSyncTime': instance.lastSyncTime.toIso8601String(),
      'isActive': instance.isActive,
      'deviceInfo': instance.deviceInfo,
    };
