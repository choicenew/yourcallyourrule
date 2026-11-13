import '../models/call_action_context.dart';
import '../models/call_execution_result.dart';

/// Abstract adapter contract for executing physical call control actions.
abstract interface class ICallActionExecutor {
  /// Unique provider identifier for driver registration.
  String get providerId;

  /// Execute a call action (Reject, Silence, Answer-Then-Hangup, Voicemail).
  Future<CallExecutionResult> executeAction(CallActionContext context);

  /// Hardware microphone mute toggle for background privacy protection.
  Future<bool> setMicrophoneMuted(bool muted);
}
