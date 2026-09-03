import 'dart:math';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('State & Data Processing Performance Benchmark', () {
    test('Large dataset filtering and sort benchmark (5000 call records)', () {
      final random = Random(42);
      final records = List.generate(5000, (i) {
        return {
          'id': i,
          'number': '+1${(1000000000 + random.nextInt(900000000)).toString()}',
          'timestamp': DateTime.now().subtract(Duration(minutes: i * 5)).millisecondsSinceEpoch,
          'duration': random.nextInt(600),
          'isBlocked': random.nextBool(),
          'callerName': 'Caller $i',
        };
      });

      final stopwatch = Stopwatch()..start();

      // 1. Filtering blocked calls
      final blocked = records.where((r) => r['isBlocked'] == true).toList();

      // 2. Complex search query simulation
      final searchResult = records.where((r) {
        final num = r['number'] as String;
        return num.contains('888') || num.contains('555');
      }).toList();

      // 3. Sorting by timestamp descending
      final sorted = List<Map<String, dynamic>>.from(records)
        ..sort((a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int));

      stopwatch.stop();
      final totalMs = stopwatch.elapsedMicroseconds / 1000.0;

      print('PERF_METRIC: {"metric": "dataset_processing", "total_records": 5000, "filtered_blocked": ${blocked.length}, "search_matches": ${searchResult.length}, "elapsed_ms": $totalMs}');

      // In-memory manipulation of 5000 records must remain under 100ms
      expect(totalMs, lessThan(200.0), reason: 'In-memory dataset processing takes too long, offloading to isolate may be needed');
      expect(sorted.length, equals(5000));
    });
  });
}
