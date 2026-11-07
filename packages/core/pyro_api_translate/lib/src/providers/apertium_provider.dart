import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// Apertium 开源规则翻译 Provider
class ApertiumProvider extends TranslationProvider {
  static const _apiUrl = 'https://apertium.org/apy/translate';
  final String _userAgent;

  ApertiumProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      var from = sourceLanguage;
      var to = targetLanguage;

      if (from == 'en') from = 'eng';
      if (to == 'en') to = 'eng';
      if (from == 'es') from = 'spa';
      if (to == 'es') to = 'spa';

      final langpair = '$from|$to';

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'q': text, 'langpair': langpair, 'markUnknown': 'no'},
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) {
        throw Exception(
            'Apertium API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data['responseData'] != null &&
          data['responseData']['translatedText'] != null) {
        return data['responseData']['translatedText'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('Apertium translation failed: $e');
    }
  }
}
