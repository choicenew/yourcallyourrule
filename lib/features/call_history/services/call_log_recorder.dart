import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:yourcallyourrule/features/call_history/entities/call_log.dart';
import 'package:yourcallyourrule/features/call_history/entities/local_call_type.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';
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
  Future<void> recordIncomingCall(String phoneNumber, CallData callData, bool accepted, {DateTime? startTime, DateTime? endTime, int? duration, int? timestamp}) async {
    final callType = accepted ? LocalCallType.incoming : LocalCallType.missed;
    debugPrint('recordIncomingCall: $phoneNumber, $callData, $accepted, $startTime, $endTime, $duration, $timestamp');
    await _recordCall(phoneNumber, callData, callType, startTime: startTime, endTime: endTime, duration: duration, timestamp: timestamp);
  }

  /// 记录去电
  Future<void> recordOutgoingCall(String phoneNumber, CallData callData, {DateTime? startTime, Duration? duration}) async {
    debugPrint('recordOutgoingCall: $phoneNumber, callData received, startTime: $startTime, duration: $duration');
    await _recordCall(
      phoneNumber, 
      callData, 
      LocalCallType.outgoing, 
      startTime: startTime, 
      duration: duration?.inMilliseconds 
    );
  }

  /// 记录拒接来电
  Future<void> recordRejectedCall(String phoneNumber, CallData callData, {int? timestamp}) async {
    debugPrint('recordRejectedCall: $phoneNumber, $callData, $timestamp');
    await _recordCall(phoneNumber, callData, LocalCallType.rejected, timestamp: timestamp);
  }

  /// 记录拦截来电
  Future<void> recordBlockedCall(String phoneNumber, CallData callData, {int? timestamp}) async {
    debugPrint('recordBlockedCall: $phoneNumber, $callData, $timestamp');
    await _recordCall(phoneNumber, callData, LocalCallType.blocked, timestamp: timestamp);
  }

  /// 记录静音来电
  Future<void> recordSilencedCall(String phoneNumber, CallData callData, {int? timestamp}) async {
    debugPrint('recordSilencedCall: $phoneNumber, $callData, $timestamp');
    await _recordCall(phoneNumber, callData, LocalCallType.silenced, timestamp: timestamp);
  }
  
  /// 记录通话的通用方法
  Future<void> _recordCall(String phoneNumber, CallData callData, LocalCallType callType, {DateTime? startTime, DateTime? endTime, int? duration, int? timestamp}) async {
    final SimInfo? simInfo = callData.simInfo;
    List<String>? labelIds;

    if (callData.callerIdData.labels != null && callData.callerIdData.labels!.isNotEmpty) {
      final labelTexts = callData.callerIdData.labels!.map((label) => label.label).toList();
      final List<String> foundLabelIds = [];
      
      for (final text in labelTexts) {
        final String? id = await _predefinedLabelService.getLabelIdByText(text);
        if (id != null) {
          foundLabelIds.add(id);
        }
      }
      
      if (foundLabelIds.isNotEmpty) {
        labelIds = foundLabelIds;
      }
    }
   
    final callLog = CallLog(
      id: _uuid.v4(),
      phoneNumber: phoneNumber,
      name: callData.callerIdData.name,
      timestamp: startTime ?? (timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : DateTime.now()),
      endTime: endTime,
      duration: duration,
      simDisplayName: simInfo?.displayName ?? '',
      callType: callType,
      simSlotIndex: simInfo?.simSlotIndex ?? 0,
      carrierName: callData.callerIdData.carrier ?? '',
      countryIso: simInfo?.countryIso ?? '',
      subscriptionId: simInfo?.subscriptionId ?? 0,
      labelIds: labelIds,
    );
    debugPrint('Saving CallLog: ${callLog.toMap()}');
    await _callLogService.addLog(callLog);
  }
}