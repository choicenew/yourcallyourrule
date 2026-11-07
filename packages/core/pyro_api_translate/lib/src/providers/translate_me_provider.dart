import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'translation_provider.dart';

class TranslateMeProvider extends TranslationProvider {
  static const _apiUrl = 'https://translateme.network/wp-admin/admin-ajax.php';
  final String _userAgent;
  final http.Client _client;

  // Basic map for common languages.
  static const _langMap = {
    'auto': 'auto',
    'en': 'English',
    'zh': 'Chinese',
    'zh-CN': 'Chinese',
    'ja': 'Japanese',
    'ko': 'Korean',
    'fr': 'French',
    'de': 'German',
    'es': 'Spanish',
    'it': 'Italian',
    'ru': 'Russian',
    'pt': 'Portuguese',
  };

  TranslateMeProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        _client = _createInsecureClient();

  static http.Client _createInsecureClient() {
    final ioClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return IOClient(ioClient);
  }

  String _mapLanguage(String code) {
    if (_langMap.containsKey(code)) return _langMap[code]!;
    if (code.length > 2) {
      return code[0].toUpperCase() + code.substring(1);
    }
    return code;
  }

  Future<String> _translateSingle(String text, String from, String to) async {
    final body = {
      'text': text,
      'lang_from': from,
      'lang_to': to,
      'action': 'tm_my_action',
      'type': 'convert'
    };

    final response = await _client.post(
      Uri.parse(_apiUrl),
      headers: {
        'User-Agent': _userAgent,
        'Content-Type': 'application/x-www-form-urlencoded',
        'Origin': 'https://translateme.network',
        'Referer': 'https://translateme.network/',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception(
          'TranslateMe API Error (${response.statusCode}): ${response.body}');
    }

    final data = jsonDecode(utf8.decode(response.bodyBytes));

    if (data['to'] != null) {
      return data['to'].toString();
    } else {
      throw Exception('Unexpected response format: $data');
    }
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      var from =
          _mapLanguage(sourceLanguage == 'auto' ? 'auto' : sourceLanguage);
      var to = _mapLanguage(targetLanguage);

      final isFromEnglish = from == 'English';
      final isToEnglish = to == 'English';

      if (isFromEnglish || isToEnglish || from == 'auto') {
        return await _translateSingle(text, from, to);
      } else {
        print('TranslateMe: Pivoting via English ($from -> English -> $to)');
        final intermediate = await _translateSingle(text, from, 'English');
        return await _translateSingle(intermediate, 'English', to);
      }
    } catch (e) {
      throw Exception('TranslateMe translation failed: $e');
    }
  }
}
