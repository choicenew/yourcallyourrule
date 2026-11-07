import 'dart:convert';

import 'package:http/http.dart' as http;

import 'translation_provider.dart';

class AlibabaProvider extends TranslationProvider {
  static const _csrfUrl =
      'https://translate.alibaba.com/api/translate/csrftoken';
  static const _apiUrl = 'https://translate.alibaba.com/api/translate/text';
  final String _userAgent;
  Map<String, String>? _cookies;
  String? _csrfToken;
  String? _csrfHeaderName;

  AlibabaProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  Future<void> _ensureAuth() async {
    if (_cookies != null && _csrfToken != null) return;

    try {
      print('Alibaba: Fetching CSRF token from $_csrfUrl...');
      final response = await http.get(Uri.parse(_csrfUrl), headers: {
        'User-Agent': _userAgent,
      }).timeout(const Duration(seconds: 6));

      _cookies = {};
      _updateCookies(response.headers);

      final data = jsonDecode(response.body);
      _csrfToken = data['token'];
      _csrfHeaderName = data['headerName'];

      print('Alibaba: Auth success. Token: $_csrfToken');
    } catch (e) {
      print('Alibaba: Failed to fetch auth data: $e');
    }
  }

  void _updateCookies(Map<String, String> headers) {
    if (headers.containsKey('set-cookie')) {
      final setCookie = headers['set-cookie']!;
      final cookieList = setCookie.split(RegExp(r',(?=\s*[^;]+=[^;]+)'));
      for (final c in cookieList) {
        final parts = c.split(';')[0].trim().split('=');
        if (parts.length == 2) {
          _cookies![parts[0]] = parts[1];
        }
      }
    }
  }

  String _generateCookieHeader() {
    if (_cookies == null || _cookies!.isEmpty) return '';
    return _cookies!.entries.map((e) => '${e.key}=${e.value}').join('; ');
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      await _ensureAuth();

      final from = sourceLanguage == 'auto' ? 'auto' : sourceLanguage;
      final to = targetLanguage;

      final body = {
        'srcLang': from,
        'tgtLang': to,
        'query': text,
        '_csrf': _csrfToken ?? '', // Required field
        'domain': 'general',
        'srcText':
            text, // Redundant but present in V1 payload, V2 uses 'query' or 'srcText'? V2 ref uses 'query' in form.
      };

      // V2 Ref uses form data: query, srcLang, tgtLang, _csrf, domain.

      final headers = {
        'User-Agent': _userAgent,
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json, text/plain, */*',
        'Cookie': _generateCookieHeader(),
      };

      if (_csrfHeaderName != null && _csrfToken != null) {
        headers[_csrfHeaderName!] = _csrfToken!;
      }

      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode != 200) {
        throw Exception(
            'Alibaba API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      // Response structure: data['data']['translateText']
      if (data['data'] != null && data['data']['translateText'] != null) {
        return data['data']['translateText'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('Alibaba translation failed: $e');
    }
  }
}
