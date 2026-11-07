import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call_policy/evaluators/intercept_action.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/end_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/incoming_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/outgoing_call_handler.dart';

extension IncomingCallHandlerExtension on IncomingCallHandler {
  Future<void> recordIncomingCall(
      String phoneNumber, CallData callData, bool accepted, CallLogRecorder recorder) async {
    await recorder.recordIncomingCall(phoneNumber, callData, accepted);
  }
  
  Future<void> recordRejectedCall(
      String phoneNumber, CallData callData, CallLogRecorder recorder) async {
    await recorder.recordRejectedCall(phoneNumber, callData);
  }
  
  Future<void> recordBlockedCall(
      String phoneNumber, CallData callData, CallLogRecorder recorder) async {
    await recorder.recordBlockedCall(phoneNumber, callData);
  }
  
  Future<void> recordBlockedCallWithOptionalRecorder(String phoneNumber, CallData callData, [CallLogRecorder? recorder]) async {
    if (recorder != null) {
      await recorder.recordBlockedCall(phoneNumber, callData);
    }
  }
}

extension OutgoingCallHandlerExtension on OutgoingCallHandler {
  Future<void> recordOutgoingCall(
      String phoneNumber, CallData callData, CallLogRecorder recorder) async {
    await recorder.recordOutgoingCall(phoneNumber, callData);
  }
  
  Future<void> recordOutgoingCallWithOptionalRecorder(String phoneNumber, CallData callData, [CallLogRecorder? recorder]) async {
    if (recorder != null) {
      await recorder.recordOutgoingCall(phoneNumber, callData);
    }
  }
}

extension CallFilterServiceExtension on CallFilterService {
  static String? _rejectionReason;
  
  void setRejectionReason(String reason) {
    _rejectionReason = reason;
  }
  
  static String? getRejectionReason() {
    return _rejectionReason;
  }
}

extension EndCallHandlerExtension on EndCallHandler {
  static InterceptAction? _interceptAction;
  
  void setInterceptAction(InterceptAction? action) {
    _interceptAction = action;
  }
  
  static InterceptAction? getInterceptAction() {
    return _interceptAction;
  }
}
