import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// Lara Translate (Free) - 免 Key 逆向 Provider
/// 1:1 严格基于最新开源 LaraTranslate(Free) 规格实现
class LaraTranslateProvider extends TranslationProvider {
  static const _endpoint = 'https://webapi.laratranslate.com/translate/segmented';
  final String _userAgent;

  static const String _prompt =
      "Your answer should be solely the translation of the given content. In your answer do not add any prefix or suffix to the translated content. Websites' URLs/addresses should be preserved as is in the translation's output. Do not omit any part of the content, even if it seems unimportant. ";

  LaraTranslateProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final queryText = text.trim();
      if (queryText.isEmpty) return '';

      var from = sourceLanguage == 'auto' ? '' : sourceLanguage;
      var to = targetLanguage;

      if (to == 'zh') to = 'zh-CN';
      if (from == 'zh') from = 'zh-CN';

      final headers = {
        'User-Agent': _userAgent,
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'adapt_to': [],
        'content_type': 'text/plain',
        'glossaries': [],
        'instructions': [_prompt],
        'q': queryText,
        'source': from,
        'style': 'faithful',
        'target': to,
      });

      final response = await http
          .post(
            Uri.parse(_endpoint),
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data is Map &&
            data['content'] is Map &&
            data['content']['translations'] is List) {
          final list = data['content']['translations'] as List;
          if (list.isNotEmpty && list[0] is Map && list[0]['translation'] != null) {
            return list[0]['translation'].toString().trim();
          }
        }
      }

      throw Exception('LaraTranslate returned HTTP ${response.statusCode}: ${response.body}');
    } catch (e) {
      throw Exception('LaraTranslate translation failed: $e');
    }
  }
}
