/// Supabase 基础设施纯物理连接配置
class SupabaseConfig {
  final String supabaseUrl;
  final String anonKey;
  final String? serviceRoleKey;

  const SupabaseConfig({
    required this.supabaseUrl,
    required this.anonKey,
    this.serviceRoleKey,
  });

  bool get isValid => supabaseUrl.isNotEmpty && anonKey.isNotEmpty;

  Map<String, String> get authHeaders {
    final activeKey = serviceRoleKey != null && serviceRoleKey!.isNotEmpty
        ? serviceRoleKey!
        : anonKey;
    return {
      'Content-Type': 'application/json',
      'apikey': activeKey,
      'Authorization': 'Bearer $activeKey',
    };
  }

  Map<String, String> get defaultHeaders => authHeaders;
}
