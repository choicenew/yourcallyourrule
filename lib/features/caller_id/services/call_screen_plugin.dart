import 'package:flutter/services.dart';

class CallScreeningPlugin {
  static const MethodChannel _channel =
      MethodChannel('com.yours.yourcallyourrule/call_screening_plugin');

  static Future<bool> requestCallScreeningRole() async {
    try {
      final bool result =
          await _channel.invokeMethod('requestCallScreeningRole');
      return result;
    } on PlatformException catch (e) {
      return false;
    }
  }
}