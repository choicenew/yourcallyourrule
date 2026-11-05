import 'package:flutter/services.dart';
import 'package:pyro_call_screening_hub/pyro_call_screening_hub.dart';

class CallScreeningDriver implements ICallScreeningAdapter {
  static CallScreeningDriver? _instance;

  static void register() {
    _instance ??= CallScreeningDriver();
    CallScreeningHub.instance.registerAdapter(_instance!);
  }

  static void unregister() {
    _instance?.dispose();
    _instance = null;
  }

  static const MethodChannel _channel = MethodChannel('net.pyro.telephony/call_screening');

  CallScreeningDriver() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  void dispose() {
    _channel.setMethodCallHandler(null);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == 'evaluateCall') {
      final Map<dynamic, dynamic> map = call.arguments is Map ? call.arguments as Map : {};
      final entity = IncomingCallEntity.fromMap(map);
      final action = await onScreeningRequested(entity);
      return {
        'action': action.toCode(),
        'reason': 'Evaluated via CallScreeningHub',
      };
    }
    return null;
  }

  @override
  String get providerId => 'pyro_call_screening_driver';

  @override
  Future<CallActionType> onScreeningRequested(IncomingCallEntity call) async {
    return await CallScreeningHub.instance.evaluateIncomingCall(call);
  }

  Future<bool> isServiceActive() async {
    try {
      final bool? active = await _channel.invokeMethod<bool>('isServiceActive');
      return active ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> isRoleGranted() async {
    try {
      final bool? granted = await _channel.invokeMethod<bool>('isRoleGranted');
      return granted ?? false;
    } on MissingPluginException {
      return false;
    }
  }

  Future<void> requestRole() async {
    try {
      await _channel.invokeMethod('requestRole');
    } on MissingPluginException {
      // Fallback
    }
  }
}
