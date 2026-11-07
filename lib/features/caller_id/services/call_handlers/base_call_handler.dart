import 'package:flutter/services.dart';

/// 基础调用处理器抽象类
/// 所有特定类型的调用处理器都应该继承此类
abstract class BaseCallHandler {
  /// 处理方法调用
  /// [call] 方法调用对象
  /// 返回处理结果
  dynamic handleMethodCall(MethodCall call);

  /// 初始化处理器
  Future<void> initialize() async {}

  /// 释放资源
  Future<void> dispose() async {}
}

/// 调用处理器工厂
/// 用于创建和管理不同类型的调用处理器
class CallHandlerFactory {
  final Map<String, BaseCallHandler> _handlers = {};

  /// 注册处理器
  /// [key] 处理器标识
  /// [handler] 处理器实例
  void registerHandler(String key, BaseCallHandler handler) {
    _handlers[key] = handler;
  }

  /// 获取处理器
  /// [key] 处理器标识
  /// 返回对应的处理器实例，如果不存在则返回null
  BaseCallHandler? getHandler(String key) {
    return _handlers[key];
  }

  /// 初始化所有处理器
  Future<void> initializeAll() async {
    for (final handler in _handlers.values) {
      await handler.initialize();
    }
  }

  /// 释放所有处理器资源
  Future<void> disposeAll() async {
    for (final handler in _handlers.values) {
      await handler.dispose();
    }
    _handlers.clear();
  }
}