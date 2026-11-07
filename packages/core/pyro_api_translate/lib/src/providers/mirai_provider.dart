import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'translation_provider.dart';

class MiraiProvider extends TranslationProvider {
  static const _homeUrl = 'https://miraitranslate.com/trial/';
  static const _apiUrl =
      'https://trial.miraitranslate.com/trial/api/translate.php';
  static const _traceUrl =
      'https://trial.miraitranslate.com/trial/api/trace.php';

  final String _userAgent;
  String? _tranKey;
  final _uuid = Uuid();
  late final String _userId;

  MiraiProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36' {
    _userId = _uuid.v4();
  }

  Map<String, String> _cookies = {};

  String _generateCookieHeader() {
    return _cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
  }

  void _updateCookies(http.Response response) {
    String? setCookie = response.headers['set-cookie'];
    if (setCookie != null) {
      // Simple parsing: split by ',', then each part by ';', take first.
      // Set-Cookie can be multiple.
      // Dart returns combined string?
      // Actually http package joins multiple Set-Cookie headers with comma? Or split?
      // It's tricky. But basic cookies usually work with simple split.
      // Regex is better.
      // Or just splitting by ',' might break dates.
      // Let's assume standard simple cookies for now.

      var rawCookies = setCookie
          .split(RegExp(r',(?=\s*\w+=)')); // Split by comma followed by key=
      for (var c in rawCookies) {
        var parts = c.split(';');
        if (parts.isNotEmpty) {
          var kv = parts[0].split('=');
          if (kv.length == 2) {
            _cookies[kv[0].trim()] = kv[1].trim();
          }
        }
      }
    }
  }

  Future<void> _ensureKey() async {
    if (_tranKey != null) return;

    try {
      print('Mirai: Fetching tran key from $_homeUrl...');
      final response = await http.get(Uri.parse(_homeUrl), headers: {
        'User-Agent': _userAgent,
      });

      _updateCookies(response);

      final match = RegExp(r'var tran = "(.*?)";').firstMatch(response.body);
      if (match != null) {
        _tranKey = match.group(1);
        print('Mirai: Key found: $_tranKey');
      } else {
        throw Exception('Could not find tran key in homepage');
      }
    } catch (e) {
      print('Mirai: Auth failed: $e');
      rethrow;
    }
  }

  Future<void> _sendTrace(String text, String from) async {
    final transId = _uuid.v4();
    final date = DateTime.now().toUtc().toIso8601String();
    // Format: 2024-05-22T10:00:00.000Z. Dart ISO includes milliseconds.
    // Ref: .isoformat()[:-3] + 'Z' -> removes microseconds if any?
    // Dart is 2024-05-22T10:00:00.000Z usually.

    final traceData = {
      'operationType': 'SLA',
      'lang': from == 'auto' ? 'en' : from, // Guessing
      'source': text,
      'userId': _userId,
      'transId': transId,
      'uniqueId': _tranKey,
      'date': date,
    };

    try {
      final response = await http.post(
        Uri.parse(_traceUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/json',
          'Origin': 'https://miraitranslate.com',
          'Referer': 'https://miraitranslate.com/',
          'Cookie': _generateCookieHeader(),
        },
        body: jsonEncode(traceData),
      );
      _updateCookies(response);
    } catch (e) {
      print('Mirai: Trace failed (ignoring): $e');
    }
  }

  @override
  bool get supportsAuto => false;

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      await _ensureKey();

      var from = sourceLanguage;
      var to = targetLanguage;

      var zt = 'false';
      if (from == 'zh-TW') {
        from = 'zt';
        zt = 'true';
      }
      if (to == 'zh-TW') {
        to = 'zt';
        zt = 'true';
      }

      if (from == 'zh-CN') from = 'zh';
      if (to == 'zh-CN') to = 'zh';

      // Send trace
      await _sendTrace(text, from);

      final body = {
        'input': text,
        'source': from,
        'target': to,
        'tran': _tranKey,
        'adaptPhrases': [], // sent as empty list? '[]' or multiple keys?
        // Ref: 'adaptPhrases': [] in py dict.
        // requests sends adaptPhrases as nothing if empty? Or empty list?
        // Let's try sending literal empty list string or ignoring.
        // If I put it in map, it becomes string. '[]'.
        // Ref: data=payload.

        'filter_profile': 'nmt',
        'profile': 'inmt',
        'usePrefix': 'false',
        'zt': zt,
        'InmtTarget': '',
        'InmtTranslateType': 'gisting',
      };

      // We need to handle 'adaptPhrases' correctly.
      // If I use body.map, adaptPhrases becomes "[]" (string).
      // PHP might expect array.
      // http.post body supports Map<String, String>.
      // If I want array, I might need custom encoding or just omit it if empty.
      // Let's omit it for now or send "[]".

      final cleanBody = Map<String, String>.from(
          body.map((k, v) => MapEntry(k, v.toString())));
      cleanBody.remove('adaptPhrases'); // Try removing first.

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Origin': 'https://miraitranslate.com',
          'Referer': 'https://miraitranslate.com/',
          'Cookie': _generateCookieHeader(),
          // Cookies? Ref doesn't explicitly save cookies from home to api,
          // but session object does.
          // If trace sets cookie, I need to persist it.
          // But I'm creating new http calls.
          // I should verify if I need cookies.
        },
        body: cleanBody,
      );

      _updateCookies(response);

      // If authorization fails again, it's definitely cookies.
      // I'll check status.

      if (response.statusCode != 200) {
        throw Exception(
            'Mirai API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data['status'] == 'success') {
        List outputs = data['ouputs'] ?? data['outputs'];
        if (outputs.isNotEmpty) {
          return outputs[0]['output'][0]['translation'];
        }
      } else if (data['status'] == 'failed' &&
          data['error_msg'] == 'unauthorized_access') {
        // Retry with cookies?
        // The session cookie might be needed from the home page load or trace response.
        throw Exception('Mirai Unauthorized. Cookies might be required.');
      }

      throw Exception('Unexpected response format: $data');
    } catch (e) {
      throw Exception('Mirai translation failed: $e');
    }
  }
}
