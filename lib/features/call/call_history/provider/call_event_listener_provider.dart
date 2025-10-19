// 导入 Riverpod 核心包
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 导入 Riverpod 的代码生成注解包，以便能够使用 @riverpod
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入依赖的服务及其 Provider
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
// 【修正】: 导入 CallerIdMonitorService 的 Provider，而不是类本身
import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service.dart'; 
import 'package:yourcallyourrule/features/call/call_history/services/call_event_listener_service.dart';

// part 指令是代码生成所必需的
part 'call_event_listener_provider.g.dart';

/// CallEventListenerService 的 Riverpod Provider
///
/// 这是一个异步 Provider，因为它依赖于同样是异步的 `callerIdMonitorServiceProvider`。
/// 它的职责是创建并初始化 `CallEventListenerService`，这个服务是应用中用于监听
/// 和响应通话事件（如记录通话日志）的顶层服务。
///
/// 使用 `@Riverpod` 注解和 `keepAlive: true` 来确保服务在应用启动后持续运行。
@Riverpod(keepAlive: true)
Future<CallEventListenerService> callEventListener(Ref ref) async {
  // 1. 从 Provider 中获取所有同步的依赖实例。
  final callLogService = ref.watch(callLogServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);

  // 2. 【核心修正】处理异步依赖 `callerIdMonitorServiceProvider`。
  //    `callerIdMonitorServiceProvider` 是一个 AsyncNotifierProvider，它的 `build` 方法是异步的。
  //    我们必须 `await` 它的 `.future`，以确保 `CallerIdMonitorService` 的所有初始化逻辑
  //    （包括设置原生通道回调）都已经执行完毕。
  await ref.watch(callerIdMonitorServiceProvider.future);

  // 3. 在 `await` 完成后，我们可以安全地通过 `.notifier` 获取到 `CallerIdMonitorService` 的 Notifier 实例。
  //    这个实例包含了我们需要传递给 CallEventListenerService 的公共方法和数据流。
  final callerIdMonitorService = ref.read(callerIdMonitorServiceProvider.notifier);

  // 4. 创建 CallEventListenerService 实例，并将所有依赖注入。
  final service = CallEventListenerService(
    callLogService,
    callerIdMonitorService,
    predefinedLabelService,
  );

  // 5. 调用服务的初始化方法。
  await service.initialize();

  // 6. 注册清理逻辑。当这个 Provider 被销毁时，会自动调用 service.dispose()。
  ref.onDispose(() {
    service.dispose();
  });

  // 7. 返回完全初始化好的服务实例。
  return service;
}