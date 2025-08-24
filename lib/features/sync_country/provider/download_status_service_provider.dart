import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/features/sync_country/services/download_status_service.dart';

final downloadStatusServiceProvider = Provider<DownloadStatusService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return DownloadStatusService(configRepository);
});