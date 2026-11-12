import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/call_monitor/services/caller_id_monitor_service.dart';
import 'package:yourcallyourrule/features/call_history/services/call_event_listener_service.dart';

part 'call_event_listener_provider.g.dart';

/// CallEventListenerService Riverpod Provider
@Riverpod(keepAlive: true)
Future<CallEventListenerService> callEventListener(Ref ref) async {
  final callLogService = ref.watch(callLogServiceProvider);
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);

  final callerIdMonitorService = ref.watch(callerIdMonitorServiceProvider);

  final service = CallEventListenerService(
    ref,
    callLogService,
    callerIdMonitorService,
    predefinedLabelService,
  );

  await service.initialize();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
}
