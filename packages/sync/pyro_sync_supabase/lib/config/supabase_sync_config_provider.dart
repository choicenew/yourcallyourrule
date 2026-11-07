import 'package:pyro_supabase/pyro_supabase.dart';

/// Supabase 个人同步配置与 Key 持久化中枢
class SupabaseSyncConfigStore {
  static final SupabaseSyncConfigStore instance = SupabaseSyncConfigStore._();

  SupabaseSyncConfigStore._();

  String _supabaseUrl = '';
  String _anonKey = '';
  String _serviceRoleKey = '';
  int _syncIntervalHours = 24;

  String get supabaseUrl => _supabaseUrl;
  String get anonKey => _anonKey;
  String get serviceRoleKey => _serviceRoleKey;
  int get syncIntervalHours => _syncIntervalHours;

  bool get isConfigured => _supabaseUrl.isNotEmpty && _anonKey.isNotEmpty;

  /// 更新/修改用户凭证
  void updateConfig({
    required String supabaseUrl,
    required String anonKey,
    String? serviceRoleKey,
    int syncIntervalHours = 24,
  }) {
    _supabaseUrl = supabaseUrl.trim();
    _anonKey = anonKey.trim();
    if (serviceRoleKey != null) {
      _serviceRoleKey = serviceRoleKey.trim();
    }
    _syncIntervalHours = syncIntervalHours;
  }

  /// 导出底层的 SupabaseConfig (供 pyro_supabase 物理基础 SDK 使用)
  SupabaseConfig toInfraConfig() {
    return SupabaseConfig(
      supabaseUrl: _supabaseUrl,
      anonKey: _anonKey,
      serviceRoleKey: _serviceRoleKey.isNotEmpty ? _serviceRoleKey : null,
    );
  }
}
