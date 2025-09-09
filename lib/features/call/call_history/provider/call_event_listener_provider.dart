import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/provider/call_handler_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_event_listener_service.dart';

/// CallEventListenerService 的 Riverpod Provider
/// 用于获取 CallEventListenerService 实例
/// 使用 core/provider/providers/call_log_service_provider.dart 中的 callLogServiceProvider
final callEventListenerProvider = Provider<CallEventListenerService>((ref) {
  final callLogService = ref.watch(callLogServiceProvider);
  final callHandler = ref.watch(callHandlerProvider);
  final service = CallEventListenerService(callLogService, callHandler);

  // 自动开始监听
  service.startListening();

  // 当Provider被销毁时，自动释放资源
  ref.onDispose(() {
    service.dispose();
  });

  return service;
});