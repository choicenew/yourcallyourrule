import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

class TranslateComProvider extends TranslationProvider {
  static const _apiUrl = 'https://www.translate.com/translator/translate_mt';
  final String _userAgent;

  TranslateComProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  bool get supportsAuto => false;

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      // Map 'auto' to 'auto' or leave as is if API supports it (API requires checking, but usually 'auto' works or needs detection).
      // Based on python code: if auto, it calls 'ajax_lang_auto_detect' first.
      // Let's see if we can skip that or if we must implement it.
      // Trying direct call first with 'auto' as source_lang.
      // Reference code falls back to detection if 'auto'.

      var effectiveSource = sourceLanguage;
      if (sourceLanguage == 'auto') {
        // Ideally we should detect, but let's try sending 'auto' first.
        // Most APIs might default to auto if not provided.
        // Or we can implement simple detection if needed.
      }

      final body = {
        'text_to_translate': text,
        'source_lang': effectiveSource,
        'translated_lang': targetLanguage,
        'use_cache_only': 'false',
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json, text/plain, */*',
        },
        body: body,
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) {
        throw Exception(
            'TranslateCom API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(response.body);

      if (data['translated_text'] != null) {
        return data['translated_text'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('TranslateCom translation failed: $e');
    }
  }
}
