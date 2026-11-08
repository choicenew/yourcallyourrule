import 'dart:async';
import 'dart:isolate';
import 'package:pyro_supabase/pyro_supabase.dart';
import '../config/supabase_sync_config_provider.dart';

/// 个人 Supabase 增量同步管理器
/// 内部自带 Isolate 下沉机制，批量 Map 解包与记录转换绝不占用 UI 主线程
class SupabaseSyncManager {
  final SupabaseSyncConfigStore _configStore;

  SupabaseSyncManager({
    String supabaseUrl = '',
    String anonKey = '',
    String? serviceRoleKey,
    SupabaseSyncConfigStore? configStore,
  }) : _configStore = configStore ?? SupabaseSyncConfigStore.instance {
    if (supabaseUrl.isNotEmpty || anonKey.isNotEmpty) {
      _configStore.updateConfig(
        supabaseUrl: supabaseUrl,
        anonKey: anonKey,
        serviceRoleKey: serviceRoleKey,
      );
    }
  }

  /// 测试与 Supabase 项目的物理网络连通性
  Future<bool> testConnection() async {
    if (!_configStore.isConfigured) return false;
    final dbClient = SupabaseDatabaseClient(
      config: _configStore.toInfraConfig(),
    );
    try {
      final rows = await dbClient.select('');
      return rows.isNotEmpty || rows.isEmpty;
    } catch (_) {
      return false;
    }
  }

  /// 执行推送 (PUSH) 本地数据到 Supabase (后台 Isolate 异步下沉)
  Future<bool> pushChanges(String tableName, List<Map<String, dynamic>> records) async {
    if (!_configStore.isConfigured || records.isEmpty) return false;
    final dbClient = SupabaseDatabaseClient(
      config: _configStore.toInfraConfig(),
    );

    final processedRecords = await Isolate.run(() {
      return records.map((r) => Map<String, dynamic>.from(r)).toList();
    });

    return await dbClient.upsert(tableName, processedRecords);
  }

  /// 从 Supabase 拉取 (PULL) 增量数据 (后台 Isolate 异步下沉)
  Future<List<Map<String, dynamic>>> pullChanges(String tableName) async {
    if (!_configStore.isConfigured) return [];
    final dbClient = SupabaseDatabaseClient(
      config: _configStore.toInfraConfig(),
    );
    final rawRows = await dbClient.select(tableName);

    return await Isolate.run(() {
      return rawRows.map((r) => Map<String, dynamic>.from(r)).toList();
    });
  }
}
