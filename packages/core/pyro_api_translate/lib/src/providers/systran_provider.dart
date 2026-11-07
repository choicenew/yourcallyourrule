import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

class SysTranProvider extends TranslationProvider {
  static const _homeUrl = 'https://www.systran.net/translate/';
  static const _tokenUrl = 'https://translate.systran.net/oidc/token';
  static const _apiUrl =
      'https://api-translate.systran.net/translation/text/translate';

  // Default JS path
  static const _defaultJsPath =
      'https://www.systransoft.com/wp-content/themes/systran/dist/translatebox/translateBox.bundle.js';

  final String _userAgent;
  String? _accessToken;

  SysTranProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  Future<void> _ensureAuth() async {
    if (_accessToken != null) return;

    try {
      print('SysTran: Fetching credentials from JS...');
      final jsResp = await http.get(Uri.parse(_defaultJsPath), headers: {
        'User-Agent': _userAgent,
        'Referer': _homeUrl,
      });

      final regExp = RegExp(
          r'"https://translate.systran.net/oidc",\w="(.*?)",\w="(.*?)";');
      final match = regExp.firstMatch(jsResp.body);

      if (match == null) {
        throw Exception('Could not find client credentials in JS');
      }

      final clientId = match.group(1)!;
      final clientSecret = match.group(2)!;

      print('SysTran: Getting token...');
      final tokenResp = await http.post(Uri.parse(_tokenUrl), headers: {
        'User-Agent': _userAgent,
        'Content-Type': 'application/x-www-form-urlencoded',
        'Origin': 'https://www.systran.net',
        'Referer': 'https://www.systran.net/',
        'X-Requested-With': 'XMLHttpRequest', // Mimic ajax
      }, body: {
        'grant_type': 'client_credentials',
        'client_id': clientId,
        'client_secret': clientSecret
      });

      if (tokenResp.statusCode != 200) {
        throw Exception(
            'Token fetch failed: ${tokenResp.statusCode} ${tokenResp.body}');
      }

      final tokenData = jsonDecode(tokenResp.body);
      _accessToken = tokenData['access_token'];
      print('SysTran: Token obtained: $_accessToken');
    } catch (e) {
      print('SysTran: Auth failed: $e');
      rethrow;
    }
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      await _ensureAuth();

      final from = sourceLanguage == 'auto' ? 'auto' : sourceLanguage;
      final to = targetLanguage;

      final body = {
        'target': to,
        'source': from == 'auto' ? null : from,
        'inputs': [text],
        'format': 'text/plain',
      };

      final cleanBody = Map<String, dynamic>.from(body);
      if (from == 'auto') {
        cleanBody.remove('source');
        cleanBody['autodetectionMode'] = 'single';
      }

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'User-Agent': 'File Translate Box Portable', // Specific UA in ref
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_accessToken',
          'Origin': 'https://www.systran.net',
          'Referer': 'https://www.systran.net/',
        },
        body: jsonEncode(cleanBody),
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          _accessToken = null;
        }
        throw Exception(
            'SysTran API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data['outputs'] != null && data['outputs'].isNotEmpty) {
        final doc = data['outputs'][0];
        if (doc['output'] != null && doc['output']['documents'] != null) {
          final transUnits = doc['output']['documents'][0]['trans_units'];
          if (transUnits != null && transUnits.isNotEmpty) {
            final sb = StringBuffer();
            for (var unit in transUnits) {
              for (var sentence in unit['sentences']) {
                sb.write(sentence['target']['text']);
                sb.write(' ');
              }
            }
            return sb.toString().trim();
          }
        }
      }
      throw Exception('Unexpected response format: $data');
    } catch (e) {
      throw Exception('SysTran translation failed: $e');
    }
  }
}
