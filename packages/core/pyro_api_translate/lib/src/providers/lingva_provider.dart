import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// Lingva Translate - 免 Key 开放节点 Provider (专精日韩多语种)
class LingvaProvider extends TranslationProvider {
  static const _endpoint = 'https://lingva.ml/api/v1';
  final String _userAgent;

  LingvaProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final queryText = text.trim();
      if (queryText.isEmpty) return '';

      var from = sourceLanguage == 'auto' ? 'auto' : sourceLanguage;
      var to = targetLanguage;

      if (to == 'zh') to = 'zh';
      if (from == 'zh') from = 'zh';

      final uri = Uri.parse('$_endpoint/$from/$to/${Uri.encodeComponent(queryText)}');

      final response = await http.get(
        uri,
        headers: {'User-Agent': _userAgent},
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data is Map && data['translation'] != null) {
          return data['translation'].toString().trim();
        }
      }

      throw Exception('Lingva returned HTTP ${response.statusCode}');
    } catch (e) {
      throw Exception('Lingva translation failed: $e');
    }
  }
}
