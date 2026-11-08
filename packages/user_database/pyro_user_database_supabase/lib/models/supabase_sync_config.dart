import 'package:pyro_user_database_supabase/interfaces/supabase_sync_database.dart';
import 'package:pyro_user_database_supabase/interfaces/supabase_sync_log.dart';

/// Configuration for Supabase sync
///
/// Create this configuration and provide it via dependency injection
class SupabaseSyncConfig {
  /// Supabase project URL
  final String supabaseUrl;

  /// Supabase anonymous key
  final String supabaseAnonKey;

  /// Postgres connection string (for schema initialization)
  /// Format: postgresql://user:password@host:port/database
  final String? connectionString;

  /// Database implementation (required)
  final SupabaseSyncDatabase database;

  /// Sync log implementation (required)
  final SupabaseSyncLog syncLog;

  /// Function to get current device ID (required for conflict prevention)
  final Future<String> Function() getDeviceId;

  /// Whether to sync call history table (default: false)
  final bool syncCallLogs;

  /// Sync interval in hours (default: 24)
  final int syncIntervalHours;

  /// Last sync time (for incremental sync)
  final DateTime? lastSyncTime;

  const SupabaseSyncConfig({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.database,
    required this.syncLog,
    required this.getDeviceId,
    this.connectionString,
    this.syncCallLogs = false,
    this.syncIntervalHours = 24,
    this.lastSyncTime,
  });

  /// Create a copy with updated fields
  SupabaseSyncConfig copyWith({
    String? supabaseUrl,
    String? supabaseAnonKey,
    String? connectionString,
    SupabaseSyncDatabase? database,
    SupabaseSyncLog? syncLog,
    Future<String> Function()? getDeviceId,
    bool? syncCallLogs,
    int? syncIntervalHours,
    DateTime? lastSyncTime,
  }) {
    return SupabaseSyncConfig(
      supabaseUrl: supabaseUrl ?? this.supabaseUrl,
      supabaseAnonKey: supabaseAnonKey ?? this.supabaseAnonKey,
      connectionString: connectionString ?? this.connectionString,
      database: database ?? this.database,
      syncLog: syncLog ?? this.syncLog,
      getDeviceId: getDeviceId ?? this.getDeviceId,
      syncCallLogs: syncCallLogs ?? this.syncCallLogs,
      syncIntervalHours: syncIntervalHours ?? this.syncIntervalHours,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    );
  }
}
