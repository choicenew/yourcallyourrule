import 'package:flutter/services.dart';

class CallScreeningPlugin {
  static const MethodChannel _channel =
      MethodChannel('com.yours.yourcallyourrule/call_screening_plugin');

  static Future<bool> requestCallScreeningRole() async {
    try {
      final bool result =
          await _channel.invokeMethod('requestCallScreeningRole');
      return result;
    } on PlatformException catch (_) {
      return false;
    }
  }

  static Future<bool> isServiceActive() async {
    try {
      final bool? active = await _channel.invokeMethod<bool>('isServiceActive');
      return active ?? false;
    } catch (_) {
      return false;
    }
  }
}
