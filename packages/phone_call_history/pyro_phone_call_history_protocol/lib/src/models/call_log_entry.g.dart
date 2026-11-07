// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallLogEntry _$CallLogEntryFromJson(Map<String, dynamic> json) =>
    _CallLogEntry(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      callType: json['callType'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      name: json['name'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$CallLogEntryToJson(_CallLogEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'callType': instance.callType,
      'timestamp': instance.timestamp,
      'durationSeconds': instance.durationSeconds,
      'name': instance.name,
      'location': instance.location,
    };
