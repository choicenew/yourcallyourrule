import 'dart:async';

import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler_extension.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service_new.dart';

/// 通话事件监听服务
/// 负责监听来电去电事件，并将通话数据同步到通话记录服务
/// 通过监听 CallerIdMonitorService 的事件流来实现
class CallEventListenerService {
  final CallLogService _callLogService;
  final CallerIdMonitorService _callerIdMonitorService;
  final CallHandler _callHandler;
  final Uuid _uuid = const Uuid();

  // Subjects for incoming and outgoing calls
  final _incomingCallSubject = BehaviorSubject<Map<String, dynamic>>();
  final _outgoingCallSubject = BehaviorSubject<Map<String, dynamic>>();

  // Subscription to the raw event stream from CallerIdMonitorService
  StreamSubscription<MethodCall>? _callEventSubscription;
  // Subscription to the merged stream of incoming and outgoing call subjects
  StreamSubscription<Map<String, dynamic>>? _callDataSubscription;

  late final CallLogRecorder _callLogRecorder;

  CallEventListenerService(
    this._callLogService,
    this._callerIdMonitorService,
    this._callHandler,
  ) {
    _callLogRecorder = CallLogRecorder(_callLogService);
  }

  Future<void> initialize() async {
    // Cancel previous subscriptions to avoid duplicate listeners
    await _callEventSubscription?.cancel();
    await _callDataSubscription?.cancel();

    // Subscribe to the raw event stream from CallerIdMonitorService
    _callEventSubscription =
        _callerIdMonitorService.rawCallEventStream.listen(_handleCallerIdMethodCall);
    debugPrint('CallEventListenerService initialized and is listening to raw call events.');

    // Start listening to the processed call subjects
    _startListeningToCallSubjects();
  }

  void _startListeningToCallSubjects() {
    final callStream = Rx.merge([
      _incomingCallSubject.stream.map((data) => {'type': 'incoming', 'data': data}),
      _outgoingCallSubject.stream.map((data) => {'type': 'outgoing', 'data': data}),
    ]);

    _callDataSubscription = callStream.listen((call) {
      if (call['type'] == 'incoming') {
        _handleIncomingCall(call['data'] as Map<String, dynamic>);
      } else {
        _handleOutgoingCall(call['data'] as Map<String, dynamic>);
      }
    });
  }

  /// Process raw method calls from the event stream
  void _handleCallerIdMethodCall(MethodCall call) {
    switch (call.method) {
      case 'onIncomingCall':
        _handleIncomingCallEvent(call.arguments);
        break;
      case 'onOutgoingCall':
        _handleOutgoingCallEvent(call.arguments);
        break;
    }
  }

  /// Process incoming call events and add them to the subject
  void _handleIncomingCallEvent(dynamic arguments) {
    if (arguments is Map<dynamic, dynamic>) {
      final phoneNumber = arguments['phoneNumber'] as String?;
      final callDataMap = arguments['callData'] as Map<dynamic, dynamic>?;
      final status = arguments['status'] as String?;

      final correctedMap = callDataMap != null ? Map<String, dynamic>.from(callDataMap) : null;
      final callData = correctedMap != null ? CallData.fromMap(correctedMap) : null;

      if (phoneNumber != null) {
        _incomingCallSubject.add({
          'phoneNumber': phoneNumber,
          'callData': callData,
          'status': status ?? 'missed'
        });
      }
    }
  }

  /// Process outgoing call events and add them to the subject
  void _handleOutgoingCallEvent(dynamic arguments) {
    if (arguments is Map<dynamic, dynamic>) {
      final phoneNumber = arguments['phoneNumber'] as String?;
      final callDataMap = arguments['callData'] as Map<dynamic, dynamic>?;
      final status = arguments['status'] as String?;

      final correctedMap = callDataMap != null ? Map<String, dynamic>.from(callDataMap) : null;
      final callData = correctedMap != null ? CallData.fromMap(correctedMap) : null;

      if (phoneNumber != null) {
        _outgoingCallSubject.add({
          'phoneNumber': phoneNumber,
          'callData': callData,
          'status': status ?? 'missed'
        });
      }
    }
  }

  /// Handle incoming call logic
  Future<void> _handleIncomingCall(Map<String, dynamic> callData) async {
    final phoneNumber = callData['phoneNumber'] as String?;
    final callDataObj = callData['callData'] as CallData?;
    final callStatus = callData['status'] as String?;
    debugPrint('$phoneNumber $callDataObj $callStatus');
    if (phoneNumber == null) {
      debugPrint('Incoming call processing failed: Phone number is null');
      return;
    }

    if (callDataObj == null) {
      debugPrint('Incoming call processing warning: CallData is null, creating default data');
      final defaultCallData = CallData(
        callerIdData: CallerIdData(
          id: _uuid.v4(),
          phoneNumber: PhoneNumber(phoneNumber),
          numberType: PhoneNumberType.unknown,
          name: phoneNumber,
        ),
        e164Number: phoneNumber,
        nationalNumber: phoneNumber,
      );

      final status = callStatus ?? 'missed';
      await _recordCall(phoneNumber, defaultCallData, status);
      return;
    }

    switch (callStatus) {
      case 'accepted':
        await _recordCall(phoneNumber, callDataObj, 'incoming');
        break;
      case 'rejected':
        await _recordCall(phoneNumber, callDataObj, 'rejected');
        break;
      case 'missed':
        await _recordCall(phoneNumber, callDataObj, 'missed');
        break;
      case 'blocked':
        await _recordCall(phoneNumber, callDataObj, 'blocked');
        break;
      default:
        await _recordCall(phoneNumber, callDataObj, 'missed');
    }
  }

  /// Handle outgoing call logic
  Future<void> _handleOutgoingCall(Map<String, dynamic> callData) async {
    final phoneNumber = callData['phoneNumber'] as String?;
    final callDataObj = callData['callData'] as CallData?;
    debugPrint('Call event listener simInfo: ${callData['callData']?.simInfo?.toMap()}');
    if (phoneNumber == null) {
      debugPrint('Outgoing call processing failed: Phone number is null');
      return;
    }

    if (callDataObj == null) {
      debugPrint('Outgoing call processing warning: CallData is null, creating default data');
      final defaultCallData = CallData(
        callerIdData: CallerIdData(
          id: _uuid.v4(),
          phoneNumber: PhoneNumber(phoneNumber),
          numberType: PhoneNumberType.unknown,
          name: phoneNumber,
        ),
        e164Number: phoneNumber,
        nationalNumber: phoneNumber,
      );

      await _recordCall(phoneNumber, defaultCallData, 'outgoing');
      return;
    }

    await _recordCall(phoneNumber, callDataObj, 'outgoing');
  }

  /// Generic method to record a call
  Future<void> _recordCall(String phoneNumber, CallData callData, String callType) async {
    switch (callType) {
      case 'incoming':
        await _callHandler.saveCallerIdDataWithCallLog(
          phoneNumber,
          callData,
          _callLogRecorder,
          isIncoming: true,
          accepted: true,
        );
        break;
      case 'missed':
        await _callHandler.saveCallerIdDataWithCallLog(
          phoneNumber,
          callData,
          _callLogRecorder,
          isIncoming: true,
          accepted: false,
        );
        break;
      case 'outgoing':
        await _callHandler.saveCallerIdDataWithCallLog(
          phoneNumber,
          callData,
          _callLogRecorder,
          isIncoming: false,
        );
        break;
      case 'rejected':
        await _callHandler.saveCallerIdDataToCache(phoneNumber, callData);
        await _callLogRecorder.recordRejectedCall(phoneNumber, callData);
        break;
      case 'blocked':
        await _callHandler.saveCallerIdDataToCache(phoneNumber, callData);
        await _callLogRecorder.recordBlockedCall(phoneNumber, callData);
        break;
      default:
        await _callHandler.saveCallerIdDataWithCallLog(
          phoneNumber,
          callData,
          _callLogRecorder,
          isIncoming: true,
          accepted: false,
        );
    }
  }

  /// Stop the listening service
  void dispose() {
    _callEventSubscription?.cancel();
    _callDataSubscription?.cancel();
    _incomingCallSubject.close();
    _outgoingCallSubject.close();
  }
}