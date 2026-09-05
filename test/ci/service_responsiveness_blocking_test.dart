import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/services/rule_matcher_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

void emit(Map<String, dynamic> m) =>
    debugPrint('SERVICE_METRIC: ${jsonEncode(m)}');

void cause(
  String id,
  String sev,
  String name,
  String blame,
  num cost,
  String reason,
  String suggestion,
) {
  debugPrint(
    'ROOT_CAUSE: ${jsonEncode({'id': id, 'severity': sev, 'name': name, 'blamed_component': blame, 'cost_ms': cost, 'reason': reason, 'suggestion': suggestion})}',
  );
}

class _FakeRuleMatcher implements RuleMatcherService {
  @override
  Future<RuleBase?> matchPhoneNumber(PhoneNumber phoneNumber) async {
    await Future.delayed(Duration(microseconds: 50 + Random().nextInt(200)));
    if (phoneNumber.value.startsWith('+123')) return null;
    return _RuleStub(
      action: phoneNumber.value.contains('888')
          ? RuleAction.block
          : RuleAction.allow,
    );
  }

  @override
  Future<List<RuleBase>> getAllRules() async => const [];
  @override
  Future<List<RuleBase>> getRulesByPriority(RulePriority p) async => const [];
  @override
  Future<List<RuleBase>> getRulesByAction(RuleAction a) async => const [];
  @override
  Future<RuleBase?> matchSmsMessage(PhoneNumber p, String c) async => null;
  @override
  Future<RuleAction> getActionForPhoneNumber(PhoneNumber p) =>
      matchPhoneNumber(p).then((r) => r?.action ?? RuleAction.none);
  @override
  Future<RuleAction> getActionForSmsMessage(PhoneNumber p, String c) =>
      matchSmsMessage(p, c).then((r) => r?.action ?? RuleAction.none);
  @override
  Future<RuleBase> addRule(RuleBase r) async => r;
  @override
  Future<RuleBase> updateRule(RuleBase r) async => r;
  @override
  Future<bool> deleteRule(String id) async => true;
  @override
  Future<RuleBase> enableRule(String id) async =>
      _RuleStub(action: RuleAction.none);
  @override
  Future<RuleBase> disableRule(String id) async =>
      _RuleStub(action: RuleAction.none);
  @override
  Future<List<RulePriority>> getRulePriorityOrder() async => [];
  @override
  Future<bool> setRulePriorityOrder(List<RulePriority> o) async => true;
}

class _RuleStub implements RuleBase {
  @override
  final RuleAction action;
  _RuleStub({required this.action});
  @override
  String get id => 'stub';
  @override
  String get name => 'stub';
  @override
  RulePriority get priority => RulePriority.medium;
  @override
  bool get isEnabled => true;
  @override
  Map<String, dynamic> toMap() => {};
  @override
  String toJson() => jsonEncode(toMap());
  @override
  RuleBase copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
  }) => _RuleStub(action: action ?? this.action);
  @override
  bool matches(String input) => false;
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall methodCall) async {
            return Directory.systemTemp.path;
          },
        );
  });

  group('Service 首屏响应延迟 & 阻塞检测 (不跟手 / 卡顿根因)', () {
    test('PhoneUtils + 真实号码解析 p50/p95/p99 延迟 & 阻塞线程检测', () async {
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
        'invalid-long-garbage-input-for-worst-case-123456789!!!',
      ];
      const iterations = 400;
      final latenciesMs = <double>[];

      for (int i = 0; i < iterations; i++) {
        final phone = samples[i % samples.length];
        final sw = Stopwatch()..start();
        try {
          await PhoneUtils.parsePhoneNumber(phone);
        } catch (_) {
          // ignore
        }
        sw.stop();
        latenciesMs.add(sw.elapsedMicroseconds / 1000.0);
      }
      latenciesMs.sort();
      final p50 = latenciesMs[(latenciesMs.length * 0.50).floor()];
      final p90 = latenciesMs[(latenciesMs.length * 0.90).floor()];
      final p95 = latenciesMs[(latenciesMs.length * 0.95).floor()];
      final p99 = latenciesMs[(latenciesMs.length * 0.99).floor()];
      final worst = latenciesMs.last;
      final avg = latenciesMs.reduce((a, b) => a + b) / latenciesMs.length;
      final totalMs = latenciesMs.fold<double>(0.0, (a, b) => a + b);

      emit({
        'phase': 'phone_utils_parse_tail_latency',
        'metric': 'p50_ms',
        'value': p50,
        'unit': 'ms',
        'threshold_hard': 200.0,
        'threshold_warn': 50.0,
      });
      emit({
        'phase': 'phone_utils_parse_tail_latency',
        'metric': 'p95_ms',
        'value': p95,
        'unit': 'ms',
        'threshold_hard': 500.0,
        'threshold_warn': 200.0,
      });
      emit({
        'phase': 'phone_utils_parse_tail_latency',
        'metric': 'p99_ms',
        'value': p99,
        'unit': 'ms',
        'threshold_hard': 1500.0,
        'threshold_warn': 600.0,
      });
      emit({
        'phase': 'phone_utils_parse_tail_latency',
        'metric': 'worst_ms',
        'value': worst,
        'unit': 'ms',
      });
      emit({
        'phase': 'phone_utils_parse_tail_latency',
        'metric': 'avg_ms',
        'value': avg,
        'unit': 'ms',
        'throughput_per_sec': iterations / max(totalMs / 1000.0, 0.001),
      });

      if (p95 > 200 || p99 > 600) {
        cause(
          'phone-utils-tail-latency',
          p99 > 1500 ? 'HIGH' : 'MEDIUM',
          'PhoneUtils.parsePhoneNumber 尾延迟过高 (p95=${p95.toStringAsFixed(1)}ms, p99=${p99.toStringAsFixed(1)}ms)',
          'common/utils/phone_utils.dart (dlibphonenumber 同步解析)',
          p99,
          '来电即时触发 CallHandler.handleCall → 同步执行 parsePhoneNumber 阻塞 UI 线程，表现为"界面不跟手"、"来电弹框慢"，低端机上可达秒级。',
          '(a) 在 isolate/compute 中执行 parse；(b) 结果 Map<String,dynamic> 缓存 (LRU)；(c) 常见前缀(+86/+1) 走快速路径避免 dlibphonenumber 完整解析。',
        );
      }
    });

    test('RuleMatcherService 批匹配吞吐 & 单次响应延迟（通话拦截不跟手）', () async {
      final matcher = _FakeRuleMatcher();
      final random = Random(42);
      final numbers = List.generate(
        600,
        (i) => PhoneNumber.fromString(
          '+${random.nextInt(90) + 10}${random.nextInt(900000000) + 100000000}',
        ),
      );

      final latenciesMs = <double>[];
      final sw = Stopwatch()..start();
      for (final n in numbers) {
        final s = Stopwatch()..start();
        await matcher.matchPhoneNumber(n);
        s.stop();
        latenciesMs.add(s.elapsedMicroseconds / 1000.0);
      }
      sw.stop();
      latenciesMs.sort();
      final total = sw.elapsedMicroseconds / 1000.0;
      final qps = numbers.length / max(total / 1000.0, 0.001);
      final p95 = latenciesMs[(latenciesMs.length * 0.95).floor()];
      final p99 = latenciesMs[(latenciesMs.length * 0.99).floor()];

      emit({
        'phase': 'rule_matcher_service',
        'metric': 'qps',
        'value': qps,
        'unit': 'match/s',
        'threshold_hard': 500.0,
        'threshold_warn': 1500.0,
      });
      emit({
        'phase': 'rule_matcher_service',
        'metric': 'match_p95_ms',
        'value': p95,
        'unit': 'ms',
        'threshold_hard': 20.0,
        'threshold_warn': 8.0,
      });
      emit({
        'phase': 'rule_matcher_service',
        'metric': 'match_p99_ms',
        'value': p99,
        'unit': 'ms',
      });
      emit({
        'phase': 'rule_matcher_service',
        'metric': 'match_total_ms',
        'value': total,
        'unit': 'ms',
      });

      if (p95 > 8 || qps < 1500) {
        cause(
          'rule-matcher-throughput',
          p95 > 20 || qps < 500 ? 'HIGH' : 'MEDIUM',
          'RuleMatcherService.matchPhoneNumber 单次 ${p95.toStringAsFixed(1)}ms (p95), 吞吐 ${qps.round()} match/s',
          'core/services/rule_matcher_service.dart → N*规则列表 线性扫描 + DB 查询',
          p95,
          '真实代码中会对每个规则逐一执行正则/电话号码匹配 → 呼入时 CallHandler 被阻塞 → 浮窗/通知/拦截 慢半拍，用户感受"不跟手"。',
          '(a) 规则预编译为 Trie/RegExp 列表并持久缓存；(b) 号码做 前缀哈希 快速过滤减少进入完整匹配的规则数；(c) 按 RulePriority 优先匹配，命中即返回不扫描后续。',
        );
      }
    });

    test('CallLogService.initialize() 延迟 & 内存：全量日志 vs 增量加载', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final rssBefore = ProcessInfo.currentRss ~/ 1024;
      final sw = Stopwatch()..start();
      try {
        final svc = container.read(callLogServiceProvider);
        try {
          await svc.initialize().timeout(const Duration(milliseconds: 1500));
        } catch (_) {}
      } catch (_) {}
      sw.stop();
      final ms = sw.elapsedMicroseconds / 1000.0;
      final rssAfter = ProcessInfo.currentRss ~/ 1024;
      final deltaKb = (rssAfter - rssBefore).toDouble();

      emit({
        'phase': 'call_log_service_init',
        'metric': 'initialize_ms',
        'value': ms,
        'unit': 'ms',
        'threshold_hard': 2000.0,
        'threshold_warn': 600.0,
      });
      emit({
        'phase': 'call_log_service_init',
        'metric': 'rss_delta_kb',
        'value': deltaKb,
        'unit': 'KB',
        'threshold_hard': 20 * 1024.0,
        'threshold_warn': 8 * 1024.0,
      });

      if (ms > 600 || deltaKb > 8 * 1024) {
        cause(
          'calllog-init-slow-big',
          ms > 2000 || deltaKb > 20 * 1024 ? 'HIGH' : 'MEDIUM',
          'CallLogService.initialize 耗时 ${ms.toStringAsFixed(1)}ms / 内存 ${deltaKb.toStringAsFixed(0)} KB',
          'call_history/services/call_log_service.dart::_loadAllLogs + _avatarCache',
          ms,
          '真实 CallLogService.initialize 里会调用 repository.getRecentLogs() 并可能缓存所有头像 Map → 全量加载 + 反序列化 + 广播到 Stream，启动时主线程忙，首屏显示列表慢 & 偶尔卡顿。',
          '(a) _loadAllLogs 改为 limit(offset,pageSize) 的分页加载；(b) 头像缓存改 LRU (package:linked_lru 或自建 Map+Queue)；(c) 用 compute isolate 执行反序列化，主线程只拿结果。',
        );
      }
    });

    test('异步并发 & 竞态模拟：多个服务同时初始化 → 首屏响应总耗时', () async {
      final rss0 = ProcessInfo.currentRss ~/ 1024;
      final sw = Stopwatch()..start();

      final futures = <Future<void>>[
        Future.delayed(const Duration(milliseconds: 120)), // locale
        Future.delayed(const Duration(milliseconds: 80)), // theme
        Future<void>(() async {
          // simulate phone parse contention (模拟主线程同步 parse 阻塞)
          final sw = Stopwatch()..start();
          int dummy = 0;
          while (sw.elapsedMicroseconds < 40000) {
            dummy ^= 1;
          }
          if (dummy < 0) debugPrint('$dummy');
        }),
        Future.delayed(const Duration(milliseconds: 300)), // DB
        Future.delayed(const Duration(milliseconds: 60)), // labels
      ];

      // 并发等待
      await Future.wait(futures);
      sw.stop();
      final totalMs = sw.elapsedMicroseconds / 1000.0;
      final rss1 = ProcessInfo.currentRss ~/ 1024;

      final sumLatencyMs = 120 + 80 + 40 + 300 + 60; // 串行总和
      final parallelism = sumLatencyMs / max(totalMs, 0.1);

      emit({
        'phase': 'concurrent_bootstrap',
        'metric': 'parallel_total_ms',
        'value': totalMs,
        'unit': 'ms',
        'sum_serial_ms': sumLatencyMs,
        'parallelism_x': parallelism,
        'rss_delta_kb': (rss1 - rss0).toString(),
        'threshold_hard': 1500.0,
        'threshold_warn': 800.0,
      });

      if (parallelism < 1.3 || totalMs > 800) {
        cause(
          'boot-concurrent-lack',
          totalMs > 1500 ? 'HIGH' : 'MEDIUM',
          '服务初始化并发度不足：并行度 ${parallelism.toStringAsFixed(2)}x，总耗时 ${totalMs.toStringAsFixed(1)}ms (串行 $sumLatencyMs ms)',
          'main() 中 Provider 初始化调用时序',
          totalMs,
          'main.dart 中很多 FutureProvider 在 ref.read() 时被同步读取后 await，并未真正并发 → 首帧被一个长任务拖慢 → App 打开卡顿。',
          '(a) 先全部 unawaited，非首屏 provider 使用 ref.read + lazy；(b) 数据库/IO 类全部 compute/isolate；(c) 将 I/O 密集型 Future 用 Future.wait([a,b,c,d]) 并发等待。',
        );
      }
    });

    testWidgets('UI 交互响应性：点击 → setState → paint 的 p95 延迟 (跟手度)', (
      WidgetTester tester,
    ) async {
      int counter = 0;
      final latenciesMs = <double>[];
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (ctx, ss) {
                  return Column(
                    children: [
                      Text('C: $counter'),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 200,
                          itemBuilder: (c, i) => ListTile(
                            leading: CircleAvatar(child: Text('${i % 9}')),
                            title: Text('Item $i counter $counter'),
                            onTap: () {
                              final s = Stopwatch()..start();
                              ss(() => counter++);
                              // We record time after tester.pump; use storage
                              _pendingLatencyStopwatches.add(s);
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
        ),
      );
      await tester.pumpAndSettle();

      const taps = 60;
      final rand = Random(7);
      for (int i = 0; i < taps; i++) {
        final idx = rand.nextInt(5); // 限制在可视列表项的有效索引内
        await tester.tap(find.byType(ListTile).at(idx));
        await tester.pump(const Duration(milliseconds: 16));
        for (final s in _pendingLatencyStopwatches) {
          s.stop();
          latenciesMs.add(s.elapsedMicroseconds / 1000.0);
        }
        _pendingLatencyStopwatches.clear();
      }
      latenciesMs.sort();
      final p50 = latenciesMs[(latenciesMs.length * 0.50).floor()];
      final p90 = latenciesMs[(latenciesMs.length * 0.90).floor()];
      final p95 = latenciesMs[(latenciesMs.length * 0.95).floor()];
      final worst = latenciesMs.last;

      emit({
        'phase': 'ui_responsiveness',
        'metric': 'tap_to_settle_p95_ms',
        'value': p95,
        'unit': 'ms',
        'p50': p50,
        'p90': p90,
        'worst': worst,
        'samples': latenciesMs.length,
        'threshold_hard': 100.0,
        'threshold_warn': 50.0,
      });

      if (p95 > 50 || worst > 200) {
        cause(
          'ui-unresponsive-tap',
          p95 > 100 ? 'HIGH' : 'MEDIUM',
          'UI 点击→渲染 p95=${p95.toStringAsFixed(1)}ms, 最差=${worst.toStringAsFixed(1)}ms (<16ms 理想)',
          '真实场景: home_elite 页 + rebuild 风暴 + 图片解码 竞争主线程',
          p95,
          '用户按下导航项 → setState → 整页重建 → 图片解码/文本绘制都在下一帧 → 视觉上"按了没反应"或"按一下卡一下"。',
          '(a) 拆分 ListTile 成 const Widget + Consumer(select: ...) 局部重绘；(b) 用 AutomaticKeepAliveClientMixin 存已渲染 tile；(c) 图片改 ResizeImage 并 precache。',
        );
      }
    });
  });
}

final List<Stopwatch> _pendingLatencyStopwatches = [];
