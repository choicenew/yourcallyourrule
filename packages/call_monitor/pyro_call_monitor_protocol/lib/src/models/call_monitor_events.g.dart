// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_monitor_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomingCallEvent _$IncomingCallEventFromJson(Map<String, dynamic> json) =>
    IncomingCallEvent(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$IncomingCallEventToJson(IncomingCallEvent instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
      'runtimeType': instance.$type,
    };

OutgoingCallEvent _$OutgoingCallEventFromJson(Map<String, dynamic> json) =>
    OutgoingCallEvent(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$OutgoingCallEventToJson(OutgoingCallEvent instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
      'runtimeType': instance.$type,
    };

CallEndedEvent _$CallEndedEventFromJson(Map<String, dynamic> json) =>
    CallEndedEvent(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$CallEndedEventToJson(CallEndedEvent instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
      'runtimeType': instance.$type,
    };
