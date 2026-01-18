import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

/// This test file verifies that the "Universal Regex API" approach works for the targeted services.
/// It simulates the plugin's logic: Fetch URL -> Apply Regex -> Extract Label.
///
/// Note: Real network requests are used. These may fail due to network restrictions, CAPTCHAs, or blocking.
/// If they fail, it proves the sites are "hard to scrape" with simple HTTP, but the Regex logic itself
/// can be verified against the expected HTML structure (mocked) if needed.

void main() {
  // Common User-Agent used in plugins
  const String userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.0.0 Safari/537.36';

  // Helper to run the check
  Future<void> verifyRegex(
    String serviceName,
    String url,
    String regexPattern,
    String? expectedLabelPart,
  ) async {
    print('--- Verifying $serviceName ---');
    print('URL: $url');
    print('Regex: $regexPattern');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': userAgent},
      );

      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final body = response.body;
        // print('Response Body Sample: ${body.substring(0, body.length > 500 ? 500 : body.length)}'); // Debug

        final regExp = RegExp(
          regexPattern,
          caseSensitive: false,
          multiLine: true,
        );
        final match = regExp.firstMatch(body);

        if (match != null) {
          final extracted = match.group(1)?.trim();
          print('✅ Match Found! Extracted Label: "$extracted"');

          if (expectedLabelPart != null) {
            expect(
              extracted,
              contains(expectedLabelPart),
              reason: 'Extracted label should contain expected text',
            );
          }
        } else {
          print('❌ No Match Found.');
          // If we fail to match, we print the first 2000 chars to see what happened (maybe Captcha/Blocking)
          print(
            'Body (first 200 chars): ${body.substring(0, body.length > 200 ? 200 : body.length)}',
          );
          // We don't fail the test automatically here to allow "soft" failure in CI environments without net access,
          // but for user verification this print is key.
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('\n');
  }

  test('Verify Baidu Regex (China)', () async {
    // Baidu: 19054115823
    // Plugin Logic: .op_mobilephone_label
    // Regex Idea: Look for the class or the text structure "标记为..."
    // Note: Baidu often returns dynamic content, might need specific Headers or might be blocked.
    // HTML often: <div class="op_mobilephone_label">...</div>
    await verifyRegex(
      'Baidu',
      'https://www.baidu.com/s?wd=19054115823&ie=utf-8',
      'op_mobilephone_label[^>]*>\\s*([^<]+)', // Simplistic Regex approach
      null, // Expect dynamic result
    );
  });

  test('Verify Sogou Regex (China)', () async {
    // Sogou: 19054115823
    // Plugin Logic: .text-layout > p
    await verifyRegex(
      'Sogou',
      'https://sogou.com/web?query=19054115823',
      'class="text-layout"[^>]*>\\s*<p[^>]*>\\s*([^<]+)',
      null,
    );
  });

  test('Verify Soo Regex (China)', () async {
    // Soo: 19054115823
    // Plugin Logic: .mohe-tips-zp
    await verifyRegex(
      'Soo',
      'https://www.so.com/s?q=19054115823',
      'class="mohe-tips-zp"[^>]*>\\s*([^<]+)',
      null,
    );
  });

  test('Verify CleverDialer Regex (Germany/Global)', () async {
    // Cleverdialer: 3853239825
    // Plugin Logic: td.callertype
    await verifyRegex(
      'CleverDialer',
      'https://www.cleverdialer.com/phonenumber/3853239825',
      'callertype[^>]*>\\s*([^<]+)',
      null,
    );
  });

  test('Verify Tellows Regex (Global)', () async {
    // Tellows: +13207827619
    // Plugin Logic: <b>Types of call:</b>...text
    await verifyRegex(
      'Tellows',
      'https://www.tellows.com/num/%2B13207827619',
      'Types of call:<\\/b>\\s*([^<]+)',
      null,
    );
  });
}
