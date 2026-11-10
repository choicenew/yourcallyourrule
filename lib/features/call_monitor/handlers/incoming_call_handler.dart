import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/call_log_extension.dart';

part 'incoming_call_handler.g.dart';

@Riverpod(keepAlive: true)
Future<IncomingCallHandler> incomingCallHandler(Ref ref) async {
  return IncomingCallHandler();
}

/// 原生通道来电事件接收器
class IncomingCallHandler {
  IncomingCallHandler();

  Future<void> processIncomingCall(String phoneNumber, Function(CallerIdData)? onCallerIdDataReceived, {dynamic simInfo}) async {
    debugPrint("--- [IncomingCallHandler Sensor] Received raw native incoming call: $phoneNumber ---");
  }

  Future<void> handleCallRejection(String phoneNumber, [CallerIdData? callData]) async {
    if (callData != null) {
      recordBlockedCallWithOptionalRecorder(phoneNumber, callData);
    }
  }
}
