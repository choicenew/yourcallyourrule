import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';
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
    await _callLogRecorder.recordIncomingCall(phoneNumber, callerIdData, accepted);
  }
  
  Future<void> handleOutgoingCall(String phoneNumber) async {
    final callerIdData = await _identityService.getCallerId(phoneNumber, Locale.english);
    await _callLogRecorder.recordOutgoingCall(phoneNumber, callerIdData);
  }
  
  Future<void> handleRejectedCall(String phoneNumber) async {
    final callerIdData = await _identityService.getCallerId(phoneNumber, Locale.english);
    await _incomingCallHandler.recordBlockedCallWithOptionalRecorder(phoneNumber, callerIdData, _callLogRecorder);
  }
  
  Future<void> handleBlockedCall(String phoneNumber) async {
    final callerIdData = await _identityService.getCallerId(phoneNumber, Locale.english);
    await _incomingCallHandler.recordBlockedCallWithOptionalRecorder(phoneNumber, callerIdData, _callLogRecorder);
  }
}
