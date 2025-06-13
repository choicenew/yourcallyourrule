import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'remote_number_service_provider.dart';
import 'config_repository_provider.dart';

/// RemoteNumberFilterService的Provider
final remoteNumberFilterServiceProvider = Provider<RemoteNumberFilterService>((ref) {
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  final service = RemoteNumberFilterService(
    remoteNumberService: remoteNumberService,
    configRepository: configRepository,
  );
  service.initialize();
  return service;
});