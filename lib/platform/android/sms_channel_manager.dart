import 'package:flutter/services.dart';

import 'package:yourcallyourrule/common/error/logger.dart';

import '../sms_channel_switcher.dart';


/// Android平台的短信通道管理器实现
class AndroidSmsChannelManager implements SmsChannelInterface {
  // 单例模式
  static final AndroidSmsChannelManager _instance = AndroidSmsChannelManager._internal();
  factory AndroidSmsChannelManager() => _instance;
  AndroidSmsChannelManager._internal();

  // 通道定义
  static const smsChannel = MethodChannel('com.yours.yourcallyourrule/sms_filter');

  // 回调函数
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
          AppLogger.error('初始化短信监听器失败', e);
      
    }
  }

  @override
  Future<void> unregisterSmsListener() async {
    try {
      await smsChannel.invokeMethod('unregisterSmsListener');
    } catch (e) {
      AppLogger.error('注销短信监听器失败', e);
      
    }
  }

  @override
  Future<String?> getDefaultSmsPackage() async {
    try {
      return await smsChannel.invokeMethod('getDefaultSmsPackage');
    } catch (e) {
      AppLogger.error('获取默认短信包名失败', e);
      
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
    AppLogger.error('设置短信通知通道重要性失败', e);
     
    }
  }
}