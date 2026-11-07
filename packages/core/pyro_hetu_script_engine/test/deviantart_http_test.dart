import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('DeviantArt HTTP Fetch Test', () {
    final dio = Dio(BaseOptions(
      validateStatus: (status) => status != null && status < 500,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    ));

    test('Fetch DeviantArt Home Page', () async {
      const url = 'https://www.deviantart.com/daily-deviations';
      print('Fetching: $url');

      try {
        final response = await dio.get(url);
        print('Status Code: ${response.statusCode}');

        final html = response.data.toString();
        final hasInitialState = html.contains('__INITIAL_STATE__');
        print('Contains __INITIAL_STATE__: $hasInitialState');

        if (response.statusCode == 200 && hasInitialState) {
          print('SUCCESS: Content fetched successfully.');
        } else if (html.contains('cloudflare') || html.contains('Shield')) {
          print('FAILED: Blocked by Cloudflare or Shield.');
        } else {
          print('FAILED: Unexpected content or status.');
        }

        // Print a small snippet for debugging
        print(
            'Response snippet: ${html.length > 500 ? html.substring(0, 500) : html}');

        expect(response.statusCode, 200);
        expect(hasInitialState, true);
      } catch (e) {
        print('Error during fetch: $e');
        rethrow;
      }
    }, skip: 'Live network test requires real internet access');

    test('Fetch DeviantArt Search Page', () async {
      const url = 'https://www.deviantart.com/search?q=wallpaper';
      print('Fetching: $url');

      try {
        final response = await dio.get(url);
        print('Status Code: ${response.statusCode}');

        final html = response.data.toString();
        final hasInitialState = html.contains('__INITIAL_STATE__');
        print('Contains __INITIAL_STATE__: $hasInitialState');

        expect(response.statusCode, 200);
        expect(hasInitialState, true);
      } catch (e) {
        print('Error during fetch: $e');
        rethrow;
      }
    }, skip: 'Live network test requires real internet access');
  });
}
