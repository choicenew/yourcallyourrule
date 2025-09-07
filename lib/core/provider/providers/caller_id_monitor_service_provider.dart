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
final callerIdMonitorServiceProvider = Provider<CallerIdMonitorService>((ref) {
  final callerIdService = ref.watch(callerIdServiceProvider);
  final callFilterService = ref.watch(callFilterServiceProvider);
  final timeInterceptorService = ref.watch(timeInterceptorServiceProvider);
  final localeProvider = ref.watch(legacyLocaleProvider);

  // Create an instance of the service with its dependencies.
  return CallerIdMonitorService(
    callerIdService,
    callFilterService,
    timeInterceptorService,
    localeProvider,
  );
});