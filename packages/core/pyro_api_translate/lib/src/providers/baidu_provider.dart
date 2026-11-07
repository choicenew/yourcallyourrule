import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// 百度 Fanyi Web 免 Key 翻译 Provider (长句与短词全兼容)
class BaiduProvider extends TranslationProvider {
  static const _sugUrl = 'https://fanyi.baidu.com/sug';
  static const _transUrl = 'https://fanyi.baidu.com/transapi';
  final String _userAgent;

  BaiduProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  String _mapLanguage(String lang) {
    if (lang == 'zh-CN' || lang == 'zh') return 'zh';
    if (lang == 'zh-TW') return 'cht';
    if (lang == 'en') return 'en';
    if (lang == 'ja') return 'jp';
    if (lang == 'ko') return 'kor';
    return lang;
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    final queryText = text.trim();
    if (queryText.isEmpty) return '';

    // 1. 如果是短词，优先使用 sug 端点
    if (!queryText.contains(' ') && queryText.length <= 30) {
      try {
        final sugResp = await http.post(
          Uri.parse(_sugUrl),
          headers: {
            'User-Agent': _userAgent,
            'Content-Type': 'application/x-www-form-urlencoded',
            'Referer': 'https://fanyi.baidu.com/',
          },
          body: {'kw': queryText},
        ).timeout(const Duration(seconds: 4));

        if (sugResp.statusCode == 200) {
          final json = jsonDecode(utf8.decode(sugResp.bodyBytes));
          if (json is Map && json['data'] is List && (json['data'] as List).isNotEmpty) {
            final first = (json['data'] as List).first;
            if (first is Map && first['v'] != null) {
              final val = first['v'].toString();
              final parts = val.split(';');
              if (parts.isNotEmpty) {
                return parts.last.replaceAll(RegExp(r'^[a-zA-Z]+\.\s*'), '').trim();
              }
              return val.trim();
            }
          }
        }
      } catch (_) {}
    }

    // 2. 长句通用端点
    try {
      final from = sourceLanguage == 'auto' ? 'auto' : _mapLanguage(sourceLanguage);
      final to = _mapLanguage(targetLanguage);

      final response = await http.post(
        Uri.parse(_transUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/x-www-form-urlencoded',
          'Referer': 'https://fanyi.baidu.com/',
        },
        body: {
          'from': from,
          'to': to,
          'query': queryText,
        },
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final json = jsonDecode(utf8.decode(response.bodyBytes));
        if (json is Map && json['data'] is List) {
          final dataList = json['data'] as List;
          final StringBuffer buffer = StringBuffer();
          for (final item in dataList) {
            if (item is Map && item['dst'] != null) {
              buffer.write(item['dst']);
            }
          }
          final result = buffer.toString().trim();
          if (result.isNotEmpty) {
            return result;
          }
        }
      }
      throw Exception('Baidu transapi status ${response.statusCode}');
    } catch (e) {
      throw Exception('Baidu translation failed: $e');
    }
  }
}
