import 'package:pyro_call_control_protocol/pyro_call_control_protocol.dart';

/// Policy evaluation result.
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
    reason: 'Default pass-through policy',
  );
}

/// Pure evaluation policy engine.
class CallPolicyEngine {
  static CallPolicyVerdict evaluateIncomingCall({
    required String phoneNumber,
    bool isBlacklisted = false,
    bool isWhitelisted = false,
    bool isSpamBot = false,
  }) {
    if (isWhitelisted) {
      return const CallPolicyVerdict(
        action: CallActionType.allow,
        reason: 'Matched VIP whitelist rule',
      );
    }
    if (isSpamBot) {
      return const CallPolicyVerdict(
        action: CallActionType.answerThenHangup,
        reason: 'Matched high-frequency autodialer bot rule',
      );
    }
    if (isBlacklisted) {
      return const CallPolicyVerdict(
        action: CallActionType.reject,
        reason: 'Matched spam blacklist rule',
      );
    }
    return CallPolicyVerdict.allow;
  }
}
