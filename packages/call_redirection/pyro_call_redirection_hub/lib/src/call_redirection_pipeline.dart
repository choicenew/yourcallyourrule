import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';
import 'call_redirection_hub.dart';

/// Evaluation pipeline orchestrating outbound call pre-dial screening.
class CallRedirectionPipeline {
  final CallRedirectionHub hub;

  CallRedirectionPipeline(this.hub);

  /// Evaluate outbound call against registered driver within strict timeout limit.
  Future<RedirectionDecision> evaluate(OutgoingCallEntity call) async {
    final driver = hub.redirectionDriver;
    if (driver == null) {
      return const RedirectionDecision(
        action: RedirectionAction.proceed,
        description: 'No redirection driver registered in CallRedirectionHub.',
      );
    }

    try {
      return await driver.evaluateOutboundCall(call);
    } catch (_) {
      return const RedirectionDecision(
        action: RedirectionAction.proceed,
        description: 'Pipeline exception, fallback proceed.',
      );
    }
  }
}
