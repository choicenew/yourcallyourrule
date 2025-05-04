import 'package:flutter/services.dart';

/// SMS处理器基类
/// 所有SMS处理器都应该继承此类
abstract class BaseSmsHandler {
  /// 处理SMS通道调用
  Future<void> handleSmsChannelCall(MethodCall call) async {}
  
  /// 初始化处理器
  Future<void> initialize() async {}
}

/// SMS处理器工厂
class SmsHandlerFactory {
  T create<T extends BaseSmsHandler>(T handler) {
    return handler;
  }
}