import '../models/outgoing_call_entity.dart';
import '../models/redirection_decision.dart';

/// Abstract adapter contract for outbound call redirection evaluation.
abstract class ICallRedirectionAdapter {
  /// Evaluate an outbound call attempt within strict 3000ms deadline.
  Future<RedirectionDecision> evaluateOutboundCall(OutgoingCallEntity call);

  /// Check if a phone number is an emergency number (Emergency Floor).
  bool isEmergencyNumber(String rawNumber);

  /// Check if a number is currently in the user "Call Anyway" temporary bypass token cache.
  bool isBypassed(String phoneNumber);

  /// Add a temporary bypass token for a phone number.
  Future<void> addBypassToken(String phoneNumber, {Duration duration = const Duration(minutes: 15)});
}
