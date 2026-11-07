import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

class JudicProvider extends TranslationProvider {
  static const _apiUrl = 'https://judic.io/translate/text';
  final String _userAgent;

  // Supports: en, de, fr, nl
  static const _supported = {'en', 'de', 'fr', 'nl'};

  JudicProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      var from = sourceLanguage == 'auto'
          ? 'nl'
          : sourceLanguage; // Ref defaults to 'nl'
      var to = targetLanguage;

      // Judic strictly supports en, de, fr, nl.
      if (!_supported.contains(to)) {
        throw Exception(
            'Judic: Target language $to not supported. Supported: $_supported');
      }
      if (!_supported.contains(from) && from != 'auto') {
        // simple check
        // Maybe it supports more? Ref lists explicit list.
        // Proceed anyway if user insists, or fail?
        // Let's print warning or fail.
      }

      final body = {'sourceText': text, 'inputLang': from, 'outputLang': to};

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/json',
          'Origin': 'https://judic.io',
          'Referer': 'https://judic.io/en/translate',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Judic API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data['translation'] != null) {
        return data['translation'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('Judic translation failed: $e');
    }
  }
}
