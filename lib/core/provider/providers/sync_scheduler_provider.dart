import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/datasource/remote_number_data_source_provider.dart';
import 'package:yourcallyourrule/data/database/sync/sync_scheduler.dart';



final syncSchedulerProvider = Provider<SyncScheduler>((ref) {
  final remoteNumberDataSource = ref.watch(remoteNumberDataSourceProvider);
  return SyncScheduler(dataSource: remoteNumberDataSource);
});