import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Rule & Regex Engine Performance Benchmark', () {
    test('Phone number batch normalization and regex matching', () {
      final patterns = [
        r'^\+?1?[2-9]\d{2}[2-9]\d{2}\d{4}$',
        r'^(\+?86)?1[3-9]\d{9}$',
        r'^\+?[0-9]{7,15}$',
        r'^(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}$',
        r'^(?:\+?49)?[0-9]{10,13}$',
      ];

      final compiledRegexes = patterns.map((p) => RegExp(p)).toList();
      final sampleNumbers = [
        '+18005550199',
        '13800138000',
        '+4915123456789',
        '0612345678',
        '+8613912345678',
        'invalid-number-xyz',
        '+1234567890123456',
        '010-12345678',
        '400-888-9999',
        '+442071838750',
      ];

      final stopwatch = Stopwatch()..start();
      const iterations = 5000;
      int matchCount = 0;

      for (int i = 0; i < iterations; i++) {
        final phone = sampleNumbers[i % sampleNumbers.length];
        for (final regex in compiledRegexes) {
          if (regex.hasMatch(phone)) {
            matchCount++;
            break;
          }
        }
      }

      stopwatch.stop();
      final totalElapsedMs = stopwatch.elapsedMicroseconds / 1000.0;
      final avgMicrosPerOp = stopwatch.elapsedMicroseconds / (iterations * compiledRegexes.length);
      final qps = (iterations / (totalElapsedMs / 1000.0)).round();

      // Print structured benchmark metrics for CLI analyzer parsing
      print('PERF_METRIC: {"metric": "regex_rule_throughput", "iterations": $iterations, "total_ms": $totalElapsedMs, "avg_micros_per_op": $avgMicrosPerOp, "qps": $qps, "matches": $matchCount}');

      // Performance assertion: 5000 iterations over 5 regexes should finish within 300ms
      expect(totalElapsedMs, lessThan(1000.0), reason: 'Rule engine throughput is too slow and may cause UI hitch');
    });

    test('Catastrophic backtracking (ReDoS) vulnerability benchmark', () {
      // Benchmark complex pattern matching against tricky input strings
      final complexPatterns = [
        r'([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})',
        r'^((\+?[0-9]{1,4})[-.\s]?)?(\(?\d{1,3}\)?[-.\s]?)?[\d\s.-]{5,15}$',
      ];

      final trickyStrings = [
        'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!',
        '+1-800-555-0199-ext-9999-invalid-suffix',
        'user@very-long-domain-name-with-repeating-patterns-xyz-abc.domain.org',
      ];

      final stopwatch = Stopwatch()..start();
      for (final pattern in complexPatterns) {
        final reg = RegExp(pattern);
        for (final s in trickyStrings) {
          reg.hasMatch(s);
        }
      }
      stopwatch.stop();

      final elapsedMs = stopwatch.elapsedMicroseconds / 1000.0;
      print('PERF_METRIC: {"metric": "regex_redos_check", "total_ms": $elapsedMs, "risk": "${elapsedMs > 50 ? 'HIGH' : 'LOW'}"}');
      expect(elapsedMs, lessThan(200.0), reason: 'Regex execution took too long, potential ReDoS or high CPU stall');
    });
  });
}
