import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/call_log_extension.dart';

part 'incoming_call_handler.g.dart';

@Riverpod(keepAlive: true)
Future<IncomingCallHandler> incomingCallHandler(Ref ref) async {
  return IncomingCallHandler();
}

/// 纯原生通道来电事件接收器 (Sensor / Event Bridge)
class IncomingCallHandler {
  IncomingCallHandler();

  Future<void> processIncomingCall(String phoneNumber, Function(CallerIdData)? onCallerIdDataReceived, {SimInfo? simInfo}) async {
    debugPrint("--- [IncomingCallHandler Sensor] Received raw native incoming call: $phoneNumber ---");
  }

  Future<void> handleCallRejection(String phoneNumber, [CallData? callData]) async {
    if (callData != null) {
      recordBlockedCallWithOptionalRecorder(phoneNumber, callData);
    }
  }
}
