import 'package:flutter/foundation.dart';
import 'package:pyro_call_control_protocol/pyro_call_control_protocol.dart';

/// IoC Control Center and Action Dispatcher for Call Control operations.
class CallControlHub {
  static final CallControlHub _instance = CallControlHub._internal();
  static CallControlHub get instance => _instance;

  CallControlHub._internal();

  ICallActionExecutor? _executor;

  /// Global default delay (in ms) for answer-then-hangup action.
  int defaultHangupDelayMs = 1000;

  /// Global toggle for background privacy protection (microphone mute).
  bool enableMicMuteProtection = true;

  /// Register concrete action executor driver.
  void registerExecutor(ICallActionExecutor executor) {
    _executor = executor;
    debugPrint('[CallControlHub] Registered call action executor: ${executor.providerId}');
  }

  /// Dispatch and execute a call action context.
  Future<CallExecutionResult> dispatch(CallActionContext context) async {
    final executor = _executor;
    if (executor == null) {
      debugPrint('[CallControlHub] Warning: No ICallActionExecutor registered!');
      return CallExecutionResult(
        success: false,
        actionType: context.actionType,
        message: 'No ICallActionExecutor registered in CallControlHub',
      );
    }

    // Merge global configuration if not explicitly overridden
    final effectiveContext = CallActionContext(
      callId: context.callId,
      phoneNumber: context.phoneNumber,
      actionType: context.actionType,
      delayHangupMs: context.delayHangupMs == 1000 ? defaultHangupDelayMs : context.delayHangupMs,
      enableMicMuteProtection: enableMicMuteProtection,
      timestampMs: context.timestampMs,
    );

    return await executor.executeAction(effectiveContext);
  }

  /// Hardware microphone mute toggle wrapper.
  Future<bool> setMicrophoneMuted(bool muted) async {
    final executor = _executor;
    if (executor == null) return false;
    return await executor.setMicrophoneMuted(muted);
  }
}
