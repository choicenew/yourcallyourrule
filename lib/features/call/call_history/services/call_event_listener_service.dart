import 'dart:async';

import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler_extension.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service_new.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 通话事件监听服务
/// 负责监听来电去电事件，并将通话数据同步到通话记录服务
/// 通过监听 CallerIdMonitorService 的事件流来实现
class CallEventListenerService {
  final CallLogService _callLogService;
  final CallerIdMonitorService _callerIdMonitorService;
    // 【简单修复】 2. 添加 PredefinedLabelService 成员变量
  final PredefinedLabelService _predefinedLabelService;
  final Uuid _uuid = const Uuid();

  // Temporary buffer to store raw call events until CallData is processed
  final Map<String, Map<String, dynamic>> _pendingRawCallEvents = {};

  // Subscription to the raw event stream from CallerIdMonitorService
  StreamSubscription<MethodCall>? _callEventSubscription;
  // Subscription to the processed CallData stream from CallHandler
  StreamSubscription<CallData>? _callDataStreamSubscription;

  late final CallLogRecorder _callLogRecorder;

  CallEventListenerService(
    this._callLogService,
    this._callerIdMonitorService,
        // 【简单修复】 3. 构造函数增加 PredefinedLabelService 参数
    this._predefinedLabelService,
  ) {
    // 【简单修复】 4. 创建 CallLogRecorder 时，把两个服务都传进去
    _callLogRecorder = CallLogRecorder(_callLogService, _predefinedLabelService);
  }

  Future<void> initialize() async {
    // Cancel previous subscriptions to avoid duplicate listeners
    await _callEventSubscription?.cancel();
    await _callDataStreamSubscription?.cancel();

    // Subscribe to the raw event stream from CallerIdMonitorService
    _callEventSubscription =
        _callerIdMonitorService.rawCallEventStream.listen(_handleCallerIdMethodCall);
    debugPrint('CallEventListenerService initialized and is listening to raw call events.');

    // Subscribe to the processed CallData stream from CallHandler
    _callDataStreamSubscription =
        _callerIdMonitorService.callDataStream.listen(_handleProcessedCallData);
    debugPrint('CallEventListenerService is listening to CallHandler callDataStream.');
  }

  /// Process raw method calls from the event stream
  void _handleCallerIdMethodCall(MethodCall call) {
    if (call.arguments is Map<dynamic, dynamic>) {
      final arguments = call.arguments as Map<dynamic, dynamic>;
      final phoneNumber = arguments['phoneNumber'] as String?;

      if (phoneNumber != null) {
        switch (call.method) {
          case 'onIncomingCall':
            _pendingRawCallEvents[phoneNumber] = {
              'type': 'incoming',
              'status': arguments['status'] as String? ?? 'missed',
            };
            debugPrint('Stored incoming raw event for $phoneNumber');
            break;
          case 'onOutgoingCall':
            _pendingRawCallEvents[phoneNumber] = {
              'type': 'outgoing',
              'status': 'answered', // Outgoing calls are typically answered or not
            };
            debugPrint('Stored outgoing raw event for $phoneNumber');
            break;
        }
      }
    }
  }

  /// Handle processed CallData from CallHandler's stream
  Future<void> _handleProcessedCallData(CallData callData) async {
    final phoneNumber = callData.callerIdData.phoneNumber.value;
    debugPrint('Received processed CallData for $phoneNumber: ${callData.toMap()}');

    final rawEvent = _pendingRawCallEvents.remove(phoneNumber);

    if (rawEvent != null) {
      final callType = rawEvent['type'] as String;
      final callStatus = rawEvent['status'] as String;

      debugPrint('Matched CallData with raw event. Type: $callType, Status: $callStatus');

      // Use the richCallData for recording.
      switch (callType) {
        case 'incoming':
          switch (callStatus) {
            case 'accepted':
              await _recordCall(phoneNumber, callData, 'incoming', accepted: true);
              break;
            case 'rejected':
              await _recordCall(phoneNumber, callData, 'rejected');
              break;
            case 'missed':
              await _recordCall(phoneNumber, callData, 'missed');
              break;
            case 'blocked':
              await _recordCall(phoneNumber, callData, 'blocked');
              break;
            default:
              await _recordCall(phoneNumber, callData, 'missed');
          }
          break;
        case 'outgoing':
          await _recordCall(phoneNumber, callData, 'outgoing');
          break;
      }
    } else {
      debugPrint('No matching raw event found for processed CallData for $phoneNumber. It might be an old event or an unmatched scenario.');
    }
  }

  /// Generic method to record a call using CallLogRecorder
  Future<void> _recordCall(String phoneNumber, CallData callData, String callType, {bool? accepted}) async {
    switch (callType) {
      case 'incoming':
        await _callLogRecorder.recordIncomingCall(phoneNumber, callData, accepted ?? true);
        break;
      case 'missed':
        await _callLogRecorder.recordIncomingCall(phoneNumber, callData, false);
        break;
      case 'outgoing':
        await _callLogRecorder.recordOutgoingCall(phoneNumber, callData);
        break;
      case 'rejected':
        await _callLogRecorder.recordRejectedCall(phoneNumber, callData);
        break;
      case 'blocked':
        await _callLogRecorder.recordBlockedCall(phoneNumber, callData);
        break;
    }
  }


  /// Stop the listening service
  void dispose() {
    _callEventSubscription?.cancel();
    _callDataStreamSubscription?.cancel();
    _pendingRawCallEvents.clear();
  }
}