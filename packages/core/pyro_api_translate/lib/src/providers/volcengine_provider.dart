import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// 字节跳动 (ByteDance / 火山引擎) Web 免 Key 逆向 Provider
class VolcengineProvider extends TranslationProvider {
  static const _homeUrl = 'https://translate.volcengine.com';
  static const _apiUrl = 'https://translate.volcengine.com/web/translate/v1/';
  final String _userAgent;

  VolcengineProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  String _mapLanguage(String lang) {
    if (lang == 'zh' || lang == 'zh-CN') return 'zh';
    if (lang == 'zh-TW') return 'zh-Hant';
    if (lang == 'en') return 'en';
    if (lang == 'ja') return 'ja';
    if (lang == 'ko') return 'ko';
    return lang;
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final from = sourceLanguage == 'auto' ? '' : _mapLanguage(sourceLanguage);
      final to = _mapLanguage(targetLanguage);

      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: {
              'User-Agent': _userAgent,
              'Content-Type': 'application/json',
              'Origin': _homeUrl,
              'Referer': '$_homeUrl/',
            },
            body: jsonEncode({
              'text': text,
              'source_language': from,
              'target_language': to,
            }),
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        if (json is Map && json['translation'] != null) {
          return json['translation'].toString().trim();
        } else if (json is Map && json['words'] is List) {
          final words = json['words'] as List;
          final StringBuffer buffer = StringBuffer();
          for (final word in words) {
            if (word is Map && word['translation'] != null) {
              buffer.write(word['translation']);
            }
          }
          final result = buffer.toString().trim();
          if (result.isNotEmpty) {
            return result;
          }
        }
      }

      throw Exception('Volcengine returned status ${response.statusCode}');
    } catch (e) {
      throw Exception('Volcengine translation failed: $e');
    }
  }
}
