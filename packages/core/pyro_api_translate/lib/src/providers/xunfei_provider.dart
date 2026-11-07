import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// 科大讯飞 (iFLYTEK) Web 免 Key 逆向 Provider
class XunfeiProvider extends TranslationProvider {
  static const _homeUrl = 'https://fanyi.xfyun.cn';
  static const _apiUrl = 'https://fanyi.xfyun.cn/v1/share/translate';
  final String _userAgent;

  XunfeiProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  String _mapLanguage(String lang) {
    if (lang == 'zh' || lang == 'zh-CN') return 'cn';
    if (lang == 'zh-TW') return 'cht';
    if (lang == 'en') return 'en';
    if (lang == 'ja') return 'ja';
    if (lang == 'ko') return 'ko';
    return lang;
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final from = sourceLanguage == 'auto' ? 'auto' : _mapLanguage(sourceLanguage);
      final to = _mapLanguage(targetLanguage);

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Origin': _homeUrl,
          'Referer': '$_homeUrl/',
          'X-Requested-With': 'XMLHttpRequest',
        },
        body: {
          'from': from,
          'to': to,
          'text': text,
        },
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        if (json is Map && json['data'] != null) {
          final data = json['data'];
          if (data is Map && data['result'] != null) {
            final result = data['result'].toString().trim();
            if (result.isNotEmpty) {
              return result;
            }
          } else if (data is String) {
            return data.trim();
          }
        }
      }

      throw Exception('Xunfei returned status ${response.statusCode}');
    } catch (e) {
      throw Exception('Xunfei translation failed: $e');
    }
  }
}
