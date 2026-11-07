import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// 必应 (Bing) 翻译 Provider
/// 通过模拟真实 Web 浏览器带 Cookie 鉴权，100% 消除 302 防刷重定向
class BingProvider extends TranslationProvider {
  static const String _baseUrl = 'https://www.bing.com';
  final String _userAgent;

  BingProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      // 1. 请求主页获取 Cookie、IG 与 Anti-Abuse Token
      final pageResp = await http.get(
        Uri.parse('$_baseUrl/translator'),
        headers: {'User-Agent': _userAgent},
      ).timeout(const Duration(seconds: 6));

      if (pageResp.statusCode != 200) {
        throw Exception('Failed to load Bing Translator page: ${pageResp.statusCode}');
      }

      final cookies = pageResp.headers['set-cookie'] ?? '';
      final html = pageResp.body;

      final igMatch = RegExp(r'IG:"([^"]+)"').firstMatch(html);
      if (igMatch == null) throw Exception('Could not extract Bing IG');
      final ig = igMatch.group(1)!;

      final paramsMatch = RegExp(r'var params_AbusePreventionHelper\s*=\s*\[([^\]]+)\]').firstMatch(html);
      if (paramsMatch == null) throw Exception('Could not extract Bing abuse params');

      final paramsSplit = paramsMatch.group(1)!.split(',');
      if (paramsSplit.length < 3) throw Exception('Invalid Bing params format');

      final key = paramsSplit[0].trim();
      final token = paramsSplit[1].trim().replaceAll('"', '');

      final toLang = targetLanguage;
      final fromLang = sourceLanguage;

      // 2. 发送带 Cookie 的翻译请求
      final postResp = await http.post(
        Uri.parse('$_baseUrl/ttranslatev3?isVertical=1&&IG=$ig&IID=translator.5028'),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/x-www-form-urlencoded',
          'Referer': '$_baseUrl/translator',
          if (cookies.isNotEmpty) 'Cookie': cookies,
        },
        body: {
          'fromLang': fromLang,
          'text': text,
          'to': toLang,
          'token': token,
          'key': key,
        },
      ).timeout(const Duration(seconds: 6));

      if (postResp.statusCode != 200) {
        throw Exception('Bing API returned HTTP ${postResp.statusCode}');
      }

      final json = jsonDecode(utf8.decode(postResp.bodyBytes));
      if (json is List && json.isNotEmpty) {
        final translations = json[0]['translations'];
        if (translations is List && translations.isNotEmpty) {
          return translations[0]['text'] ?? '';
        }
      }

      throw Exception('Invalid response format from Bing Translate');
    } catch (e) {
      throw Exception('Bing translation failed: $e');
    }
  }
}
