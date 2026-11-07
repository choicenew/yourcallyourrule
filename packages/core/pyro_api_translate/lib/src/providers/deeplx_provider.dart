import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'translation_provider.dart';

class DeepLXProvider extends TranslationProvider {
  // DeepLX logic ported from the Go implementation
  // https://github.com/missuo/DeepLX

  final String _endpoint = 'https://www2.deepl.com/jsonrpc';

  // Note: DeepLX uses random IDs.
  final Random _random = Random();

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    if (text.isEmpty) return '';

    try {
      final id = _getRandomNumber();
      final iCount = _getICount(text);
      final timestamp = _getTimeStamp(iCount);

      // Construct JSON-RPC POST data
      final postData = {
        "jsonrpc": "2.0",
        "method": "LMT_handle_texts",
        "id": id,
        "params": {
          "splitting": "newlines",
          "lang": {
            "source_lang_user_selected": sourceLanguage == 'auto'
                ? 'auto'
                : sourceLanguage.toUpperCase(),
            "target_lang": targetLanguage.toUpperCase()
          },
          "texts": [
            {"text": text, "requestAlternatives": 3}
          ],
          "timestamp": timestamp
        }
      };

      var postStr = jsonEncode(postData);

      // DeepLX Logic: manipulate the method string slightly based on ID
      // func handlerBodyMethod(random int64, body string) string
      if ((id + 5) % 29 == 0 || (id + 3) % 13 == 0) {
        postStr = postStr.replaceFirst('"method":"', '"method" : "');
      } else {
        postStr = postStr.replaceFirst('"method":"', '"method": "');
      }

      final response = await http
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Accept': '*/*',
              'Accept-Language': 'en-US,en;q=0.9',
              'User-Agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
              // 'Referer' and others could be added if needed, but basic UA usually works for DeepLX logic.
              'Referer': 'https://www.deepl.com/',
              'Origin': 'https://www.deepl.com',
            },
            body: postStr,
          )
          .timeout(const Duration(seconds: 6));

      // DeepL sometimes returns 429 for too many requests (IP block).
      if (response.statusCode == 429) {
        throw Exception(
            'DeepL IP Blocked (429). Try again later or use a proxy.');
      }

      if (response.statusCode != 200) {
        throw Exception('DeepL API returned ${response.statusCode}');
      }

      final json = jsonDecode(utf8.decode(response.bodyBytes));

      // Response parsing
      // result.texts[0].text
      if (json['result'] != null &&
          json['result']['texts'] != null &&
          (json['result']['texts'] as List).isNotEmpty) {
        return json['result']['texts'][0]['text'];
      }

      throw Exception('Invalid DeepL response format');
    } catch (e) {
      throw Exception('DeepLX translation failed: $e');
    }
  }

  // func getICount(translateText string) int64
  int _getICount(String text) {
    return 'i'.allMatches(text).length;
  }

  // func getRandomNumber() int64
  int _getRandomNumber() {
    // num := rng.Int63n(99999) + 100000; return num * 1000
    final num = _random.nextInt(99999) + 100000;
    return num * 1000;
  }

  // func getTimeStamp(iCount int64) int64
  int _getTimeStamp(int iCount) {
    final ts = DateTime.now().millisecondsSinceEpoch;
    if (iCount != 0) {
      final iCountWithOne = iCount + 1;
      return ts - (ts % iCountWithOne) + iCountWithOne;
    }
    return ts;
  }
}
