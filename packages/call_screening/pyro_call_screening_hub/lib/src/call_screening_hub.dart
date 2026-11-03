import 'package:flutter/foundation.dart';
import 'package:pyro_call_screening_protocol/pyro_call_screening_protocol.dart';
import 'package:pyro_call_policy/pyro_call_policy.dart';

/// IoC Hub and gatekeeper locator for Call Screening.
class CallScreeningHub {
  static final CallScreeningHub _instance = CallScreeningHub._internal();
  static CallScreeningHub get instance => _instance;

  CallScreeningHub._internal();

  ICallScreeningAdapter? _adapter;
  ICallScreeningAdapter? get adapter => _adapter;

  void registerAdapter(ICallScreeningAdapter adapter) {
    _adapter = adapter;
    debugPrint('[CallScreeningHub] Registered CallScreening adapter: ${adapter.providerId}');
  }

  /// Process incoming call gatekeeper screening request.
  Future<CallActionType> evaluateIncomingCall(IncomingCallEntity call) async {
    debugPrint('[CallScreeningHub] Evaluating incoming call from: ${call.phoneNumber}');
    
    final verdict = CallPolicyEngine.evaluateIncomingCall(
      phoneNumber: call.phoneNumber,
    );

    return verdict.action;
  }
}
