import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

/// INTEGRATED VERIFICATION TEST - CLEVERDIALER
/// URL: https://www.cleverdialer.com/phonenumber/8133760930

void main() {
  const String userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36';

  // --- COPIED PIPELINE LOGIC ---
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
          for (var element in elementsToRemove) {
            element.remove();
            documentModified = true;
          }
        }
      }
      return documentModified ? document.outerHtml : htmlBody;
    } catch (e) {
      return htmlBody;
    }
  }

  String _preprocessHtml(String htmlBody) {
    // Simplified preprocessing for regex verification
    return htmlBody;
  }

  test('Verify CleverDialer Regex with Full Pipeline', () async {
    final url = 'https://www.cleverdialer.com/phonenumber/8133760930';
    print('1. Fetching URL: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': userAgent},
    );

    expect(response.statusCode, 200, reason: 'Should return 200 OK');
    String html = response.body;
    print('   Raw HTML Length: ${html.length}');

    // 2. Simulate Purge (Empty rules for now)
    html = _purgeHarmfulContent(html, []);

    // 3. Simulate Preprocess
    html = _preprocessHtml(html);
    print('3. HTML after Pipeline: Length ${html.length}');

    // 4. Regex Verification
    // We want to find "Cost trap" which is the Call Reason.
    // Based on typical CleverDialer HTML, it might be in a text block or table cell.
    // We try to match the specific content from the screenshot to verify data presence.

    // Pattern: Just looking for the string first to confirm presence
    // JS: /Cost trap/
    final jsRegexPattern1 = r'''Cost trap''';

    // Pattern: A potential extraction regex for the "Call reason" column ?
    // This is hard without seeing the exact HTML, but we check presence first.

    print('4. Applying Regex: $jsRegexPattern1');
    final regExp = RegExp(jsRegexPattern1, caseSensitive: false);

    if (regExp.hasMatch(html)) {
      print('✅ MATCH SUCCESS! Found "Cost trap"');
    } else {
      print('❌ MATCH FAILED: "Cost trap" not found.');
      // print('   Body Snippet: ${html.substring(0, html.length > 2000 ? 2000 : html.length)}');
    }

    // Try finding "Crypto fraud" too
    final jsRegexPattern2 = r'''Crypto fraud''';
    if (RegExp(jsRegexPattern2, caseSensitive: false).hasMatch(html)) {
      print('✅ MATCH SUCCESS! Found "Crypto fraud"');
    }
  });
}
