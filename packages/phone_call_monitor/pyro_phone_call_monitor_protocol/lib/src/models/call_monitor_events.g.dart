// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_monitor_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncomingCallEventImpl _$$IncomingCallEventImplFromJson(
        Map<String, dynamic> json) =>
    _$IncomingCallEventImpl(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$IncomingCallEventImplToJson(
        _$IncomingCallEventImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
      'runtimeType': instance.$type,
    };

_$OutgoingCallEventImpl _$$OutgoingCallEventImplFromJson(
        Map<String, dynamic> json) =>
    _$OutgoingCallEventImpl(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$OutgoingCallEventImplToJson(
        _$OutgoingCallEventImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
      'runtimeType': instance.$type,
    };

_$CallEndedEventImpl _$$CallEndedEventImplFromJson(
        Map<String, dynamic> json) =>
    _$CallEndedEventImpl(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CallEndedEventImplToJson(
        _$CallEndedEventImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
      'runtimeType': instance.$type,
    };
