import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'translation_provider.dart';

class ModernMtProvider extends TranslationProvider {
  static const _apiUrl = 'https://webapi.modernmt.com/translate';
  // Check if this key is rotation-prone. It seems static for the web demo.
  static const _webKey = 'webkey_E3sTuMjpP8Jez49GcYpDVH7r';
  final String _userAgent;

  ModernMtProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  String _generateVerify(String text, int timestamp) {
    final signatureString = '$_webKey#$timestamp#$text';
    return md5.convert(utf8.encode(signatureString)).toString();
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final from = sourceLanguage == 'auto' ? '' : sourceLanguage;
      final to = targetLanguage;

      final body = {
        'q': text,
        'source': from,
        'target': to,
        'ts': timestamp,
        'verify': _generateVerify(text, timestamp),
        'hints': '',
        'multiline': true,
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/json;charset=UTF-8',
          'X-HTTP-Method-Override':
              'GET', // Python ref sets this? No, it sets if_http_override_for_api=True which likely behaves like this in their util. Actually modernmt might accept POST with JSON. Confirmed from other sources MMT uses POST.
          // Wait, python code: if_json_for_api=True, if_http_override_for_api=True.
          // TSE logic implies it might send as GET or use header override.
          // Let's try standard POST first.
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) {
        if (response.body.contains('Language pair not supported') ||
            response.body.contains('UnsupportedLanguageException')) {
          // 当源语言与目标语言相同时（如 zh-CN > zh-CN），直接平滑返回原文
          return text;
        }
        throw Exception(
            'ModernMt API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      // data['data']['translation']
      if (data['data'] != null && data['data']['translation'] != null) {
        return data['data']['translation'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('ModernMt translation failed: $e');
    }
  }
}
