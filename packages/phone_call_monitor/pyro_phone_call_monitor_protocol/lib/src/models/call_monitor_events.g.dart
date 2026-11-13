// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_monitor_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallMonitorEvent _$CallMonitorEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'incoming':
      return IncomingCallEvent.fromJson(json);
    case 'outgoing':
      return OutgoingCallEvent.fromJson(json);
    case 'ended':
      return CallEndedEvent.fromJson(json);
    default:
      return IncomingCallEvent.fromJson(json);
  }
}

Map<String, dynamic> _$CallMonitorEventToJson(CallMonitorEvent instance) =>
    <String, dynamic>{};

IncomingCallEvent _$IncomingCallEventFromJson(Map<String, dynamic> json) =>
    IncomingCallEvent(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IncomingCallEventToJson(IncomingCallEvent instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
    };

OutgoingCallEvent _$OutgoingCallEventFromJson(Map<String, dynamic> json) =>
    OutgoingCallEvent(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OutgoingCallEventToJson(OutgoingCallEvent instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
    };

CallEndedEvent _$CallEndedEventFromJson(Map<String, dynamic> json) =>
    CallEndedEvent(
      phoneNumber: json['phoneNumber'] as String,
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallEndedEventToJson(CallEndedEvent instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
    };
