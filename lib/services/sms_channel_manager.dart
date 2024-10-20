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
     
      onSmsCall?.call(call);
      return null;
    });
  }

  Future<void> initializeSmsListener() async { // Reverted to initialize
    try {
      await smsChannel.invokeMethod('initialize'); // Correct method call
     
    } on PlatformException catch (e) {
     // print("Failed to register SMS flutter端的listener: '${e.message}'.");
    }
  }

  Future<void> unregisterSmsListener() async {
    try {
      await smsChannel.invokeMethod('unregisterSmsListener');
      print("SMS Listener unregistered successfully.");
    } on PlatformException catch (e) {
      print("Failed to unregister SMS listener: '${e.message}'.");
    }
  }

  Future<String?> getDefaultSmsPackage() async {
    try {
      return await smsChannel.invokeMethod('getDefaultSmsPackage');
    } on PlatformException catch (e) {
      print("Failed to get default SMS package name: '${e.message}'.");
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