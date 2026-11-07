import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intercept_event_provider.g.dart';

/// 一个简单的拦截事件数据类
class InterceptEvent {
  final String phoneNumber;
  /// 【修改】: 只传递原始的动作名称字符串 (e.g., "endCall", "answerThenHangup")
  final String actionName; 

  InterceptEvent({required this.phoneNumber, required this.actionName});
}

/// 全局的拦截事件流控制器 Provider
@Riverpod(keepAlive: true)
StreamController<InterceptEvent> interceptEventStreamController(Ref ref) {
  final controller = StreamController<InterceptEvent>.broadcast();
  ref.onDispose(controller.close);
  return controller;
}