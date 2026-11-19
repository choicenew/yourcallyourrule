import 'dart:async';
import 'package:pyro_call_control_hub/pyro_call_control_hub.dart';
import 'call_control_api.g.dart';

/// Concrete Flutter implementation of ICallActionExecutor bridging to Native Android.
class CallControlDriver implements ICallActionExecutor {
  static CallControlDriver? _instance;

  /// Static registration helper hook.
  static void register() {
    _instance ??= CallControlDriver();
    CallControlHub.instance.registerExecutor(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  /// Alias helper hook.
  static void ensureMounted() => register();

  final CallControlHostApi _hostApi;

  CallControlDriver({CallControlHostApi? hostApi})
      : _hostApi = hostApi ?? CallControlHostApi();

  void dispose() {
    // Clean up resources if needed
  }

  @override
  String get providerId => 'pyro_call_control_driver';

  @override
  Future<CallExecutionResult> executeAction(CallActionContext context) async {
    try {
      final request = CallControlActionRequest(
        actionType: context.actionType.toCode(),
        phoneNumber: context.phoneNumber,
        delayHangupMs: context.delayHangupMs,
        enableMicMuteProtection: context.enableMicMuteProtection,
      );

      final result = await _hostApi.executeAction(request);

      return CallExecutionResult(
        success: result.success,
        actionType: context.actionType,
        message: result.message,
        executedAt: DateTime.fromMillisecondsSinceEpoch(result.executedAtMs),
      );
    } catch (e) {
      return CallExecutionResult(
        success: false,
        actionType: context.actionType,
        message: 'Native execution error: $e',
      );
    }
  }

  @override
  Future<bool> setMicrophoneMuted(bool muted) async {
    try {
      return await _hostApi.setMicrophoneMuted(muted);
    } catch (_) {
      return false;
    }
  }
}
