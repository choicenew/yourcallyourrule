import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pyro_call_control_hub/pyro_call_control_hub.dart';
import 'call_control_channels.dart';

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

  static const MethodChannel _channel = MethodChannel(CallControlChannels.channelName);

  void dispose() {
    // Clean up resources if needed
  }

  @override
  String get providerId => 'pyro_call_control_driver';

  @override
  Future<CallExecutionResult> executeAction(CallActionContext context) async {
    try {
      final Map<dynamic, dynamic>? response = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        CallControlChannels.methodExecuteAction,
        context.toMap(),
      );

      if (response != null) {
        return CallExecutionResult.fromMap(response);
      }

      return CallExecutionResult(
        success: true,
        actionType: context.actionType,
        message: 'Executed ${context.actionType.toCode()} via CallControlDriver',
      );
    } on MissingPluginException {
      return CallExecutionResult(
        success: false,
        actionType: context.actionType,
        message: 'CallControlDriver plugin not attached on current platform',
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
      final bool? success = await _channel.invokeMethod<bool>(
        CallControlChannels.methodSetMicMuted,
        {'muted': muted},
      );
      return success ?? false;
    } on MissingPluginException {
      return false;
    } catch (_) {
      return false;
    }
  }
}
