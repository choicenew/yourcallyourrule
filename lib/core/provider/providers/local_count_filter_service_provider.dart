import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import '../../../features/caller_id/providers/caller_id_service_provider.dart';
import 'config_repository_provider.dart';

/// LocalCountFilterService的Provider
final localCountFilterServiceProvider = Provider<LocalCountFilterService>((ref) {
  final callerIdService = ref.watch(callerIdServiceProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  final service = LocalCountFilterService(
    callerIdService: callerIdService,
    configRepository: configRepository,
  );
  service.initialize();
  return service;
});