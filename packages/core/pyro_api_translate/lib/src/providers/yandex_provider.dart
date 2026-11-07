import 'dart:convert';

import 'package:http/http.dart' as http;

import 'translation_provider.dart';

class YandexProvider extends TranslationProvider {
  static const _baseUrl =
      'https://browser.translate.yandex.net/api/v1/tr.json/translate';
  final String _userAgent;

  YandexProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 YaBrowser/24.1.5.825 Yowser/2.5 Safari/537.36';

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final langParam = (sourceLanguage == 'auto')
          ? targetLanguage
          : '$sourceLanguage-$targetLanguage';

      final queryParams = {
        'srv': 'browser_video_translation',
        'text': text,
        'lang': langParam,
      };

      final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);

      print('Yandex (V2): Sending request to $uri');

      // Body derived from reference YandexV2.api_payload
      final body = {
        'maxRetryCount': '2',
        'fetchAbortTimeout': '500',
      };

      final response = await http
          .post(
            uri,
            headers: {
              'User-Agent': _userAgent,
              'Accept': '*/*',
              'Connection': 'keep-alive',
              // 'Content-Type': 'application/x-www-form-urlencoded' is default for http.post map body
            },
            body: body,
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) {
        // Transparent error reporting
        print('Yandex: API Response Body: ${response.body}');
        print('Yandex: API Response Headers: ${response.headers}');
        throw Exception(
            'Yandex API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      // Reference: return data['text'][0]
      if (data is Map && data.containsKey('text') && data['text'] is List) {
        final texts = data['text'] as List;
        if (texts.isNotEmpty) {
          return texts[0].toString();
        }
      }

      throw Exception('Unexpected response format: $data');
    } catch (e) {
      throw Exception('Yandex translation failed: $e');
    }
  }
}
