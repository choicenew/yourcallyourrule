import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

/// This test validates the Regex extraction logic for "Should I Answer" (shouldianswer.com).
/// It uses the "JS Way" of defining regex in Dart (raw strings r'''...''') to ensure
/// the pattern is copy-paste compatible with the JavaScript plugin configuration.

void main() {
  const String userAgent =
      'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36';

  test('Verify ShouldIAnswer Regex Extraction', () async {
    final url = 'https://www.shouldianswer.com/phone-number/2026307992';
    print('Fetching URL: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': userAgent},
    );

    expect(response.statusCode, 200, reason: 'Should return 200 OK');
    final html = response.body;

    // --- DEFINING REGEX IN "JS WAY" (Raw Strings) ---
    // In JS: /class="main_summary_[^"]*">([^<]+)/
    // In Dart: RegExp(r'''class="main_summary_[^"]*">([^<]+)''')

    // Pattern 1: Look for the summary classification (e.g. "Negative", "Neutral")
    // HTML often looks like: <div class="main_summary_red">Negative</div> or similar
    // We try to capture the text content.
    final jsRegexPattern1 = r'''class="main_summary_[^"]*"\s*>([^<]+)''';

    // Pattern 2: Look for specific review keywords if summary misses
    // "Unsolicited call reported by..."
    final jsRegexPattern2 = r'''Unsolicited call''';

    print('\n--- Testing Pattern 1 (Summary Class) ---');
    print('Regex: $jsRegexPattern1');
    final regExp1 = RegExp(
      jsRegexPattern1,
      caseSensitive: false,
      multiLine: true,
    );
    final match1 = regExp1.firstMatch(html);

    if (match1 != null) {
      print('✅ Match Found! Group 1: "${match1.group(1)?.trim()}"');
    } else {
      print('❌ No Match for Pattern 1');
    }

    print('\n--- Testing Pattern 2 (Text Content) ---');
    print('Regex: $jsRegexPattern2');
    final regExp2 = RegExp(jsRegexPattern2, caseSensitive: false);
    if (regExp2.hasMatch(html)) {
      print('✅ Match Found for "Unsolicited call"');
    } else {
      print('❌ No Match for Pattern 2');
    }

    // Debug: Print a snippet of the body to see what we are dealing with
    print('\n--- Body Snippet (First 2000 chars) ---');
    print(html.substring(0, html.length > 2000 ? 2000 : html.length));
  });
}
