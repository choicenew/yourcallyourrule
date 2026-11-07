import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:pyro_api_translate/src/providers/translation_provider.dart';
import 'package:pyro_api_translate/src/models/translation_config.dart';

class TranslateCatProvider extends TranslationProvider {
  static const String _baseUrl = 'https://www.translatecat.com/';

  final TranslationConfig config;

  // Cache cookies and token
  String? _cachedCookie;
  String? _cachedToken;

  TranslateCatProvider({this.config = const TranslationConfig()});

  String get name => 'TranslateCat';

  // Scraper-based
  bool get isKeyless => true;

  String _formatCookies(String rawCookie) {
    // http package joins Set-Cookie headers with ",".
    // We need to extract key=value pairs and join them with "; ".
    // Regex splits by comma but handles dates (basic assumption: cookie name doesn't have spaces usually)
    // Actually, we just need to identify "name=value".
    // This regex looks for patterns like "name=value" that start at the beginning or after a comma+space.
    final RegExp cookieRegExp = RegExp(r'(?:^|,)\s*([^=]+)=([^;]+)');
    final matches = cookieRegExp.allMatches(rawCookie);
    final cookies = <String>[];
    for (final match in matches) {
      if (match.groupCount >= 2) {
        final key = match.group(1)?.trim();
        final value = match.group(2)?.trim();
        // Filter out common attributes if they get matched by mistake, though attributes usually follow ";"
        if (key != null &&
            value != null &&
            ![
              'expires',
              'path',
              'domain',
              'max-age',
              'samesite',
              'secure',
              'httponly'
            ].contains(key.toLowerCase())) {
          cookies.add('$key=$value');
        }
      }
    }
    return cookies.join('; ');
  }

  Future<void> _refreshSession() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        // Handle cookie parsing
        final rawCookie = response.headers['set-cookie'];
        if (rawCookie != null) {
          _cachedCookie = _formatCookies(rawCookie);
        }

        final document = parse(response.body);
        final tokenInput = document.querySelector('input[name="_token"]');
        _cachedToken = tokenInput?.attributes['value'];

        if (_cachedToken == null) {
          throw Exception('Failed to extract CSRF token from TranslateCat');
        }
      } else {
        throw Exception(
            'Failed to load TranslateCat homepage: ${response.statusCode}');
      }
    } catch (e) {
      _cachedCookie = null;
      _cachedToken = null;
      rethrow;
    }
  }

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    final from = sourceLanguage == 'auto' ? 'auto' : sourceLanguage;
    final to = targetLanguage;

    if (_cachedCookie == null || _cachedToken == null) {
      await _refreshSession();
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Origin': 'https://www.translatecat.com/',
          'Referer': 'https://www.translatecat.com/',
          'User-Agent': 'Postify/1.0.0', // From wudyver
          if (_cachedCookie != null) 'Cookie': _cachedCookie!,
        },
        body: {
          'content': text,
          'source': from,
          'target': to,
          '_token': _cachedToken!,
        },
      );

      if (response.statusCode == 200) {
        final document = parse(response.body);
        final resultDiv = document.querySelector('.card-text');

        if (resultDiv != null) {
          return resultDiv.text.trim();
        } else {
          // Retry once if token invalid
          if (_cachedToken != null) {
            _cachedToken = null;
            // Recursive retry
            return await translate(text,
                targetLanguage: targetLanguage, sourceLanguage: sourceLanguage);
          }
          throw Exception('Failed to parse translation result');
        }
      } else {
        throw Exception(
            'TranslateCat API failed with status: ${response.statusCode}');
      }
    } catch (e) {
      _cachedToken = null;
      rethrow;
    }
  }
}
