import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/datasource/remote_number_data_source_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/api_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/device_id_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/sync_scheduler_provider.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_remote_database.dart';
import 'package:yourcallyourrule/features/sync_country/provider/country_data_service_provider.dart';
import 'package:yourcallyourrule/features/sync_country/provider/country_selection_provider.dart';
import 'package:yourcallyourrule/features/sync_country/provider/download_status_service_provider.dart';

/// 提供IncrementalSyncManager的Provider
final incrementalSyncManagerProvider = Provider<IncrementalSyncManager>((ref) {
  final remoteNumberDataSource = ref.watch(remoteNumberDataSourceProvider);
  final apiService = ref.watch(apiServiceProvider);
  final deviceIdService = ref.watch(deviceIdServiceProvider);
  final syncScheduler = ref.watch(syncSchedulerProvider);
  final countryDataService = ref.watch(countryDataServiceProvider);
  final countrySelectionService = ref.watch(countrySelectionServiceProvider);
  final downloadStatusService = ref.watch(downloadStatusServiceProvider);

  return IncrementalSyncManager(
    dataSource: remoteNumberDataSource,
    apiService: apiService,
    deviceIdService: deviceIdService,
    syncScheduler: syncScheduler,
    countryDataService: countryDataService,
    countrySelectionService: countrySelectionService,
    downloadStatusService: downloadStatusService,
  );
});