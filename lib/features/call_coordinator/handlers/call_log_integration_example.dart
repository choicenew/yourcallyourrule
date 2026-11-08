import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/call_log_extension.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/incoming_call_handler.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

class CallLogIntegrationExample {
  final CallerIdentityService _identityService;
  final IncomingCallHandler _incomingCallHandler;
  final CallLogRecorder _callLogRecorder;

  CallLogIntegrationExample({
    required CallerIdentityService identityService,
    required IncomingCallHandler incomingCallHandler,
    required CallLogService callLogService,
    required PredefinedLabelService predefinedLabelService
  }) : 
    _identityService = identityService,
    _incomingCallHandler = incomingCallHandler,
    _callLogRecorder = CallLogRecorder(callLogService, predefinedLabelService);
  
  Future<void> handleIncomingCall(String phoneNumber, {SimInfo? simInfo, bool accepted = true}) async {
    final callerIdData = await _identityService.getCallerId(phoneNumber, Locale.english);
    final callData = CallData(
      callerIdData: callerIdData,
      e164Number: callerIdData.phoneNumber.value,
      nationalNumber: callerIdData.phoneNumber.value,
    );
    await _callLogRecorder.recordIncomingCall(phoneNumber, callData, accepted);
  }
  
  Future<void> handleOutgoingCall(String phoneNumber) async {
    final callerIdData = await _identityService.getCallerId(phoneNumber, Locale.english);
    final callData = CallData(
      callerIdData: callerIdData,
      e164Number: callerIdData.phoneNumber.value,
      nationalNumber: callerIdData.phoneNumber.value,
    );
    await _callLogRecorder.recordOutgoingCall(phoneNumber, callData);
  }
  
  Future<void> handleRejectedCall(String phoneNumber) async {
    final callerIdData = await _identityService.getCallerId(phoneNumber, Locale.english);
    final callData = CallData(
      callerIdData: callerIdData,
      e164Number: callerIdData.phoneNumber.value,
      nationalNumber: callerIdData.phoneNumber.value,
    );
    await _incomingCallHandler.recordRejectedCall(phoneNumber, callData, _callLogRecorder);
  }
  
  Future<void> handleBlockedCall(String phoneNumber) async {
    final callerIdData = await _identityService.getCallerId(phoneNumber, Locale.english);
    final callData = CallData(
      callerIdData: callerIdData,
      e164Number: callerIdData.phoneNumber.value,
      nationalNumber: callerIdData.phoneNumber.value,
    );
    await _incomingCallHandler.recordBlockedCall(phoneNumber, callData, _callLogRecorder);
  }
}
