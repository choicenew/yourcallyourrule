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
  
  // 【简单修复】从 Provider 中获取 PredefinedLabelService 实例
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);

  
  // 1. 使用 .future 来获取 Future<CallerIdMonitorService>
  //    然后使用 await 来等待它完成，从而得到 CallerIdMonitorService 的实例
  final callerIdMonitorService = await ref.watch(callerIdMonitorServiceProvider.future);

  // 2. 现在 callerIdMonitorService 是一个真正的实例，可以安全地调用 initialize
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