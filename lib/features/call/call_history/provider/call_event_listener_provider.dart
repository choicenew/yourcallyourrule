// 文件路径: lib/core/provider/providers/call_event_listener_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_monitor_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_event_listener_service.dart';

// 【简单修复】导入 PredefinedLabelService 的 Provider
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';


/// CallEventListenerService 的 Riverpod Provider
/// 用于获取 CallEventListenerService 实例
final callEventListenerProvider = FutureProvider<CallEventListenerService>((ref) async {
  final callLogService = ref.watch(callLogServiceProvider);
  final callerIdMonitorService = ref.watch(callerIdMonitorServiceProvider);
  // 【简单修复】从 Provider 中获取 PredefinedLabelService 实例
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);

  await callerIdMonitorService.initialize();

  // 【简单修复】调用新的三参数构造函数
  final service = CallEventListenerService(
    callLogService,
    callerIdMonitorService,
    predefinedLabelService, // 把 predefinedLabelService 传进去
  );

  await service.initialize();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});