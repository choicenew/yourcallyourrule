import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pyro_api_translate/src/providers/translation_provider.dart';
import 'package:pyro_api_translate/src/models/translation_config.dart';

class WordviceProvider extends TranslationProvider {
  static const String _v2ApiUrl =
      'https://sysapi.wordvice.ai/tools/v2/non-member/translate';
  static const String _llmApiUrl =
      'https://sysapi.wordvice.ai/tools/non-member/fetch-llm-result';

  final TranslationConfig config;
  final bool useLlm;

  WordviceProvider(
      {this.config = const TranslationConfig(), this.useLlm = false});

  String get name => useLlm ? 'WordviceLLM' : 'Wordvice';

  bool get isKeyless => true;

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    final from = sourceLanguage == 'auto'
        ? 'English'
        : sourceLanguage; // V2 defaults 'English' if auto? v3.js says 'Indonesian' default, we usually do auto/en.
    final to = targetLanguage;

    if (useLlm) {
      return _translateLlm(text, from, to);
    } else {
      return _translateV2(text, from, to);
    }
  }

  String? _cleanExtractText(dynamic node) {
    if (node == null) return null;
    if (node is String) {
      final str = node.trim();
      if (str.isEmpty || str.startsWith('{') || str.startsWith('[')) return null;
      return str;
    }
    if (node is List) {
      final StringBuffer sb = StringBuffer();
      for (final item in node) {
        final txt = _cleanExtractText(item);
        if (txt != null) sb.write(txt);
      }
      final res = sb.toString().trim();
      return res.isNotEmpty ? res : null;
    }
    if (node is Map) {
      if (node['text'] != null) return _cleanExtractText(node['text']);
      if (node['data'] != null) return _cleanExtractText(node['data']);
      if (node['translation'] != null) return _cleanExtractText(node['translation']);
    }
    return null;
  }

  Future<String> _translateV2(String text, String from, String to) async {
    try {
      final response = await http.post(
        Uri.parse(_v2ApiUrl),
        headers: {
          'accept': 'application/json',
          'accept-language': 'id-ID', // Mimic reference v3.js
          'cache-control': 'no-cache',
          'content-type': 'application/json;charset=UTF-8',
          'origin': 'https://wordvice.ai',
          'referer': 'https://wordvice.ai/',
          'user-agent':
              'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Mobile Safari/537.36',
        },
        body: jsonEncode({
          'text': text,
          'options': {
            'language': from,
            'target_language': to,
          }
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        final res = _cleanExtractText(body);
        if (res != null && res.isNotEmpty) return res;
      }
      throw Exception('Wordvice API (V2) failed: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _translateLlm(String text, String from, String to) async {
    try {
      final response = await http.post(
        Uri.parse(_llmApiUrl),
        headers: {
          'accept': 'application/json',
          'accept-language': 'id-ID,id;q=0.9',
          'content-type': 'application/json;charset=UTF-8',
          'origin': 'https://wordvice.ai',
          'priority': 'u=1, i',
          'referer': 'https://wordvice.ai/',
          'sec-ch-ua':
              '"Chromium";v="131", "Not_A Brand";v="24", "Microsoft Edge Simulate";v="131", "Lemur";v="131"',
          'sec-ch-ua-mobile': '?1',
          'sec-ch-ua-platform': '"Android"',
          'sec-fetch-dest': 'empty',
          'sec-fetch-mode': 'cors',
          'sec-fetch-site': 'same-site',
          'user-agent':
              'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36',
        },
        body: jsonEncode({
          'prompt': 'Translate the following $from text into $to.',
          'text': text,
          'tool': 'translate'
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(utf8.decode(response.bodyBytes));
        final res = _cleanExtractText(body);
        if (res != null && res.isNotEmpty) return res;
      }
      throw Exception('Wordvice LLM API failed: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }
}
