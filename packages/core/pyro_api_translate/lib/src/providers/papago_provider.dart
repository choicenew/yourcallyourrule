import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'translation_provider.dart';

/// Naver Papago 免 Key 逆向 Provider
/// 对齐 GitHub 顶级开源逆向库的标准实现：自动提取 Session Cookie + PPG HMAC 动态签名
class PapagoProvider extends TranslationProvider {
  static const _homeUrl = 'https://papago.naver.com';
  static const _apiUrl = 'https://papago.naver.com/apis/n2mt/translate';

  static String _authKey = 'v1.8.10_9e022f68fb';
  final String _userAgent;
  final Uuid _uuid = const Uuid();

  PapagoProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  String _generateAuthorization(
      String url, String authKey, String deviceId, int timestamp) {
    final message = '$deviceId\n$url\n$timestamp';
    final keyBytes = utf8.encode(authKey);
    final messageBytes = utf8.encode(message);

    final hmac = Hmac(md5, keyBytes);
    final digest = hmac.convert(messageBytes);
    final signature = base64.encode(digest.bytes);

    return 'PPG $deviceId:$signature';
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final queryText = text.trim();
      if (queryText.isEmpty) return '';

      // 1. 先 GET 主页获取 Naver 颁发的原生 Session Cookie
      final homeResp = await http.get(
        Uri.parse(_homeUrl),
        headers: {'User-Agent': _userAgent},
      ).timeout(const Duration(seconds: 4));

      final rawCookies = homeResp.headers['set-cookie'] ?? '';
      final List<String> parsedCookies = [];
      if (rawCookies.isNotEmpty) {
        for (final item in rawCookies.split(',')) {
          final cookiePart = item.split(';').first.trim();
          if (cookiePart.contains('=')) {
            parsedCookies.add(cookiePart);
          }
        }
      }

      final deviceId = _uuid.v4();
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      var from = sourceLanguage == 'auto' ? 'en' : sourceLanguage;
      var to = targetLanguage;

      if (to == 'zh') to = 'zh-CN';
      if (from == 'zh') from = 'zh-CN';

      final authorization =
          _generateAuthorization(_apiUrl, _authKey, deviceId, timestamp);

      final headers = {
        'User-Agent': _userAgent,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'device-type': 'pc',
        'timestamp': timestamp.toString(),
        'authorization': authorization,
        'x-apigw-partnerid': 'papago',
        'Origin': _homeUrl,
        'Referer': '$_homeUrl/',
        if (parsedCookies.isNotEmpty) 'Cookie': parsedCookies.join('; '),
      };

      final body = {
        'deviceId': deviceId,
        'text': queryText,
        'source': from,
        'target': to,
        'locale': 'en',
        'dict': 'true',
        'dictDisplay': '30',
        'honorific': 'false',
        'instant': 'false',
        'paging': 'false',
      };

      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data['translatedText'] != null) {
          return data['translatedText'].toString().trim();
        }
      }

      throw Exception('Papago returned HTTP ${response.statusCode}: ${response.body}');
    } catch (e) {
      throw Exception('Papago translation failed: $e');
    }
  }
}
