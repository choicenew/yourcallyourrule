import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/call_history/services/system_call_log_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

part 'call_log_recorder.g.dart';

@Riverpod(keepAlive: true)
CallLogRecorder callLogRecorder(Ref ref) {
  final callLogService = ref.watch(callLogServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  return CallLogRecorder(callLogService, predefinedLabelService);
}

/// 通话记录记录器
class CallLogRecorder {
  final CallLogService _callLogService;
  final PredefinedLabelService _predefinedLabelService;
  final Uuid _uuid = const Uuid();

  CallLogRecorder(this._callLogService, this._predefinedLabelService);

  /// 记录来电
  Future<void> recordIncomingCall(String phoneNumber, CallerIdData callData, bool accepted, {DateTime? startTime, DateTime? endTime, int? duration, int? timestamp}) async {
    final callType = accepted ? 'incoming' : 'missed';
    debugPrint('recordIncomingCall: $phoneNumber, $callData, $accepted, $startTime, $endTime, $duration, $timestamp');
    await _recordCall(phoneNumber, callData, callType, startTime: startTime, endTime: endTime, duration: duration, timestamp: timestamp);
  }

  /// 记录去电
  Future<void> recordOutgoingCall(String phoneNumber, CallerIdData callData, {DateTime? startTime, Duration? duration}) async {
    debugPrint('recordOutgoingCall: $phoneNumber, $callData, $startTime, $duration');
    await _recordCall(phoneNumber, callData, 'outgoing', startTime: startTime, duration: duration?.inMilliseconds);
  }

  Future<void> _recordCall(String phoneNumber, CallerIdData callData, String callType, {DateTime? startTime, DateTime? endTime, int? duration, int? timestamp}) async {
    final entry = CallLogEntry(
      id: _uuid.v4(),
      phoneNumber: phoneNumber,
      callType: callType,
      timestamp: timestamp ?? (startTime?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch),
      durationSeconds: duration != null ? (duration ~/ 1000) : 0,
      name: callData.name,
      location: callData.region,
    );
    await _callLogService.addLog(entry);
  }
}
