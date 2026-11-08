import 'package:riverpod/riverpod.dart';

import 'package:pyro_user_database_supabase/models/supabase_sync_config.dart';
import 'package:pyro_user_database_supabase/models/sync_result.dart';
import 'package:pyro_user_database_supabase/services/supabase_sync_manager.dart';
import 'package:pyro_user_database_supabase/services/db_initializer.dart';

/// Configuration provider - MUST be overridden by host app
///
/// Example override:
/// ```dart
/// ProviderScope(
///   overrides: [
///     supabaseSyncConfigProvider.overrideWithValue(myConfig),
///   ],
///   child: MyApp(),
/// )
/// ```
final supabaseSyncConfigProvider = Provider<SupabaseSyncConfig>((ref) {
  throw UnimplementedError(
    'supabaseSyncConfigProvider must be overridden with your SupabaseSyncConfig. '
    'See README for setup instructions.',
  );
});

/// Sync state provider - holds the current sync result
///
/// This is a simple value holder using Riverpod 3's Provider pattern
final supabaseSyncStateProvider = Provider<AsyncValue<SyncResult?>>((ref) {
  return const AsyncValue.data(null);
});

/// Sync state notifier for managing state
class _SyncStateNotifier extends Notifier<AsyncValue<SyncResult?>> {
  @override
  AsyncValue<SyncResult?> build() {
    return const AsyncValue.data(null);
  }

  void setState(AsyncValue<SyncResult?> value) {
    state = value;
  }
}

final _syncStateNotifierProvider =
    NotifierProvider<_SyncStateNotifier, AsyncValue<SyncResult?>>(() {
  return _SyncStateNotifier();
});

/// Sync controller provider
final supabaseSyncControllerProvider = Provider((ref) {
  return SupabaseSyncController(ref);
});

/// Sync controller implementation
class SupabaseSyncController {
  final Ref _ref;

  SupabaseSyncController(this._ref);

  /// Initialize Supabase database schema
  ///
  /// This should be run once to create tables on Supabase
  Future<void> initializeDatabase() async {
    final config = _ref.read(supabaseSyncConfigProvider);

    if (config.connectionString == null || config.connectionString!.isEmpty) {
      _ref.read(_syncStateNotifierProvider.notifier).setState(
            AsyncValue.error(
              "Connection string is required for database initialization",
              StackTrace.current,
            ),
          );
      return;
    }

    _ref
        .read(_syncStateNotifierProvider.notifier)
        .setState(const AsyncValue.loading());
    try {
      final initializer = SupabaseDbInitializer(config.database);
      await initializer.initializeSchema(config.connectionString!);
      _ref
          .read(_syncStateNotifierProvider.notifier)
          .setState(const AsyncValue.data(null));
    } catch (e, st) {
      _ref
          .read(_syncStateNotifierProvider.notifier)
          .setState(AsyncValue.error("DB Init Failed: $e", st));
    }
  }

  /// Run sync operation
  ///
  /// [force] - If true, ignore sync interval check
  Future<void> runSync({bool force = true}) async {
    final config = _ref.read(supabaseSyncConfigProvider);

    if (config.supabaseUrl.isEmpty || config.supabaseAnonKey.isEmpty) {
      _ref.read(_syncStateNotifierProvider.notifier).setState(
            AsyncValue.error(
              "Supabase URL and Key must be configured",
              StackTrace.current,
            ),
          );
      return;
    }

    _ref
        .read(_syncStateNotifierProvider.notifier)
        .setState(const AsyncValue.loading());
    try {
      final manager = SupabaseSyncManager(
        supabaseUrl: config.supabaseUrl,
        anonKey: config.supabaseAnonKey,
      );

      final isConnected = await manager.testConnection();

      if (isConnected) {
        const result = SyncResult(
          success: true,
        );
        _ref
            .read(_syncStateNotifierProvider.notifier)
            .setState(const AsyncValue.data(result));
      } else {
        const result = SyncResult(
          success: false,
          errorMessage: '无法连接至 Supabase 数据库',
        );
        _ref.read(_syncStateNotifierProvider.notifier).setState(
              AsyncValue.error(
                result.errorMessage ?? "Supabase 连接失败",
                StackTrace.current,
              ),
            );
      }
    } catch (e, st) {
      _ref
          .read(_syncStateNotifierProvider.notifier)
          .setState(AsyncValue.error(e, st));
    }
  }
}
