import 'dart:convert';
import 'package:http/http.dart' as http;

/// KOReader (Kosync) 协议进度同步服务
/// 参考 readest 开源项目实施对标，实现与 E-Ink 墨水屏 / KOReader 设备的跨端阅读进度与位置同步
class KosyncService {
  final String serverUrl;
  final String username;
  final String userToken;

  const KosyncService({
    required this.serverUrl,
    required this.username,
    required this.userToken,
  });

  /// 验证 KOReader 账号登录凭证 (/api/users/auth)
  Future<bool> authenticate() async {
    try {
      final uri = Uri.parse('$serverUrl/api/users/auth');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-auth-user': username,
          'x-auth-token': userToken,
        },
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// 推送阅读进度数据到 Kosync 服务器 (/api/syncs/progress)
  Future<bool> pushProgress({
    required String documentHash,
    required String progressCfi,
    required double percentage,
    required int timestamp,
  }) async {
    try {
      final uri = Uri.parse('$serverUrl/api/syncs/progress');
      final body = json.encode({
        'document': documentHash,
        'progress': progressCfi,
        'percentage': percentage,
        'timestamp': timestamp,
        'device': 'PyroReader',
      });

      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-auth-user': username,
          'x-auth-token': userToken,
        },
        body: body,
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// 从 Kosync 服务器拉取阅读进度数据
  Future<Map<String, dynamic>?> pullProgress(String documentHash) async {
    try {
      final uri = Uri.parse('$serverUrl/api/syncs/progress/$documentHash');
      final response = await http.get(
        uri,
        headers: {
          'x-auth-user': username,
          'x-auth-token': userToken,
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}
    return null;
  }
}
