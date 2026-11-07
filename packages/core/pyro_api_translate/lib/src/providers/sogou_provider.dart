import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'translation_provider.dart';

class SogouProvider extends TranslationProvider {
  static const _homeUrl = 'https://fanyi.sogou.com/text';
  static const _apiUrl = 'https://fanyi.sogou.com/api/transpc/text/result';
  static const _secretCode = '109984457';
  final String _userAgent;
  Map<String, String>? _cookies;

  SogouProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  Future<void> _ensureCookies() async {
    if (_cookies != null) return;

    try {
      print('Sogou: Fetching cookies from $_homeUrl...');
      final response = await http.get(Uri.parse(_homeUrl), headers: {
        'User-Agent': _userAgent,
      }).timeout(const Duration(seconds: 6));

      _cookies = {};
      _updateCookies(response.headers);
      print('Sogou: Cookies initialized: $_cookies');
    } catch (e) {
      print('Sogou: Failed to fetch cookies: $e');
    }
  }

  void _updateCookies(Map<String, String> headers) {
    // Handle set-cookie header (simple parsing)
    if (headers.containsKey('set-cookie')) {
      final setCookie = headers['set-cookie']!;
      // Split multiple cookies if comma separated (careful with dates)
      // For simplicity, splits by ',' might break dates.
      // Better to regex or split by Set-Cookie if list (Dart http joins them).
      // Dart Join: "c1=v1; Path=/, c2=v2; Path=/"

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
      await _ensureCookies();

      final from = sourceLanguage == 'auto' ? 'auto' : sourceLanguage;
      final to = targetLanguage;
      final uuidStr = const Uuid().v4();

      // Sign logic: "" + from + to + text + secretCode
      final signText = '$from$to$text$_secretCode';
      final sign = md5.convert(utf8.encode(signText)).toString();

      final body = {
        'from': from,
        'to': to,
        'text': text,
        'uuid': uuidStr,
        's': sign,
        'client': 'pc',
        'fr': 'browser_pc',
        'needQc': '1',
      };

      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: {
              'User-Agent': _userAgent,
              'Content-Type': 'application/x-www-form-urlencoded',
              'Accept': 'application/json, text/plain, */*',
              'Cookie': _generateCookieHeader(),
            },
            body: body,
          )
          .timeout(const Duration(seconds: 6));

      // print('Sogou: Response Body: ${response.body}'); // Commented out to reduce noise unless needed

      if (response.statusCode != 200) {
        throw Exception(
            'Sogou API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      // Response structure: data['data']['translate']['dit']
      if (data['data'] != null &&
          data['data']['translate'] != null &&
          data['data']['translate']['dit'] != null) {
        return data['data']['translate']['dit'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('Sogou translation failed: $e');
    }
  }
}
