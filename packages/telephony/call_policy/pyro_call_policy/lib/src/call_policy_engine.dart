import 'package:pyro_call_control_protocol/pyro_call_control_protocol.dart';

/// Context entity representing call data required for policy evaluation.
class CallPolicyContext {
  final String callId;
  final String phoneNumber;
  final String normalizedNumber;
  final int simSlot;
  final int timestampMs;

  const CallPolicyContext({
    required this.callId,
    required this.phoneNumber,
    required this.normalizedNumber,
    this.simSlot = 0,
    int? timestampMs,
  }) : timestampMs = timestampMs ?? 0;
}

/// Policy evaluation result data entity.
class CallPolicyVerdict {
  final CallActionType action;
  final String reason;
  final double confidenceScore;

  const CallPolicyVerdict({
    required this.action,
    required this.reason,
    this.confidenceScore = 1.0,
  });

  static const CallPolicyVerdict allow = CallPolicyVerdict(
    action: CallActionType.allow,
    reason: 'Pass-through policy',
  );
}

/// Standard abstract interface contract for Call Policy Evaluator adapters.
abstract interface class ICallPolicyEvaluator {
  String get providerId;
  Future<CallPolicyVerdict> evaluateCall(CallPolicyContext context);
}

/// Pure, zero-business-logic CallPolicy engine facade.
class CallPolicyEngine {
  static ICallPolicyEvaluator? _evaluator;

  /// Register custom policy evaluator adapter
  static void registerEvaluator(ICallPolicyEvaluator evaluator) {
    _evaluator = evaluator;
  }

  /// Clear registered policy evaluator
  static void clearEvaluator() {
    _evaluator = null;
  }

  /// Evaluate incoming call by delegating directly to registered evaluator adapter.
  static Future<CallPolicyVerdict> evaluateCall(CallPolicyContext context) async {
    if (_evaluator != null) {
      return await _evaluator!.evaluateCall(context);
    }
    return CallPolicyVerdict.allow;
  }
}
