import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

class ArgosProvider extends TranslationProvider {
  static const _homeUrl = 'https://libretranslate.com';
  static const _apiUrl = 'https://libretranslate.com/translate';
  static const _jsUrl =
      'https://libretranslate.com/js/app.js?v=1.6.1'; // Use fixed or discover?
  // Note: Ref uses specific version, but basic app.js might work.
  // Actually, better to fetch homepage and find script src?
  // For now let's try the fixed one or base app.js.

  final String _userAgent;
  String? _secret;

  ArgosProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  Future<void> _ensureSecret() async {
    if (_secret != null) return;

    try {
      // 1. Try to find the script URL from homepage if possible, or just hit the known JS path.
      // The ref has a hardcoded query param ?v=1.6.1 which might be important for cache busting or specific version.

      print('Argos: Fetching secret from $_jsUrl...');
      final response = await http.get(Uri.parse(_jsUrl), headers: {
        'User-Agent': _userAgent,
      });

      final match = RegExp(r'apiSecret:\s*"(.*?)"').firstMatch(response.body);
      if (match != null) {
        // The secret is base64 encoded in the JS?
        // Ref: secret = base64.b64decode(api_secret.encode()).decode()
        final rawSecret = match.group(1)!;
        try {
          _secret = utf8.decode(base64.decode(rawSecret));
          print('Argos: Secret found and decoded.');
        } catch (e) {
          print('Argos: failed to decode secret, using raw? $e');
          _secret = rawSecret;
        }
      } else {
        throw Exception('Could not find apiSecret in app.js');
      }
    } catch (e) {
      print('Argos: Auth failed: $e');
      rethrow;
    }
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      await _ensureSecret();

      final from = sourceLanguage == 'auto' ? 'auto' : sourceLanguage;
      final to = targetLanguage;

      final body = {
        'q': text,
        'source': from,
        'target': to,
        'format': 'text',
        'alternatives': 3,
        'api_key': '',
        'secret': _secret,
      };

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/json',
          'Origin': _homeUrl,
        },
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 403 || response.statusCode == 401) {
          _secret = null; // Reset
        }
        throw Exception(
            'Argos API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data['translatedText'] != null) {
        return data['translatedText'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('Argos translation failed: $e');
    }
  }
}
