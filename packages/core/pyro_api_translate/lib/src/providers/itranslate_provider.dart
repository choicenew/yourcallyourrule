import 'dart:convert';

import 'package:http/http.dart' as http;

import 'translation_provider.dart';

class ItranslateProvider extends TranslationProvider {
  static const _homeUrl = 'https://itranslate.com/translate';
  static const _apiUrl = 'https://web-api.itranslateapp.com/v3/texts/translate';
  static const _manifestUrl =
      'https://itranslate-webapp-production.web.app/manifest.json';

  final String _userAgent;
  String? _apiKey;

  ItranslateProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  Future<void> _ensureAuth() async {
    if (_apiKey != null) return;

    try {
      print('Itranslate: Fetching API Key from $_homeUrl...');
      final response = await http.get(Uri.parse(_homeUrl), headers: {
        'User-Agent': _userAgent,
      }).timeout(const Duration(seconds: 6));

      var key = _extractKey(response.body);

      if (key == null) {
        print('Itranslate: Key not found in home, trying manifest fallback...');
        key = await _fetchKeyFromManifest();
      }

      if (key != null) {
        _apiKey = key;
        print('Itranslate: API Key found: $_apiKey');
      } else {
        throw Exception('Could not find API-KEY in homepage or manifest');
      }
    } catch (e) {
      print('Itranslate: Auth failed: $e');
      rethrow;
    }
  }

  String? _extractKey(String content) {
    final match = RegExp(r'"API-KEY":"(.*?)"').firstMatch(content);
    return match?.group(1);
  }

  Future<String?> _fetchKeyFromManifest() async {
    try {
      final response = await http.get(Uri.parse(_manifestUrl), headers: {
        'User-Agent': _userAgent,
      }).timeout(const Duration(seconds: 6));
      final data = jsonDecode(response.body);
      final mainJs = data['main.js'];

      if (mainJs != null) {
        // Main JS path might prove tricky if relative, but manifest usually has full or relative to host.
        // Assuming absolute or relative to manifest host.
        // Manifest is on web.app.
        // Ref code: https://itranslate-webapp-production.web.app/ + mainJs
        // The manifest content: "main.js": "static/js/main.123.chunk.js"

        // Actually, ref code says: self.language_url = manifest_data.get('main.js')
        // And then fetches that.
        // Let's assume relative to web.app base.

        final uri = Uri.parse(_manifestUrl).resolve(mainJs);

        print('Itranslate: Fetching JS from $uri');
        final jsResp = await http.get(uri, headers: {
          'User-Agent': _userAgent
        }).timeout(const Duration(seconds: 6));
        return _extractKey(jsResp.body);
      }
    } catch (e) {
      print('Itranslate: Manifest fallback error: $e');
    }
    return null;
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      await _ensureAuth();

      final from = sourceLanguage == 'auto' ? 'auto' : sourceLanguage;
      final to = targetLanguage;

      final body = {
        'source': {
          'dialect': from,
          'text': text,
          'with': ['synonyms']
        },
        'target': {'dialect': to}
      };

      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: {
              'User-Agent': _userAgent,
              'Content-Type': 'application/json',
              'API-KEY': _apiKey!,
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) {
        if (response.statusCode == 401 || response.statusCode == 403) {
          _apiKey = null; // Reset token if unauthorized
        }
        throw Exception(
            'Itranslate API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      // data['target']['text']
      if (data['target'] != null && data['target']['text'] != null) {
        return data['target']['text'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('Itranslate translation failed: $e');
    }
  }
}
