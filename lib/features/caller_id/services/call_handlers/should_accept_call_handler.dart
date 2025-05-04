import 'dart:async';
import 'package:flutter/services.dart';

import 'base_call_handler.dart';

/// 是否接受来电处理器
/// 负责处理与是否接受来电相关的方法调用
class ShouldAcceptCallHandler extends BaseCallHandler {
  /// 当前决策控制器
  StreamController<bool>? _currentDecisionController;

  @override
  dynamic handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onShouldAcceptCallInitializationComplete':
        return _handleInitializationComplete();
      case 'shouldAcceptCall':
        return await _handleShouldAcceptCall();
      default:
        throw UnimplementedError('未实现的方法: ${call.method}');
    }
  }

  /// 处理初始化完成
  void _handleInitializationComplete() {
    // 初始化完成后的处理逻辑
  }

  /// 处理是否接受来电
  Future<bool> _handleShouldAcceptCall() async {
    _currentDecisionController = StreamController<bool>();
    final result = await _currentDecisionController!.stream.first;
    await _currentDecisionController!.close();
    return result;
  }

  /// 发送决策结果
  void sendDecision(bool shouldAccept) {
    _currentDecisionController?.add(shouldAccept);
  }

  @override
  Future<void> dispose() async {
    await _currentDecisionController?.close();
    _currentDecisionController = null;
  }
}