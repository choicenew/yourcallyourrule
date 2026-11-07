import 'dart:convert';

import 'package:http/http.dart' as http;

import 'translation_provider.dart';

class LingvanexProvider extends TranslationProvider {
  static const _homeUrl = 'https://lingvanex.com/en/translate/';
  static const _apiUrlBase =
      'https://api-b2b.backenster.com/b1/api/v3/translate/';
  final String _userAgent;
  String? _authToken;

  LingvanexProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  @override
  bool get supportsAuto => false;

  Future<void> _ensureAuth() async {
    if (_authToken != null) return;

    try {
      print('Lingvanex: Fetching auth token from $_homeUrl...');
      final response = await http.get(Uri.parse(_homeUrl), headers: {
        'User-Agent': _userAgent,
      }).timeout(const Duration(seconds: 6));

      final match =
          RegExp(r'const API_BEARER_TOKEN = "(.*?)"').firstMatch(response.body);
      if (match != null) {
        _authToken = match.group(1);
        print('Lingvanex: Token found: $_authToken');
      } else {
        throw Exception('Could not find API_BEARER_TOKEN in homepage');
      }
    } catch (e) {
      print('Lingvanex: Auth failed: $e');
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
        'from': from,
        'to': to,
        'text': text,
        'platform': 'dp',
      };

      final response = await http
          .post(
            Uri.parse(_apiUrlBase),
            headers: {
              'User-Agent': _userAgent,
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': _authToken!,
            },
            body: body,
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) {
        if (response.statusCode == 401 || response.statusCode == 403) {
          _authToken = null; // Reset token on auth error
        }
        throw Exception(
            'Lingvanex API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data['result'] != null) {
        final res = data['result'];
        if (res is String && res.trim().isNotEmpty && !res.startsWith('{') && !res.startsWith('[')) {
          return res.trim();
        }
      }
      throw Exception('Unexpected response format: $data');
    } catch (e) {
      throw Exception('Lingvanex translation failed: $e');
    }
  }
}
