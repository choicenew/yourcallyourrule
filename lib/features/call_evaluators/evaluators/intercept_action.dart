export 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';

extension InterceptActionExtension on InterceptAction {
  static const List<InterceptAction> values = [
    InterceptAction.endCall,
    InterceptAction.answerThenHangup,
    InterceptAction.silenceNoAnswer,
  ];

  static InterceptAction fromString(dynamic raw) {
    if (raw == null) return InterceptAction.endCall;
    final str = raw.toString().trim();
    switch (str) {
      case 'answerThenHangup':
        return InterceptAction.answerThenHangup;
      case 'silenceNoAnswer':
        return InterceptAction.silenceNoAnswer;
      case 'endCall':
      default:
        return InterceptAction.endCall;
    }
  }
}
