import 'dart:async';

import '../../datasources/remote/remote_number_datasource.dart';

/// A class responsible for determining if a data synchronization is needed.
///
/// This scheduler checks the time of the last successful sync against a
/// configurable interval to decide whether a new sync should be initiated.
class SyncScheduler {
  final RemoteNumberDataSource _dataSource;
  final Duration _syncInterval;

  /// Creates a [SyncScheduler].
  ///
  /// Requires a [RemoteNumberDataSource] to access the last sync time.
  /// The [syncInterval] defaults to 24 hours if not provided.
  SyncScheduler({
    required RemoteNumberDataSource dataSource,
    Duration? syncInterval,
  })  : _dataSource = dataSource,
        _syncInterval = syncInterval ?? const Duration(days: 1);

  /// Determines if a sync is required based on the [_syncInterval].
  ///
  /// Returns `true` if it's the first sync or if the time since the last
  /// sync exceeds the specified interval. Otherwise, returns `false`.
  Future<bool> get needsSync async {
    final lastSyncTime = await _dataSource.getLastSyncTime();
    if (lastSyncTime == null) {
      // If never synced, a sync is needed.
      return true;
    }

    final now = DateTime.now();
    final difference = now.difference(lastSyncTime);

    return difference >= _syncInterval;
  }
}