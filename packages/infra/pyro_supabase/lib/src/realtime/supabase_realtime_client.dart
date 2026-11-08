import '../config/supabase_config.dart';

/// Realtime 实时 WebSocket 通道 URL 构建与连接底座
class SupabaseRealtimeClient {
  final SupabaseConfig config;

  SupabaseRealtimeClient({required this.config});

  /// 获取用于建立 Realtime WebSocket 长连接的完整 URI
  String getRealtimeWebSocketUrl({required String topic}) {
    if (!config.isValid) return '';
    final baseUrl = config.supabaseUrl.replaceFirst('http', 'ws');
    return '$baseUrl/realtime/v1/websocket?apikey=${config.anonKey}&vsn=1.0.0';
  }
}
