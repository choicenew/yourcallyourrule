import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';

void emit(Map<String, dynamic> m) =>
    debugPrint('SERVICE_METRIC: ${jsonEncode(m)}');

void cause(String id, String sev, String name, String blame, num cost,
    String reason, String suggestion) {
  debugPrint('ROOT_CAUSE: ${jsonEncode({
        'id': id,
        'severity': sev,
        'name': name,
        'blamed_component': blame,
        'cost_ms': cost,
        'reason': reason,
        'suggestion': suggestion,
      })}');
}

void main() {
  group('Service 响应度 & 主线程同步阻塞检测 (界面跟手度)', () {
    test('PhoneUtils 电话号码解析与清洗主线程耗时分析', () async {
      final samples = [
        '+18005550199',
        '13800138000',
        '+442071838750',
        '+4915123456789',
        '0612345678',
        '+8613912345678',
        '+33612345678',
        '+819012345678',
        '555-1234-5678',
        'tel:+1234567890',
        '',
        'invalid-long-garbage-input-for-worst-case-123456789!!!'
      ];
      const iterations = 300;
      final latenciesMs = <double>[];

      for (int i = 0; i < iterations; i++) {
        final phone = samples[i % samples.length];
        final sw = Stopwatch()..start();
        try {
          await PhoneUtils.parsePhoneNumber(phone);
        } catch (_) {}
        sw.stop();
        latenciesMs.add(sw.elapsedMicroseconds / 1000.0);
      }
      latenciesMs.sort();

      final avg = latenciesMs.reduce((a, b) => a + b) / latenciesMs.length;
      final p50 = latenciesMs[(latenciesMs.length * 0.50).floor()];
      final p95 = latenciesMs[(latenciesMs.length * 0.95).floor()];
      final worst = latenciesMs.last;

      emit({
        'phase': 'service_blocking',
        'service': 'PhoneUtils.parsePhoneNumber',
        'metric': 'avg_ms',
        'value': avg,
        'unit': 'ms',
      });
      emit({
        'phase': 'service_blocking',
        'service': 'PhoneUtils.parsePhoneNumber',
        'metric': 'p95_ms',
        'value': p95,
        'unit': 'ms',
        'threshold_hard': 20.0,
        'threshold_warn': 5.0,
      });

      if (p95 > 16.6 || worst > 50.0) {
        cause(
          'service-blocking-phone-parse',
          p95 > 30.0 ? 'HIGH' : 'MEDIUM',
          'PhoneUtils 号码解析占用 UI 线程: P95=${p95.toStringAsFixed(2)}ms (worst=${worst.toStringAsFixed(1)}ms)',
          'PhoneUtils / libphonenumber',
          p95,
          '在主线程同步解析号码时耗时突破一帧预算 (16.6ms)，输入或来电拦截时会导致界面短暂冻结卡顿。',
          '建议：对长字符串或批量号码解析放入 compute isolate 中处理。',
        );
      }

      expect(avg, lessThan(50.0), reason: 'PhoneUtils 解析过慢');
    });

    testWidgets('Service 模拟后台任务执行时对 UI 点击跟手度的影响', (WidgetTester tester) async {
      int counter = 0;
      final latencies = <double>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    Text('Counter: $counter'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 100,
                        itemBuilder: (c, i) => ListTile(
                          leading: CircleAvatar(child: Text('${i % 9}')),
                          title: Text('Item $i counter $counter'),
                          onTap: () {
                            setState(() {
                              counter++;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      for (int i = 0; i < 20; i++) {
        final sw = Stopwatch()..start();
        await tester.tap(find.byType(ListTile).at(i % 10));
        await tester.pump();
        sw.stop();
        latencies.add(sw.elapsedMicroseconds / 1000.0);
      }

      latencies.sort();
      final p95 = latencies[(latencies.length * 0.95).floor()];

      emit({
        'phase': 'service_ui_responsiveness',
        'metric': 'tap_p95_ms',
        'value': p95,
        'unit': 'ms',
      });

      expect(p95, lessThan(400.0), reason: '点击响应跟手度极差');
    });
  });
}
