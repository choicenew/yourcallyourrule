import 'package:flutter/services.dart';
import 'package:pyro_call_screening_hub/pyro_call_screening_hub.dart';

class CallScreeningDriver implements ICallScreeningAdapter {
  static void register() {
    CallScreeningHub.instance.registerAdapter(CallScreeningDriver());
  }

  static const MethodChannel _channel = MethodChannel('com.yours.yourcallyourrule/call_screening');

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
}
