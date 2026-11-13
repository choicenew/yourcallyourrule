import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_monitor_events.freezed.dart';

/// 纯数据驱动通话通道事件强实体 (CallMonitorEvent)
@freezed
abstract class CallMonitorEvent with _$CallMonitorEvent {
  const CallMonitorEvent._();

  const factory CallMonitorEvent.incoming({
    required String phoneNumber,
    int? timestamp,
  }) = IncomingCallEvent;

  const factory CallMonitorEvent.outgoing({
    required String phoneNumber,
    int? timestamp,
  }) = OutgoingCallEvent;

  const factory CallMonitorEvent.ended({
    required String phoneNumber,
    int? timestamp,
  }) = CallEndedEvent;

  factory CallMonitorEvent.fromJson(Map<String, dynamic> json) => _$CallMonitorEventFromJson(json);

  factory CallMonitorEvent.fromMap(Map<String, dynamic> map) => CallMonitorEvent.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
