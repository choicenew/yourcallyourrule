import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'base_call_handler.dart';

// part 指令是代码生成所必需的
part 'should_accept_call_handler.g.dart';

/// 是否接受来电处理器 Provider
///
/// 这是一个简单的、无状态的 Provider。它的作用是创建并提供一个
/// ShouldAcceptCallHandler 的单例。
///
/// 我们不使用 Notifier，因为这个 Handler 不管理需要被全局监听的持久状态。
/// 它的状态（StreamController）是临时的，仅用于协调单次调用。
/// keepAlive: true 确保这个单例在整个应用生命周期中都存在。
@Riverpod(keepAlive: true)
ShouldAcceptCallHandler shouldAcceptCallHandler(Ref ref) {
  // Provider 的创建函数非常简单，只是 new 一个实例并返回。
  return ShouldAcceptCallHandler();
}

/// 是否接受来电处理器
/// 负责处理与是否接受来电相关的方法调用
class ShouldAcceptCallHandler extends BaseCallHandler {
  /// 当前决策控制器，用于在原生调用和Dart端决策之间建立异步桥梁。
  /// 它的生命周期仅限于一次来电询问。
  StreamController<bool>? _currentDecisionController;

 /// 【核心修正】: 将返回类型从 dynamic 修改为 Future<dynamic>
  /// 这是因为我们需要在 case 'shouldAcceptCall' 中返回一个 Future<bool>。
  /// 返回 Future<dynamic> 可以兼容 Future<bool> 和其他非 Future 的返回值。
  /// 或者更精确地，我们可以让它返回 Future<bool>，并在其他 case 中返回一个默认的 Future。
  @override
 Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onShouldAcceptCallInitializationComplete':
        return; // 对于 void 方法，直接 return
      case 'shouldAcceptCall':
        // 这个方法会暂停，直到Dart端的业务逻辑做出决策
        return await _handleShouldAcceptCall();
      default:
        throw UnimplementedError('ShouldAcceptCallHandler: 未实现的方法: ${call.method}');
    }
  }

  /// 处理初始化完成事件。
  void _handleInitializationComplete() {
    // 初始化完成后的处理逻辑（可选）
  }

  /// 处理是否接受来电的核心逻辑。
  /// 当原生代码询问是否应该接听电话时，此方法被调用。
  Future<bool> _handleShouldAcceptCall() async {
    // 1. 为本次询问创建一个新的一次性 StreamController
    _currentDecisionController = StreamController<bool>();

    // 2. 异步等待这个 Stream 上的第一个事件（即决策结果）
    //    `stream.first` 会暂停此处的执行，直到有数据被 add 进来。
    final result = await _currentDecisionController!.stream.first;

    // 3. 收到决策后，关闭 StreamController 以释放资源
    await _currentDecisionController!.close();
    _currentDecisionController = null; // 清理引用

    // 打印日志并返回决策结果给原生代码
    debugPrint("_handleShouldAcceptCall decision returned: $result");
    return result;
  }

  /// 从Dart端的业务逻辑发送决策结果。
  ///
  /// 这个方法会被其他服务（如 IncomingCallHandler）调用，
  /// 以便将过滤和判断的结果发送给正在等待的原生调用。
  /// [shouldAccept] true 表示接听，false 表示拒绝。
  void sendDecision(bool shouldAccept) {
    // 如果存在一个正在等待的 Controller，就将决策结果添加到 Stream 中
    // 这会立即唤醒在 `_handleShouldAcceptCall` 方法中等待的 `await`
    _currentDecisionController?.add(shouldAccept);
  }

  /// 释放资源。
  /// 在处理器被销毁时调用，以确保没有未关闭的 StreamController。
  @override
  Future<void> dispose() async {
    if (_currentDecisionController != null && !_currentDecisionController!.isClosed) {
      await _currentDecisionController!.close();
    }
    _currentDecisionController = null;
    super.dispose();
  }
}