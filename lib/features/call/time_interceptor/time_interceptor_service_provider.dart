import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/service/time_interceptor_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/call_log_repository_provider.dart';
import '../../../core/provider/providers/config_repository_provider.dart';

/// TimeInterceptorService的Provider
final timeInterceptorServiceProvider = Provider<TimeInterceptorService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  final callLogRepository = ref.watch(callLogRepositoryProvider);
  final service = TimeInterceptorService(configRepository, callLogRepository);
  service.initialize();
  return service;
});