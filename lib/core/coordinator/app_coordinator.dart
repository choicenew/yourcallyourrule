import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_coordinator.g.dart';

/// 全局 App 中枢协调器 (App Coordinator / Event Mediator)
/// 负责跨 Feature 通信与解耦事件派发，彻底消除 lib/features/X 跨包引用 lib/features/Y
@Riverpod(keepAlive: true)
AppCoordinator appCoordinator(Ref ref) {
  return AppCoordinator(ref);
}

class AppCoordinator {
  final Ref ref;
  final StreamController<Map<String, dynamic>> _eventBus = StreamController.broadcast();

  AppCoordinator(this.ref);

  /// 广播跨模块事件
  void emit(String eventName, [Map<String, dynamic>? payload]) {
    debugPrint('[AppCoordinator] Event emitted: $eventName, payload: $payload');
    _eventBus.add({
      'event': eventName,
      'payload': payload ?? {},
    });
  }

  /// 监听指定跨模块事件
  StreamSubscription<Map<String, dynamic>> on(String eventName, void Function(Map<String, dynamic> payload) callback) {
    return _eventBus.stream.where((event) => event['event'] == eventName).listen((event) {
      callback(event['payload'] as Map<String, dynamic>);
    });
  }
}
