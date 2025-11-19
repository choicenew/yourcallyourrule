import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yourcallyourrule/cloud_sync/provider/backup_restore_provider.dart';
import 'package:yourcallyourrule/core/provider/database_provider/local_database_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/device_id_service_provider.dart';

import 'supabase_db_initializer.dart';
import 'supabase_sync_manager.dart';
import 'sync_log_service.dart';






part 'supabase_sync_providers.g.dart';

/// 配置数据模型
class SupabaseConfig {
  final String url;
  final String anonKey;
  final String connectionString;
  final bool syncCallLogs;
  final bool isMasterDevice;
  final int syncIntervalHours;
  final String? lastSyncTimestamp;

  const SupabaseConfig({
    this.url = '',
    this.anonKey = '',
    this.connectionString = '',
    this.syncCallLogs = false,
    this.isMasterDevice = true,
    this.syncIntervalHours = 24,
    this.lastSyncTimestamp,
  });

  SupabaseConfig copyWith({
    String? url,
    String? anonKey,
    String? connectionString,
    bool? syncCallLogs,
    bool? isMasterDevice,
    int? syncIntervalHours,
    String? lastSyncTimestamp,
  }) {
    return SupabaseConfig(
      url: url ?? this.url,
      anonKey: anonKey ?? this.anonKey,
      connectionString: connectionString ?? this.connectionString,
      syncCallLogs: syncCallLogs ?? this.syncCallLogs,
      isMasterDevice: isMasterDevice ?? this.isMasterDevice,
      syncIntervalHours: syncIntervalHours ?? this.syncIntervalHours,
      lastSyncTimestamp: lastSyncTimestamp ?? this.lastSyncTimestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'anonKey': anonKey,
      'connectionString': connectionString,
      'syncCallLogs': syncCallLogs,
      'isMasterDevice': isMasterDevice,
      'syncIntervalHours': syncIntervalHours,
      'lastSyncTimestamp': lastSyncTimestamp,
    };
  }

  factory SupabaseConfig.fromMap(Map<String, dynamic> map) {
    return SupabaseConfig(
      url: map['url'] as String? ?? '',
      anonKey: map['anonKey'] as String? ?? '',
      connectionString: map['connectionString'] as String? ?? '',
      syncCallLogs: map['syncCallLogs'] as bool? ?? false,
      isMasterDevice: map['isMasterDevice'] as bool? ?? true,
      syncIntervalHours: map['syncIntervalHours'] as int? ?? 24,
      lastSyncTimestamp: map['lastSyncTimestamp'] as String?,
    );
  }
}

// ✅ 注册 SyncLogService Provider
@riverpod
SyncLogService syncLogService(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return SyncLogService(db);
}

/// 管理配置的 Notifier
@riverpod
class SupabaseConfigNotifier extends _$SupabaseConfigNotifier {
  static const _configKey = 'config_supabase_settings';

  @override
  Future<SupabaseConfig> build() async {
    final repo = ref.watch(configRepositoryProvider);
    final json = await repo.getConfig(_configKey);
    if (json != null) {
      return SupabaseConfig.fromMap(json);
    }
    return const SupabaseConfig();
  }

  Future<void> _saveToRepo(SupabaseConfig config) async {
    final repo = ref.read(configRepositoryProvider);
    await repo.saveConfig(_configKey, config.toMap());
    state = AsyncData(config);
  }

  Future<void> saveSettings({
    required String url,
    required String anonKey,
    required String connectionString,
  }) async {
    final current = state.value ?? const SupabaseConfig();
    await _saveToRepo(current.copyWith(
      url: url,
      anonKey: anonKey,
      connectionString: connectionString,
    ));
  }

  Future<void> toggleCallLogs(bool value) async {
    final current = state.value ?? const SupabaseConfig();
    await _saveToRepo(current.copyWith(syncCallLogs: value));
  }

  Future<void> toggleMasterDevice(bool value) async {
    final current = state.value ?? const SupabaseConfig();
    await _saveToRepo(current.copyWith(isMasterDevice: value));
  }

  Future<void> setSyncInterval(int hours) async {
    final current = state.value ?? const SupabaseConfig();
    await _saveToRepo(current.copyWith(syncIntervalHours: hours));
  }

  Future<void> updateLastSyncTime(DateTime time) async {
    final current = state.value ?? const SupabaseConfig();
    await _saveToRepo(current.copyWith(lastSyncTimestamp: time.toIso8601String()));
  }
}

/// 控制同步逻辑的 Controller
@riverpod
class SupabaseSyncController extends _$SupabaseSyncController {
  @override
  FutureOr<SyncResult?> build() {
    return null;
  }

  Future<void> initializeDatabase() async {
    final config = ref.read(supabaseConfigProvider).value;
    if (config == null || config.connectionString.isEmpty) {
      state = AsyncError("Connection string is missing", StackTrace.current);
      return;
    }
    state = const AsyncLoading();
    try {
      final initializer = SupabaseDbInitializer();
      await initializer.initializeSchema(config.connectionString);
      state = const AsyncData(null); 
    } catch (e, st) {
      state = AsyncError("DB Init Failed: $e", st);
    }
  }

  Future<void> runSync({bool force = true}) async {
    final config = ref.read(supabaseConfigProvider).value;
    if (config == null || config.url.isEmpty || config.anonKey.isEmpty) {
      state = AsyncError("Supabase URL or Key is missing", StackTrace.current);
      return;
    }

    state = const AsyncLoading();
    try {
      final db = ref.read(localDatabaseProvider); 
      final deviceIdService = ref.read(deviceIdServiceProvider);
      final logService = ref.read(syncLogServiceProvider); // ✅ 使用 Provider
      
      // 创建临时 Client
      final client = SupabaseClient(config.url, config.anonKey);

      DateTime? lastSync;
      if (config.lastSyncTimestamp != null) {
        lastSync = DateTime.tryParse(config.lastSyncTimestamp!);
      }

      final manager = SupabaseSyncManager(
        localDb: db,
        supabase: client,
        deviceIdService: deviceIdService,
        logService: logService,
        syncCallLogs: config.syncCallLogs,
        lastSyncTime: lastSync,
        syncIntervalHours: config.syncIntervalHours,
      );

      final result = await manager.sync(force: force);
      await client.dispose();

      if (result.success) {
        if (!result.skipped) {
          final now = DateTime.now().toUtc();
          await ref.read(supabaseConfigProvider.notifier).updateLastSyncTime(now);
        }
        state = AsyncData(result);
      } else {
        state = AsyncError(result.errorMessage ?? "Unknown error", StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}