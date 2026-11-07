import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// 谷歌在线翻译 Provider (基于 GTX 免费 Web 接口，完全适配 LanguageMapper 语言映射)
class GoogleProvider extends TranslationProvider {
  final String _userAgent;

  GoogleProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  Future<String> translate(
    String text, {
    required String targetLanguage,
    String sourceLanguage = 'auto',
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return text;

    try {
      final from = sourceLanguage.trim();
      final to = targetLanguage.trim();

      if (from.isNotEmpty && from.toLowerCase() == to.toLowerCase()) {
        return text;
      }

      final url = Uri.parse(
        'https://translate.googleapis.com/translate_a/single?client=gtx&sl=${Uri.encodeComponent(from)}&tl=${Uri.encodeComponent(to)}&dt=t&q=${Uri.encodeComponent(cleanText)}',
      );

      final res = await http.get(url, headers: {
        'User-Agent': _userAgent,
        'Accept': 'application/json',
      }).timeout(const Duration(seconds: 5));

      if (res.statusCode != 200) {
        throw Exception('Google API HTTP ${res.statusCode}');
      }

      final dynamic data = jsonDecode(utf8.decode(res.bodyBytes));
      if (data is List && data.isNotEmpty && data[0] is List) {
        final List segments = data[0] as List;
        final buffer = StringBuffer();
        for (final seg in segments) {
          if (seg is List && seg.isNotEmpty && seg[0] != null) {
            buffer.write(seg[0].toString());
          }
        }
        final result = buffer.toString().trim();
        return result.isNotEmpty ? result : text;
      }

      return text;
    } catch (e) {
      throw Exception('Google translation failed: $e');
    }
  }
}
