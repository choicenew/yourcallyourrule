/// Result of a sync operation
class SyncResult {
  /// Whether the sync completed successfully
  final bool success;

  /// Number of records pushed to Supabase
  final int pushedCount;

  /// Number of records pulled from Supabase
  final int pulledCount;

  /// Number of records deleted on Supabase
  final int deletedCount;

  /// Error message if sync failed
  final String? errorMessage;

  /// Whether sync was skipped (e.g., not enough time passed)
  final bool skipped;

  const SyncResult({
    this.success = false,
    this.pushedCount = 0,
    this.pulledCount = 0,
    this.deletedCount = 0,
    this.errorMessage,
    this.skipped = false,
  });

  @override
  String toString() {
    if (skipped) return 'SyncResult(skipped)';
    if (!success) return 'SyncResult(failed: $errorMessage)';
    return 'SyncResult(pushed: $pushedCount, pulled: $pulledCount, deleted: $deletedCount)';
  }
}
