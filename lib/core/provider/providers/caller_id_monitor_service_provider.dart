import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service_new.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

import 'call_filter_service_provider.dart';
import 'caller_id_service_provider.dart';
import 'time_interceptor_service_provider.dart';

/// Provider for the CallerIdMonitorService.
///
/// This provider is responsible for creating and providing an instance of [CallerIdMonitorService].
/// It depends on other services like [CallerIdService], [CallFilterService], and [TimeInterceptorService].
final callerIdMonitorServiceProvider = FutureProvider<CallerIdMonitorService>((ref) async {
  final callerIdService = ref.watch(callerIdServiceProvider);
  final callFilterService = ref.watch(callFilterServiceProvider);
  final timeInterceptorService = ref.watch(timeInterceptorServiceProvider);
    // 'await' 新的 localeProvider 加载完成，以获取实际的 Locale 对象
  // 因为函数体现在是 async 的，所以这里可以合法地使用 await
  final currentLocale = await ref.watch(localeProvider.future);

  // Create an instance of the service with its dependencies.
  return CallerIdMonitorService(
    callerIdService,
    callFilterService,
    timeInterceptorService,
    currentLocale, // 传递的是实际的 Locale 对象
  );
});