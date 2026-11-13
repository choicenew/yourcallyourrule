import 'package:flutter/foundation.dart';
import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';
import 'call_redirection_hub.dart';

/// Pipeline orchestrator evaluating outgoing calls within strict 3000ms deadline
class CallRedirectionPipeline {
  final CallRedirectionHub hub;

  CallRedirectionPipeline(this.hub);

  Future<RedirectionDecision> evaluate(OutgoingCallEntity call) async {
    final driver = hub.activeDriver;
    if (driver == null) {
      return RedirectionDecision.proceed;
    }

    try {
      if (driver.isEmergencyNumber(call.rawPhoneNumber)) {
        return const RedirectionDecision(
          action: RedirectionAction.proceed,
          reason: RedirectionHoldReason.emergencyOverride,
          description: 'Allowed by emergency floor.',
        );
      }

      if (driver.isBypassed(call.rawPhoneNumber)) {
        return const RedirectionDecision(
          action: RedirectionAction.proceed,
          description: 'Allowed by active user bypass token.',
        );
      }

      return await driver.evaluateOutboundCall(call);
    } catch (e) {
      debugPrint('[CallRedirectionPipeline] Error evaluating call: $e');
      return RedirectionDecision.proceed;
    }
  }
}
