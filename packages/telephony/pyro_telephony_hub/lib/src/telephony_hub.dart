import 'package:flutter/foundation.dart';
import 'package:pyro_call_control_hub/pyro_call_control_hub.dart';
import 'package:pyro_call_screening_hub/pyro_call_screening_hub.dart';
import 'package:pyro_call_policy/pyro_call_policy.dart';

/// Unified Grand Facade Orchestrator Hub matching CommercialHub topology.
class TelephonyHub {
  static final TelephonyHub _instance = TelephonyHub._internal();
  static TelephonyHub get instance => _instance;

  TelephonyHub._internal();

  /// Handle incoming gatekeeper screening request and dispatch action atomic orchestration.
  Future<CallActionType> processIncomingCall(IncomingCallEntity call) async {
    debugPrint('[TelephonyHub] Processing incoming call: ${call.phoneNumber}');

    // 1. Evaluate via CallPolicy
    final verdict = CallPolicyEngine.evaluateIncomingCall(
      phoneNumber: call.phoneNumber,
    );

    debugPrint('[TelephonyHub] Policy verdict: ${verdict.action.toCode()} (${verdict.reason})');

    // 2. If verdict is answerThenHangup, register task into CallControlHub & CallControlDriver in memory
    if (verdict.action == CallActionType.answerThenHangup) {
      await CallControlHub.instance.dispatch(
        CallActionContext(
          callId: call.callId,
          phoneNumber: call.phoneNumber,
          actionType: CallActionType.answerThenHangup,
          delayHangupMs: CallControlHub.instance.defaultHangupDelayMs,
          enableMicMuteProtection: CallControlHub.instance.enableMicMuteProtection,
        ),
      );
    }

    return verdict.action;
  }

  /// Hangup active call on behalf of UI user interaction.
  Future<CallExecutionResult> hangupActiveCall({required String callId, required String phoneNumber}) async {
    return await CallControlHub.instance.dispatch(
      CallActionContext(
        callId: callId,
        phoneNumber: phoneNumber,
        actionType: CallActionType.reject,
      ),
    );
  }
}
