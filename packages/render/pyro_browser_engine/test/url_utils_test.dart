import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_browser_engine/pyro_browser_engine.dart';

void main() {
  group('UrlUtils Tests', () {
    test('converts http:// to https://', () {
      expect(
        UrlUtils.sanitizeUrl('http://example.com/news/1'),
        equals('https://example.com/news/1'),
      );
    });

    test('preserves https:// URLs', () {
      expect(
        UrlUtils.sanitizeUrl('https://example.com/news/1'),
        equals('https://example.com/news/1'),
      );
    });

    test('adds https:// scheme if missing', () {
      expect(
        UrlUtils.sanitizeUrl('example.com/news/1'),
        equals('https://example.com/news/1'),
      );
    });

    test('handles empty input gracefully', () {
      expect(UrlUtils.sanitizeUrl('   '), equals(''));
    });
  });
}
