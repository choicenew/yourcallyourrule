import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call_policy/evaluators/intercept_action.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/end_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/incoming_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/outgoing_call_handler.dart';

extension IncomingCallHandlerExtension on IncomingCallHandler {
  Future<void> recordIncomingCall(
      String phoneNumber, CallerIdData callData, bool accepted, CallLogRecorder recorder) async {
    await recorder.recordIncomingCall(phoneNumber, callData, accepted);
  }

  Future<void> recordBlockedCallWithOptionalRecorder(String phoneNumber, CallerIdData callData, [CallLogRecorder? recorder]) async {
    if (recorder != null) {
      await recorder.recordIncomingCall(phoneNumber, callData, false);
    }
  }
}

extension OutgoingCallHandlerExtension on OutgoingCallHandler {
  Future<void> recordOutgoingCall(
      String phoneNumber, CallerIdData callData, CallLogRecorder recorder) async {
    await recorder.recordOutgoingCall(phoneNumber, callData);
  }

  Future<void> recordOutgoingCallWithOptionalRecorder(String phoneNumber, CallerIdData callData, [CallLogRecorder? recorder]) async {
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
