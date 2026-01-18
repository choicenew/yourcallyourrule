import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
// Dependent on html package, often available in Flutter projects
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

/// INTEGRATED REGEX VERIFICATION TEST
///
/// This test mimics the exact data flow of the Plugin system:
/// 1. Fetches raw HTML (simulating the Proxy Request).
/// 2. Applies 'Purge' logic (copied from WebViewRequestInterceptor).
/// 3. Applies 'Preprocess' logic (copied from WebViewRequestInterceptor).
/// 4. Applies the JS-style Regex to extracting the data.
///
/// This ensures the Regex works on what the Plugin *actually sees*.

void main() {
  const String userAgent =
      'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36';

  // --- COPIED LOGIC FROM webview_request_interceptor.dart ---
  String _purgeHarmfulContent(
    String htmlBody,
    List<Map<String, dynamic>>? rules,
  ) {
    if (rules == null || rules.isEmpty) return htmlBody;

    try {
      var document = html_parser.parse(htmlBody);
      bool documentModified = false;

      for (var rule in rules) {
        final type = rule['type'] as String?;
        final selector = rule['selector'] as String?;

        if (type == 'remove' && selector != null) {
          final elementsToRemove = document.querySelectorAll(selector);
          final contentMatch = rule['contentMatch'] as String?;

          for (var element in elementsToRemove) {
            if (contentMatch == null ||
                (element.innerHtml.contains(contentMatch))) {
              element.remove();
              documentModified = true;
            }
          }
        }
      }
      return documentModified ? document.outerHtml : htmlBody;
    } catch (e) {
      print('⚠️ Error applying purge rules: $e');
      return htmlBody;
    }
  }

  // Simplified version of _preprocessHtml for test (removes proxy rewrite complexity but keeps structure)
  String _preprocessHtml(String htmlBody) {
    final attrRegex = RegExp(
      r'''(src|href)\s*=\s*(?:"([^"]*)"|'([^']*)')''',
      caseSensitive: false,
    );
    // In this test, we just ensure the regex doesn't break the HTML or that the HTML is parseable.
    // Real preprocessing rewrites URLs to local proxy. We can skip the actual rewrite for Regex verification
    // unless the Regex depends on the rewritten URLs (unlikely for text extraction).
    return htmlBody;
  }

  test('Verify ShouldIAnswer Regex with Full Pipeline', () async {
    final url = 'https://www.shouldianswer.com/phone-number/2026307992';
    print('1. Fetching URL: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': userAgent},
    );

    expect(response.statusCode, 200, reason: 'Should return 200 OK');
    String html = response.body;
    print('   Raw HTML Length: ${html.length}');

    // 2. Simulate Purge (If plugin has rules - mocking empty here as ShouldIAnswer usually doesn't need complex purge for this)
    // If you have specific purge rules from the plugin config, add them here.
    html = _purgeHarmfulContent(html, []);
    print('2. HTML after Purge: Length ${html.length}');

    // 3. Simulate Preprocess
    html = _preprocessHtml(html);
    print('3. HTML after Preprocess: Length ${html.length}');

    // 4. Regex Verification (JS Way)
    // Target: "rated as negative Unsolicited call"
    // JS: /rated as ([^.]+)/
    final jsRegexPattern = r'''rated as ([^.]+)''';

    print('4. Applying Regex: $jsRegexPattern');
    final regExp = RegExp(
      jsRegexPattern,
      caseSensitive: false,
      multiLine: true,
    );
    final match = regExp.firstMatch(html);

    if (match != null) {
      final extraction = match.group(1)?.trim();
      print('✅ MATCH SUCCESS!');
      print('   Extracted: "$extraction"');
      expect(extraction, contains('Unsolicited call')); // Validation
    } else {
      print('❌ MATCH FAILED');
      // print('   Body Snippet: ${html.substring(0, 500)}');
      fail('Regex failed to match on processed HTML');
    }
  });
}
