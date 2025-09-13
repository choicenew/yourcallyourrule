import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_monitor_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/provider/call_handler_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_event_listener_service.dart';

/// CallEventListenerService 的 Riverpod Provider
/// 用于获取 CallEventListenerService 实例
final callEventListenerProvider = FutureProvider<CallEventListenerService>((ref) async {
  final callLogService = ref.watch(callLogServiceProvider);
  final callHandler = ref.watch(callHandlerProvider);
  // Watch the synchronous provider for CallerIdMonitorService
  final callerIdMonitorService = ref.watch(callerIdMonitorServiceProvider);

  // Manually initialize the service, as its provider doesn't handle it.
  await callerIdMonitorService.initialize();

  final service = CallEventListenerService(
    callLogService,
    callerIdMonitorService,
    callHandler,
  );

  // Initialize the listener service itself
  await service.initialize();

  // Dispose the service when the provider is disposed
  ref.onDispose(() {
    service.dispose();
  });

  return service;
});