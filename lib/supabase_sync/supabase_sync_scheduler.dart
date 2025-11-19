import 'package:shared_preferences/shared_preferences.dart';

class SupabaseSyncScheduler {
  // 使用独立的 Key，防止与现有系统冲突
  static const String _prefKeyLastSync = 'supabase_user_sync_last_timestamp';
  
  // 默认同步间隔，例如 1 小时
  final Duration _syncInterval;

  SupabaseSyncScheduler({Duration? interval}) 
      : _syncInterval = interval ?? const Duration(hours: 1);

  /// 检查是否需要同步
  Future<bool> get needsSync async {
    final lastSync = await getLastSyncTime();
    if (lastSync == null) return true; // 从未同步过

    final diff = DateTime.now().difference(lastSync);
    return diff >= _syncInterval;
  }

  /// 获取上次同步时间
  Future<DateTime?> getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_prefKeyLastSync);
    return str != null ? DateTime.tryParse(str) : null;
  }

  /// 更新同步时间为当前
  Future<void> markSyncSuccess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKeyLastSync, DateTime.now().toIso8601String());
  }
}