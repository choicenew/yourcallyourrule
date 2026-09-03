import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/provider/contacts_provider.dart';
import 'package:yourcallyourrule/core/provider/labels_provider.dart';
import 'package:yourcallyourrule/core/provider/plugins_provider.dart';
import 'package:yourcallyourrule/core/provider/predefined_labels_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';
import 'package:yourcallyourrule/core/provider/subscriptions_provider.dart';

void emit(Map<String, dynamic> m) =>
    debugPrint('PROVIDER_METRIC: ${jsonEncode(m)}');

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

class TriggerNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void set(int val) => state = val;
}

final triggerNotifierProvider = NotifierProvider<TriggerNotifier, int>(TriggerNotifier.new);

double _getSafeRssKb() {
  try {
    return ProcessInfo.currentRss / 1024;
  } catch (_) {
    return 0;
  }
}

double _measureRead(ProviderContainer c, dynamic p, {int runs = 1}) {
  final sw = Stopwatch()..start();
  for (int i = 0; i < runs; i++) {
    try {
      c.read(p);
    } catch (_) {}
  }
  sw.stop();
  return sw.elapsedMicroseconds / 1000.0 / runs;
}

Future<double> _measureAwait(ProviderContainer c, dynamic p,
    {Duration timeout = const Duration(milliseconds: 800)}) async {
  final sw = Stopwatch()..start();
  try {
    final dynamic v = c.read(p);
    if (v is Future) {
      await v.timeout(timeout).catchError((_) {});
    }
  } catch (_) {}
  sw.stop();
  return sw.elapsedMicroseconds / 1000.0;
}

void main() {
  group('Provider 初始化成本 & 重建风暴 & 级联依赖深度检测（基于 Riverpod 3.0 体验标准）', () {
    test('Top 冷启动 Provider 排序 + 级联依赖深度分析', () async {
      final asyncNotifierLike = <(String, dynamic)>[
        ('rulesProvider (AsyncNotifier: RuleRepository.getAll)',
            rulesProvider),
        (
          'contactsProvider (AsyncNotifier: ContactRepository.getAll)',
          contactsProvider
        ),
        (
          'labelsProvider (AsyncNotifier: LabelRepository.getAll)',
          labelsProvider
        ),
        (
          'predefinedLabelsProvider (AsyncNotifier: shared_prefs + decode)',
          predefinedLabelsProvider
        ),
        (
          'subscriptionsProvider (AsyncNotifier: SubscriptionRepository.getAll)',
          subscriptionsProvider
        ),
        (
          'pluginsProvider (AsyncNotifier: PluginRepository.getAll + 校验)',
          pluginsProvider
        ),
      ];

      final serviceWithDeps = <(String, dynamic, List<String>)>[
        (
          'callLogServiceProvider (ref.watch 5 下游)',
          callLogServiceProvider,
          [
            'callLogRepositoryProvider',
            'contactServiceProvider',
            'labelServiceProvider',
            'allowedBlockedServiceProvider',
            'ruleManagementServiceProvider',
          ]
        ),
        (
          'ruleManagementServiceProvider',
          ruleManagementServiceProvider,
          ['ruleRepositoryProvider']
        ),
      ];

      final results = <Map<String, dynamic>>[];

      for (final p in asyncNotifierLike) {
        final c = ProviderContainer();
        final cold = await _measureAwait(c, p.$2);
        final hot = _measureRead(c, p.$2, runs: 10);
        c.dispose();
        results.add({
          'provider': p.$1,
          'category': 'AsyncNotifier_build_ms',
          'cold_ms': cold,
          'hot_read_ms': hot,
          'type': 'AsyncNotifier',
        });
        emit({
          'phase': 'provider_init_cost',
          'type': 'AsyncNotifier',
          'metric': p.$1,
          'cold_ms': cold,
          'hot_read_ms': hot,
          'value': cold,
          'unit': 'ms',
          'threshold_hard': 500.0,
          'threshold_warn': 150.0,
        });
      }

      for (final s in serviceWithDeps) {
        final c = ProviderContainer();
        final cold = _measureRead(c, s.$2);
        final hot = _measureRead(c, s.$2, runs: 50);
        c.dispose();
        results.add({
          'provider': s.$1,
          'category': 'Service_Dep_Graph_ms',
          'cold_ms': cold,
          'hot_read_ms': hot,
          'dep_count': s.$3.length,
          'deps': s.$3,
          'type': 'Service',
        });
        emit({
          'phase': 'provider_init_cost',
          'type': 'ServiceProvider',
          'metric': s.$1,
          'value': cold,
          'unit': 'ms',
          'dep_count': s.$3.length,
          'threshold_hard': 300.0,
          'threshold_warn': 80.0,
        });
      }

      results.sort(
          (a, b) => (b['cold_ms'] as double).compareTo(a['cold_ms'] as double));

      for (int i = 0; i < results.length; i++) {
        final r = results[i];
        final ms = r['cold_ms'] as double;
        final depCount = r['dep_count'] as int? ?? 0;
        String sev;
        if (ms > 500 || (depCount > 0 && ms > 200)) {
          sev = 'HIGH';
        } else if (ms > 150 || (depCount > 4)) {
          sev = 'MEDIUM';
        } else if (ms < 30) {
          continue;
        } else {
          sev = 'LOW';
        }

        final depMsg = depCount > 0
            ? '级联依赖 $depCount 个下游 Provider (${(r['deps'] as List).join(', ')})'
            : 'AsyncNotifier.build() 直接触发 I/O 仓库查询';

        cause(
          'slow-provider-init-${r['provider']}',
          sev,
          'Provider 启动慢速 Top ${i + 1}: ${r['provider']} 冷启动 ${ms.toStringAsFixed(1)}ms',
          r['provider'] as String,
          ms,
          '$depMsg，导致首帧前大量 UI 阻塞在 Provider build()/数据库读取上。',
          '(a) 若为列表类 AsyncNotifier：拆分为 initial+loadMore 或 useQuery 懒加载；'
              '(b) 把 getAll() 放入 compute isolate；'
              '(c) 服务 Provider 使用依赖最小化，避免级联触发；'
              '(d) Service 拆分细粒度 Provider 避免全量 rebuild。',
        );
      }
    });

    test('Provider 重建风暴：触发 1 次上游 State 更新，量化级联 notify 次数', () {
      final providerA = Provider<int>((ref) {
        final t = ref.watch(triggerNotifierProvider);
        return t * 2;
      });
      final providerB = Provider<int>((ref) {
        final a = ref.watch(providerA);
        return a + 1;
      });
      final providerC = Provider<int>((ref) {
        final b = ref.watch(providerB);
        return b * 3;
      });

      final shared = Provider<int>((ref) => ref.watch(triggerNotifierProvider) + 1);
      final d1 = Provider<int>((ref) => ref.watch(shared) * 2);
      final d2 = Provider<int>((ref) => ref.watch(shared) + 5);
      final d3 = Provider<int>((ref) => ref.watch(shared) * 100);
      final d4 = Provider<int>((ref) => ref.watch(d1) + ref.watch(d2));
      final d5 = Provider<int>((ref) => ref.watch(d3) + ref.watch(d4));

      final c = ProviderContainer();
      addTearDown(c.dispose);

      c.read(triggerNotifierProvider);
      c.read(providerC);
      c.read(d5);

      final notifyCounts = <String, int>{
        'trigger': 0,
        'A': 0,
        'B': 0,
        'C': 0,
        'shared': 0,
        'd1': 0,
        'd2': 0,
        'd3': 0,
        'd4': 0,
        'd5': 0,
      };
      c.listen(triggerNotifierProvider, (p, n) => notifyCounts['trigger'] = notifyCounts['trigger']! + 1,
          fireImmediately: false);
      c.listen(providerA, (p, n) => notifyCounts['A'] = notifyCounts['A']! + 1,
          fireImmediately: false);
      c.listen(providerB, (p, n) => notifyCounts['B'] = notifyCounts['B']! + 1,
          fireImmediately: false);
      c.listen(providerC, (p, n) => notifyCounts['C'] = notifyCounts['C']! + 1,
          fireImmediately: false);
      c.listen(shared, (p, n) => notifyCounts['shared'] = notifyCounts['shared']! + 1,
          fireImmediately: false);
      c.listen(d1, (p, n) => notifyCounts['d1'] = notifyCounts['d1']! + 1,
          fireImmediately: false);
      c.listen(d2, (p, n) => notifyCounts['d2'] = notifyCounts['d2']! + 1,
          fireImmediately: false);
      c.listen(d3, (p, n) => notifyCounts['d3'] = notifyCounts['d3']! + 1,
          fireImmediately: false);
      c.listen(d4, (p, n) => notifyCounts['d4'] = notifyCounts['d4']! + 1,
          fireImmediately: false);
      c.listen(d5, (p, n) => notifyCounts['d5'] = notifyCounts['d5']! + 1,
          fireImmediately: false);

      const mutations = 20;
      final sw = Stopwatch()..start();
      for (int i = 1; i <= mutations; i++) {
        c.read(triggerNotifierProvider.notifier).set(i);
      }
      sw.stop();
      final double totalMs = sw.elapsedMicroseconds / 1000.0;
      final double perMs = totalMs / mutations;
      final totalNotify = notifyCounts.values.fold<int>(0, (a, b) => a + b);

      emit({
        'phase': 'rebuild_storm',
        'metric': '20_mutations_total_ms',
        'value': totalMs,
        'unit': 'ms',
        'per_mutation_ms': perMs,
        'total_notify_count': totalNotify,
        'notify_per_mutation': totalNotify / mutations,
        'threshold_hard': 500.0,
        'threshold_warn': 150.0,
      });

      final notifiesPerMutation = totalNotify / mutations;
      if (perMs > 10 || notifiesPerMutation > 30) {
        cause(
          'rebuild-storm-fan-out',
          perMs > 25 || notifiesPerMutation > 50 ? 'HIGH' : 'MEDIUM',
          'Provider 重建风暴: 20 次更新触发 $totalNotify 次 notify (${notifiesPerMutation.toStringAsFixed(1)} 次/更新)',
          '级联依赖链 (trigger→A→B→C)',
          perMs,
          '单次状态更新触发深度级联 notify，导致 UI 反复 rebuild 拖慢跟手感。',
          '建议使用 select((s) => s.field) 精确订阅。',
        );
      }

      expect(c.read(providerC), equals(3 * (2 * mutations + 1)));
      expect(totalNotify, greaterThanOrEqualTo(mutations));
    });

    test('Provider 内存泄漏: autoDispose 生命周期检测', () {
      final leaks = <String, int>{};
      final leakDetector = Provider.autoDispose<String>((ref) {
        final id = 'autodispose-${identityHashCode(ref)}';
        ref.onDispose(() => leaks[id] = (leaks[id] ?? 0) + 1);
        return id;
      });

      final baselineRssKb = _getSafeRssKb();
      const cycles = 200;
      final sw = Stopwatch()..start();

      int disposedProper = 0;
      for (int i = 0; i < cycles; i++) {
        final c = ProviderContainer();
        final instance = c.read(leakDetector);
        final sub = c.listen<String>(leakDetector, (p, n) {});
        sub.close();
        c.dispose();
        if (leaks.containsKey(instance)) disposedProper++;
      }
      sw.stop();

      final endRssKb = _getSafeRssKb();
      final growthKb = endRssKb - baselineRssKb;
      final perCycleKb = growthKb / cycles;
      final totalMs = sw.elapsedMicroseconds / 1000.0;

      emit({
        'phase': 'memory_leak_provider_autodispose',
        'metric': 'proper_disposed_count',
        'value': disposedProper.toDouble(),
        'expected': cycles.toDouble(),
        'unit': 'count',
      });

      expect(disposedProper, equals(cycles),
          reason: 'autoDispose Provider 的 onDispose 应正常触发');
    });
  });
}
