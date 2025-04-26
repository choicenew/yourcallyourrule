import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'android/call_channel_manager.dart';
import 'ios/call_platform_manager.dart';

/// 通话通道平台切换器
/// 负责检测当前平台并返回对应的通道管理器实例
class CallChannelSwitcher {
  /// 获取当前平台的通话通道管理器实例
  static dynamic getPlatformChannelManager() {
    if (_isAndroid()) {
      return AndroidCallChannelManager();
    } else if (_isIOS()) {
      return IOSCallPlatformManager();
    } else {
      throw UnsupportedError('当前平台不支持通话通道功能');
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

/// 通话通道接口
/// 定义了通话通道管理器需要实现的方法
abstract class CallChannelInterface {
  /// 回调函数
  Function(MethodCall)? onCallerIdCall;
  Function(MethodCall)? onStirCall;
  Function(MethodCall)? onSimCall;
  Future<bool> Function(MethodCall)? onShouldAcceptCallCall;
  Future<String?> Function(MethodCall)? onEndCallCall;

  /// 初始化所有通道
  void initialize();

  /// 初始化来电显示服务
  Future<void> initializeCallerId();
}