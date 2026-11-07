import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

/// 有道翻译 - 智能节点全覆盖 Provider
/// 完美兼容长句翻译(fanyi)与专业学术词组(Quantum circuit / ec / web_trans)
class YoudaoProvider extends TranslationProvider {
  static const _apiUrl = 'https://dict.youdao.com/jsonapi';
  final String _userAgent;

  YoudaoProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final queryText = text.trim();
      if (queryText.isEmpty) return '';

      final uri = Uri.parse(_apiUrl).replace(queryParameters: {
        'q': queryText,
        'dicts': jsonEncode({
          'count': 3,
          'dicts': [
            ["fanyi", "ec", "web_trans", "ce", "simple"]
          ]
        }),
      });

      final response = await http.get(
        uri,
        headers: {'User-Agent': _userAgent},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final bodyText = utf8.decode(response.bodyBytes);
        final dynamic data = jsonDecode(bodyText);

        final result = _smartExtract(data);
        if (result != null && result.isNotEmpty) {
          return result;
        }
      }

      throw Exception('Youdao Dict returned HTTP ${response.statusCode}');
    } catch (e) {
      throw Exception('Youdao translation failed: $e');
    }
  }

  /// 智能广度提炼节点：覆盖 fanyi -> ec -> web_trans -> simple 各类词典/翻译结构
  String? _smartExtract(dynamic data) {
    if (data is! Map) return null;

    // 1. 首选句子翻译节点 (fanyi)
    if (data['fanyi'] is Map && data['fanyi']['tran'] != null) {
      final tran = data['fanyi']['tran'].toString().trim();
      if (tran.isNotEmpty) return tran;
    }

    // 2. 次选英汉词典节点 (ec / Quantum circuit 等学术词组)
    if (data['ec'] is Map && data['ec']['word'] is Map) {
      final word = data['ec']['word'];
      if (word['trs'] is List) {
        final trs = word['trs'] as List;
        final List<String> extracted = [];
        for (var item in trs) {
          if (item is Map && item['tr'] is List) {
            final trList = item['tr'] as List;
            if (trList.isNotEmpty && trList[0] is Map && trList[0]['l'] is Map) {
              final l = trList[0]['l'];
              if (l['i'] is List && (l['i'] as List).isNotEmpty) {
                extracted.add((l['i'] as List)[0].toString().trim());
              }
            }
          }
        }
        if (extracted.isNotEmpty) {
          return extracted.join('; ');
        }
      }
    }

    // 3. 网络释义节点 (web_trans)
    if (data['web_trans'] is Map && data['web_trans']['web-translation'] is List) {
      final list = data['web_trans']['web-translation'] as List;
      if (list.isNotEmpty && list[0] is Map && list[0]['trans'] is List) {
        final transList = list[0]['trans'] as List;
        if (transList.isNotEmpty && transList[0] is Map && transList[0]['value'] != null) {
          final val = transList[0]['value'].toString().trim();
          if (val.isNotEmpty) return val;
        }
      }
    }

    // 4. 简明词典节点 (simple)
    if (data['simple'] is Map && data['simple']['word'] is List) {
      final wordList = data['simple']['word'] as List;
      if (wordList.isNotEmpty && wordList[0] is Map && wordList[0]['trs'] is List) {
        final trs = wordList[0]['trs'] as List;
        if (trs.isNotEmpty && trs[0] is Map && trs[0]['tr'] != null) {
          return trs[0]['tr'].toString().trim();
        }
      }
    }

    return null;
  }
}
