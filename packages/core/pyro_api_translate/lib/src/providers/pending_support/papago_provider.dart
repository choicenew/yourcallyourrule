import 'dart:convert';
import 'package:http/http.dart' as http;
import '../translation_provider.dart';

/// Naver Papago 标准 OpenAPI Provider
/// 1:1 严格对齐 api-evangelist/papago 仓库 (2026年9月最新版) Postman Collection 与 OpenAPI 规格
class PapagoProvider extends TranslationProvider {
  static const _baseUrl = 'https://openapi.naver.com/v1/papago/n2mt';

  final String? clientId;
  final String? clientSecret;

  PapagoProvider({this.clientId, this.clientSecret});

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    if (clientId == null || clientSecret == null || clientId!.isEmpty || clientSecret!.isEmpty) {
      throw Exception('Papago API requires X-Naver-Client-Id and X-Naver-Client-Secret parameters.');
    }

    try {
      final queryText = text.trim();
      if (queryText.isEmpty) return '';

      var from = sourceLanguage == 'auto' ? 'ko' : sourceLanguage;
      var to = targetLanguage;

      if (to == 'zh') to = 'zh-CN';
      if (from == 'zh') from = 'zh-CN';

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Accept': 'application/json',
        'X-Naver-Client-Id': clientId!,
        'X-Naver-Client-Secret': clientSecret!,
      };

      final body = {
        'source': from,
        'target': to,
        'text': queryText,
        'honorific': 'false',
      };

      final response = await http
          .post(
            Uri.parse(_baseUrl),
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data is Map && data['message'] is Map) {
          final result = data['message']['result'];
          if (result is Map && result['translatedText'] != null) {
            return result['translatedText'].toString().trim();
          }
        }
      }

      throw Exception('Papago returned HTTP ${response.statusCode}: ${response.body}');
    } catch (e) {
      throw Exception('Papago translation failed: $e');
    }
  }
}
