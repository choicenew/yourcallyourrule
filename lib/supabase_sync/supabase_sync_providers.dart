import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yourcallyourrule/core/provider/database_provider/local_database_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/device_id_service_provider.dart';

import '../../data/database/local/local_database.dart';
import '../../data/database/sync/device_id_service.dart';
import 'supabase_db_initializer.dart';
import 'supabase_sync_manager.dart';






part 'supabase_sync_providers.g.dart';

/// 配置数据模型
class SupabaseConfig {
  final String url;
  final String anonKey;
  final String connectionString;
  final bool syncCallLogs;

  const SupabaseConfig({
    this.url = '',
    this.anonKey = '',
    this.connectionString = '',
    this.syncCallLogs = false,
  });

  SupabaseConfig copyWith({
    String? url,
    String? anonKey,
    String? connectionString,
    bool? syncCallLogs,
  }) {
    return SupabaseConfig(
      url: url ?? this.url,
      anonKey: anonKey ?? this.anonKey,
      connectionString: connectionString ?? this.connectionString,
      syncCallLogs: syncCallLogs ?? this.syncCallLogs,
    );
  }
}

/// 管理 Supabase 配置的 Notifier (Riverpod 3.0)
@riverpod
class SupabaseConfigNotifier extends _$SupabaseConfigNotifier {
  static const _keyUrl = 'supabase_url';
  static const _keyKey = 'supabase_key';
  static const _keyConn = 'supabase_conn_string';
  static const _keyCallLogs = 'supabase_sync_call_logs';

  @override
  Future<SupabaseConfig> build() async {
    final prefs = await SharedPreferences.getInstance();
    return SupabaseConfig(
      url: prefs.getString(_keyUrl) ?? '',
      anonKey: prefs.getString(_keyKey) ?? '',
      connectionString: prefs.getString(_keyConn) ?? '',
      syncCallLogs: prefs.getBool(_keyCallLogs) ?? false,
    );
  }

  /// 保存配置到本地
  Future<void> saveConfig({
    required String url,
    required String anonKey,
    required String connectionString,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUrl, url);
    await prefs.setString(_keyKey, anonKey);
    await prefs.setString(_keyConn, connectionString);
    
    // 更新 State
    final current = state.value ?? const SupabaseConfig();
    state = AsyncData(current.copyWith(
      url: url,
      anonKey: anonKey,
      connectionString: connectionString,
    ));
  }

  /// 切换是否同步 CallLogs
  Future<void> toggleCallLogs(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyCallLogs, value);
    
    final current = state.value ?? const SupabaseConfig();
    state = AsyncData(current.copyWith(syncCallLogs: value));
  }
}

/// 控制同步操作的 Controller (Riverpod 3.0)
/// 状态为 AsyncValue<SyncResult?>，null 表示未开始
@riverpod
class SupabaseSyncController extends _$SupabaseSyncController {
  @override
  FutureOr<SyncResult?> build() {
    return null;
  }

  /// 初始化数据库结构
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
      // 成功时不返回 SyncResult，但为了状态一致，我们重置为 null 或显示成功消息
      // 这里我们不改变 SyncResult，只是退出 Loading
      state = const AsyncData(null); 
    } catch (e, st) {
      state = AsyncError("DB Init Failed: $e", st);
    }
  }

  /// 执行同步
  Future<void> runSync() async {
    final config = ref.read(supabaseConfigProvider).value;
    if (config == null || config.url.isEmpty || config.anonKey.isEmpty) {
      state = AsyncError("Supabase URL or Key is missing", StackTrace.current);
      return;
    }

    state = const AsyncLoading();
    try {
      // 1. 获取依赖
      // 注意：这里假设你有 databaseProvider 和 deviceIdServiceProvider
      // 如果没有，你需要修改这里的引用方式
      final db = ref.read(localDatabaseProvider); 
      final deviceIdService = ref.read(deviceIdServiceProvider);

      // 2. 创建临时 Client (为了保持独立性)
      final client = SupabaseClient(config.url, config.anonKey);

      // 3. 创建 Manager
      final manager = SupabaseSyncManager(
        localDb: db,
        supabase: client,
        deviceIdService: deviceIdService,
        syncCallLogs: config.syncCallLogs,
      );

      // 4. 运行
      final result = await manager.sync();
      
      if (result.success) {
        state = AsyncData(result);
      } else {
        state = AsyncError(result.errorMessage ?? "Unknown error", StackTrace.current);
      }

      // 关闭 client
      await client.dispose();

    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}