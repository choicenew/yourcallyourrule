import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widget Render & Frame Latency Benchmark', () {
    testWidgets('Measure frame pump latency under state rebuild spikes', (WidgetTester tester) async {
      int counter = 0;
      late StateSetter triggerRebuild;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                triggerRebuild = setState;
                return ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Item $index - Counter: $counter'),
                      subtitle: Text('Subtitle calculation index $index'),
                      trailing: const Icon(Icons.phone),
                    );
                  },
                );
              },
            ),
          ),
        ),
      );

      final frameTimes = <double>[];
      const pumpCycles = 60; // Simulate 60 frame updates

      for (int i = 0; i < pumpCycles; i++) {
        final frameWatch = Stopwatch()..start();
        triggerRebuild(() {
          counter++;
        });
        await tester.pump();
        frameWatch.stop();
        frameTimes.add(frameWatch.elapsedMicroseconds / 1000.0);
      }

      frameTimes.sort();
      final avgFrameMs = frameTimes.reduce((a, b) => a + b) / frameTimes.length;
      final p95FrameMs = frameTimes[(frameTimes.length * 0.95).floor()];
      final maxFrameMs = frameTimes.last;
      final jankFrames = frameTimes.where((t) => t > 16.6).length;

      print('PERF_METRIC: {"metric": "widget_frame_latency", "frames": $pumpCycles, "avg_frame_ms": $avgFrameMs, "p95_frame_ms": $p95FrameMs, "max_frame_ms": $maxFrameMs, "jank_frames_above_16ms": $jankFrames}');

      // In test environment, un-optimized frame latency threshold before catastrophic block
      expect(avgFrameMs, lessThan(100.0), reason: 'Severe UI thread freeze detected');
    });

    testWidgets('Measure layout build cost on nested complex tree', (WidgetTester tester) async {
      final stopwatch = Stopwatch()..start();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  50,
                  (index) => Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.security),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Security Rule #$index details label')),
                        Switch(value: index % 2 == 0, onChanged: (v) {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      stopwatch.stop();
      final initialMountMs = stopwatch.elapsedMicroseconds / 1000.0;
      print('PERF_METRIC: {"metric": "initial_widget_mount", "mount_ms": $initialMountMs}');

      expect(initialMountMs, lessThan(500.0), reason: 'Initial widget tree mount is too slow');
    });
  });
}
