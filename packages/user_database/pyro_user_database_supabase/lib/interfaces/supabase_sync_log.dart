/// Sync log abstraction for tracking database changes
///
/// Implement this interface to provide change tracking for your database.
/// This is typically implemented using database triggers or watchers.
abstract class SupabaseSyncLog {
  /// Initialize sync triggers/watchers
  ///
  /// This should set up any necessary database triggers or change listeners
  /// to track INSERT, UPDATE, and DELETE operations
  Future<void> initialize();

  /// Get pending changes that need to be synced
  ///
  /// Returns list of all unsynced changes ordered by timestamp
  Future<List<SyncLogEntry>> getChanges();

  /// Clear processed logs after successful sync
  ///
  /// [logIds] - IDs of log entries that have been successfully synced
  Future<void> clearLogs(List<int> logIds);

  /// Get count of pending log entries
  ///
  /// Used to decide whether to force a sync
  Future<int> getLogCount();
}

/// Single sync log entry representing a database change
class SyncLogEntry {
  /// Unique ID of this log entry
  final int id;

  /// Name of the table that was modified
  final String tableName;

  /// Primary key value of the modified record
  final String recordId;

  /// Type of operation: 'INSERT', 'UPDATE', or 'DELETE'
  final String operation;

  /// Timestamp when the change occurred
  final DateTime timestamp;

  const SyncLogEntry({
    required this.id,
    required this.tableName,
    required this.recordId,
    required this.operation,
    required this.timestamp,
  });

  @override
  String toString() =>
      'SyncLogEntry(id: $id, table: $tableName, recordId: $recordId, op: $operation)';
}
