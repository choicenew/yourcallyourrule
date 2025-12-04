import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_provider.dart';
import 'package:yourcallyourrule/data/repositories/remote/remote_number_repository_impl.dart';
import 'package:yourcallyourrule/core/provider/providers/remote_data_access_restriction_provider.dart';
import 'package:yourcallyourrule/core/provider/datasource/remote_number_data_source_provider.dart';

/// 远程号码仓库提供者
final remoteNumberRepositoryProvider = Provider<RemoteNumberRepositoryImpl>((ref) {
  final remoteNumberDataSource = ref.watch(remoteNumberDataSourceProvider);
  final remoteDataAccessRestriction = ref.watch(remoteDataAccessRestrictionProvider);
  final incrementalSyncManager = ref.watch(incrementalSyncManagerProvider);

  return RemoteNumberRepositoryImpl(
    remoteNumberDataSource,
    remoteDataAccessRestriction,
    incrementalSyncManager,
  );
});