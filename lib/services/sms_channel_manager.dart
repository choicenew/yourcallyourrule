// sms_channel_manager.dart
import 'package:flutter/services.dart';

class SmsChannelManager {
  static const smsChannel = MethodChannel('com.yours.yourcallyourrule/sms_filter');

  Function(MethodCall)? onSmsCall; // Generic callback for all SMS channel calls


  void initialize() {
    _setupSmsChannel();
  }

  void _setupSmsChannel() {
    smsChannel.setMethodCallHandler((call) async {
      // Debug print
      // 添加日志检查
      onSmsCall?.call(call);
      return null;
    });
  }

  Future<void> initializeSmsListener() async { // Reverted to initialize
    try {
      await smsChannel.invokeMethod('initialize'); // Correct method call
    } on PlatformException catch (e) {
    }
  }

  Future<void> unregisterSmsListener() async {
    try {
      await smsChannel.invokeMethod('unregisterSmsListener');
    } on PlatformException catch (e) {
    }
  }

  Future<String?> getDefaultSmsPackage() async {
    try {
      return await smsChannel.invokeMethod('getDefaultSmsPackage');
    } on PlatformException catch (e) {
      return null;
    }
  }

  Future<void> setSmsNotificationChannelImportance(String packageName, int importance) async {
    await smsChannel.invokeMethod('setSmsNotificationChannelImportance', {
      'packageName': packageName,
      'importance': importance,
    });
  }


}