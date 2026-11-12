import 'package:flutter/services.dart';
import 'package:yourcallyourrule/features/common/error/logger.dart';
import '../sms_channel_switcher.dart';

class AndroidSmsChannelManager implements SmsChannelInterface {
  static final AndroidSmsChannelManager _instance = AndroidSmsChannelManager._internal();
  factory AndroidSmsChannelManager() => _instance;
  AndroidSmsChannelManager._internal();

  static const smsChannel = MethodChannel('com.yours.yourcallyourrule/sms_filter');

  @override
  Function(MethodCall)? onSmsCall;

  @override
  void initialize() {
    _setupSmsChannel();
  }

  void _setupSmsChannel() {
    smsChannel.setMethodCallHandler((call) async {
      onSmsCall?.call(call);
      return null;
    });
  }

  @override
  Future<void> initializeSmsListener() async {
    try {
      await smsChannel.invokeMethod('initialize');
    } catch (e) {
      AppLogger.error('Failed to initialize SMS listener: $e');
    }
  }

  @override
  Future<void> unregisterSmsListener() async {
    try {
      await smsChannel.invokeMethod('unregisterSmsListener');
    } catch (e) {
      AppLogger.error('Failed to unregister SMS listener: $e');
    }
  }

  @override
  Future<String?> getDefaultSmsPackage() async {
    try {
      return await smsChannel.invokeMethod('getDefaultSmsPackage');
    } catch (e) {
      AppLogger.error('Failed to get default SMS package: $e');
    }
    return null;
  }

  @override
  Future<void> setSmsNotificationChannelImportance(String packageName, int importance) async {
    try {
      await smsChannel.invokeMethod('setSmsNotificationChannelImportance', {
        'packageName': packageName,
        'importance': importance,
      });
    } catch (e) {
      AppLogger.error('Failed to set SMS notification importance: $e');
    }
  }
}
