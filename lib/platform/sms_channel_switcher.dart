import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'android/sms_channel_manager.dart';
import 'ios/sms_platform_manager.dart';

/// 短信通道平台切换器
/// 负责检测当前平台并返回对应的通道管理器实例
class SmsChannelSwitcher {
  /// 获取当前平台的短信通道管理器实例
  static dynamic getPlatformChannelManager() {
    if (_isAndroid()) {
      return AndroidSmsChannelManager();
    } else if (_isIOS()) {
      return IOSSmsPlatformManager();
    } else {
      throw UnsupportedError('当前平台不支持短信通道功能');
    }
  }

  /// 判断当前是否为Android平台
  static bool _isAndroid() {
    return defaultTargetPlatform == TargetPlatform.android;
  }

  /// 判断当前是否为iOS平台
  static bool _isIOS() {
    return defaultTargetPlatform == TargetPlatform.iOS;
  }
}

/// 短信通道接口
/// 定义了短信通道管理器需要实现的方法
abstract class SmsChannelInterface {
  /// 回调函数
  Function(MethodCall)? onSmsCall;

  /// 初始化短信通道
  void initialize();

  /// 初始化短信监听器
  Future<void> initializeSmsListener();

  /// 注销短信监听器
  Future<void> unregisterSmsListener();

  /// 获取默认短信包名
  Future<String?> getDefaultSmsPackage();

  /// 设置短信通知通道重要性
  Future<void> setSmsNotificationChannelImportance(String packageName, int importance);
}