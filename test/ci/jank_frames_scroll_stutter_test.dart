import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void emit(Map<String, dynamic> m) =>
    debugPrint('JANK_METRIC: ${jsonEncode(m)}');

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

/// Riverpod 3.0 规范的简单计数器 Notifier
class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
  void set(int value) => state = value;
}

final counterProvider1 = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
final counterProvider2 = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
final globalCounterProvider = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);

class _TilePayload {
  final int id;
  final String name;
  final String phone;
  final String subtitle;
  final int callCount;
  final Color color;
  final bool blocked;
  _TilePayload({
    required this.id,
    required this.name,
    required this.phone,
    required this.subtitle,
    required this.callCount,
    required this.color,
    required this.blocked,
  });
}

class _ComplexTile extends StatelessWidget {
  final _TilePayload p;
  final VoidCallback? onTap;
  const _ComplexTile({required this.p, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: p.color.withOpacity(p.blocked ? 0.18 : 0.07),
        borderRadius: BorderRadius.circular(14),
        elevation: 1.5,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: p.color.withOpacity(0.3),
                  child: Text(
                    p.name.substring(0, min(2, p.name.length)),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(p.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: p.blocked
                                  ? Colors.red.withOpacity(0.15)
                                  : Colors.green.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              p.blocked ? 'BLOCKED' : 'ALLOWED',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: p.blocked ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(p.phone,
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 13)),
                      const SizedBox(height: 4),
                      Text(p.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      p.blocked ? Icons.block : Icons.check_circle,
                      color: p.blocked ? Colors.red : Colors.green,
                      size: 20,
                    ),
                    const SizedBox(height: 8),
                    Text('${p.callCount}',
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: 12)),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.info_outline, size: 18),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RealisticHomeList extends ConsumerStatefulWidget {
  final List<_TilePayload> data;
  final bool useOpacityAntiPattern;
  final bool useBackdropFilter;
  final bool useListViewChildren;
  final NotifierProvider<CounterNotifier, int> counterProvider;
  const _RealisticHomeList({
    required this.data,
    required this.counterProvider,
    this.useOpacityAntiPattern = false,
    this.useBackdropFilter = false,
    this.useListViewChildren = false,
  });

  @override
  ConsumerState<_RealisticHomeList> createState() =>
      _RealisticHomeListState();
}

class _RealisticHomeListState extends ConsumerState<_RealisticHomeList> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(widget.counterProvider);
    Widget list;

    if (widget.useListViewChildren) {
      list = ListView(
        controller: _controller,
        cacheExtent: 0,
        children: widget.data
            .map((p) => _ComplexTile(
                  p: p,
                  onTap: () {
                    ref.read(widget.counterProvider.notifier).increment();
                  },
                ))
            .toList(),
      );
    } else {
      list = ListView.builder(
        controller: _controller,
        cacheExtent: 300,
        itemCount: widget.data.length,
        itemBuilder: (ctx, i) {
          final p = widget.data[i];
          return _ComplexTile(
            p: p,
            onTap: () {
              ref.read(widget.counterProvider.notifier).increment();
            },
          );
        },
      );
    }

    if (widget.useOpacityAntiPattern) {
      list = Opacity(opacity: 0.92, child: list);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulated Home Scroll'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(child: Text('Counter: $counter')),
          ),
        ],
      ),
      body: list,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(widget.counterProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void main() {
  group('掉帧 & 滚动卡顿 & 重建风暴 Jank 检测（真实 App 体感与跟手度）', () {
    final rand = Random(12345);
    final names = [
      'Alice Johnson',
      'Bob Smith',
      'Carol Davis',
      '大卫·李',
      'Élodie Martin',
      'Friedrich Müller',
      '高橋洋介',
      '김민수',
      'Иван Петров',
      'Raj Patel'
    ];
    const itemCount = 400;
    final data = List.generate(itemCount, (i) {
      final n = names[i % names.length];
      return _TilePayload(
        id: i,
        name: '$n #$i',
        phone: '+1${(2000000000 + rand.nextInt(800000000))}',
        subtitle:
            '最近通话 ${rand.nextInt(60)} 分钟前 · 标签 ${['Spam', 'VIP', 'Work', 'Family', 'Other'][rand.nextInt(5)]}',
        callCount: rand.nextInt(500),
        color: Colors.primaries[i % Colors.primaries.length],
        blocked: rand.nextBool(),
      );
    });

    Future<Map<String, double>> scrollAndMeasure(
      WidgetTester tester,
      String runName, {
      bool opacity = false,
      bool listViewChildren = false,
      required NotifierProvider<CounterNotifier, int> counter,
    }) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: _RealisticHomeList(
              data: data,
              counterProvider: counter,
              useOpacityAntiPattern: opacity,
              useListViewChildren: listViewChildren,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final frames = <double>[];
      const scrollSteps = 120;
      for (int i = 0; i < scrollSteps; i++) {
        final fw = Stopwatch()..start();
        await tester.drag(
            find.byType(ListView),
            Offset(0, opacity ? -110.0 : -130.0 - (i % 3) * 20.0));
        await tester.pump(const Duration(milliseconds: 16));
        fw.stop();
        frames.add(fw.elapsedMicroseconds / 1000.0);
      }

      for (int i = 0; i < scrollSteps; i++) {
        final fw = Stopwatch()..start();
        await tester.drag(
            find.byType(ListView), const Offset(0, 120));
        await tester.pump(const Duration(milliseconds: 16));
        fw.stop();
        frames.add(fw.elapsedMicroseconds / 1000.0);
      }

      frames.sort();
      final avg = frames.reduce((a, b) => a + b) / frames.length;
      final p50 = frames[(frames.length * 0.50).floor()];
      final p90 = frames[(frames.length * 0.90).floor()];
      final p95 = frames[(frames.length * 0.95).floor()];
      final p99 = frames[(frames.length * 0.99).floor()];
      final worst = frames.last;
      final jank16 = frames.where((t) => t > 16.6).length;
      final jank32 = frames.where((t) => t > 33.3).length;

      emit({
        'phase': 'scroll_jank',
        'run': runName,
        'metric': 'avg_frame_ms',
        'value': avg,
        'unit': 'ms',
        'samples': frames.length,
        'threshold_hard': 32.0,
        'threshold_warn': 20.0,
      });
      emit({
        'phase': 'scroll_jank',
        'run': runName,
        'metric': 'p95_frame_ms',
        'value': p95,
        'unit': 'ms',
        'threshold_hard': 50.0,
        'threshold_warn': 33.0,
      });
      emit({
        'phase': 'scroll_jank',
        'run': runName,
        'metric': 'jank_over_16ms_count',
        'value': jank16.toDouble(),
        'unit': 'count',
        'samples': frames.length,
        'pct': jank16 / frames.length * 100.0,
      });

      final tapLatency = <double>[];
      for (int t = 0; t < 30; t++) {
        final fw = Stopwatch()..start();
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
        fw.stop();
        tapLatency.add(fw.elapsedMicroseconds / 1000.0);
      }
      tapLatency.sort();
      final tapP95 = tapLatency[(tapLatency.length * 0.95).floor()];

      return {
        'avg': avg,
        'p50': p50,
        'p90': p90,
        'p95': p95,
        'p99': p99,
        'worst': worst,
        'jank16': jank16.toDouble(),
        'jank32': jank32.toDouble(),
        'tap_p95': tapP95,
      };
    }

    testWidgets('基准: ListView.builder 虚拟化 滚动跟手度测试', (tester) async {
      final r = await scrollAndMeasure(
        tester,
        'baseline_listview_builder',
        counter: counterProvider1,
      );
      final jankPct = r['jank16']! / 240 * 100;
      if (jankPct > 20 || r['p95']! > 50) {
        cause(
          'baseline-scroll-jank',
          r['p95']! > 80 ? 'HIGH' : 'MEDIUM',
          '虚拟化 ListView.builder 场景 P95 ${r['p95']!.toStringAsFixed(1)}ms 掉帧率 ${jankPct.toStringAsFixed(1)}%',
          '首页 ListView + 卡片复杂度',
          r['p95']!,
          '基础滑动场景出现掉帧与不够跟手，说明 Tile 构建本身开销较高。',
          '建议：(a) 拆分为 const Widget；(b) 缓存正则与 Format；(c) 图标/图片做内存预载。',
        );
      }
    });

    testWidgets('反模式 1: Opacity() 包裹整棵列表 → SaveLayer 掉帧与卡顿', (tester) async {
      final r1 = await scrollAndMeasure(
        tester,
        'with_opacity_wrapper',
        opacity: true,
        counter: counterProvider1,
      );
      addTearDown(tester.view.resetPhysicalSize);
      final r0 = await scrollAndMeasure(
        tester,
        'baseline_for_opacity_compare',
        counter: counterProvider2,
      );

      final slowdown = r1['p95']! / max(r0['p95']!, 0.01);
      emit({
        'phase': 'antipattern_delta',
        'antipattern': 'Opacity_wrapper_over_list',
        'metric': 'p95_slowdown_x',
        'value': slowdown,
      });

      if (slowdown > 1.5 || r1['jank16']! > r0['jank16']! * 1.3) {
        cause(
          'antipattern-opacity-savelayer',
          slowdown > 2.5 ? 'HIGH' : 'MEDIUM',
          'Opacity() 包裹列表导致 SaveLayer 掉帧，耗时变慢 ${slowdown.toStringAsFixed(2)}x',
          'UI Opacity 包裹大子树',
          r1['p95']! - r0['p95']!,
          'Opacity 强制 GPU 分配离屏缓冲区，滚动时严重拖慢跟手感。',
          '建议使用 Color.withValues 或 AnimatedOpacity。',
        );
      }
    });

    testWidgets('反模式 2: ListView(children:[]) 未虚拟化 → 巨型重建与首屏耗时', (tester) async {
      final rBad = await scrollAndMeasure(
        tester,
        'listview_children_antipattern',
        listViewChildren: true,
        counter: counterProvider1,
      );
      final rGood = await scrollAndMeasure(
        tester,
        'listview_builder_good',
        counter: counterProvider2,
      );

      final mountSlowdown = rBad['worst']! / max(rGood['worst']!, 0.01);
      if (mountSlowdown > 2.0 || rBad['tap_p95']! > rGood['tap_p95']! * 1.8) {
        cause(
          'antipattern-listview-children-all-render',
          mountSlowdown > 4 ? 'HIGH' : 'MEDIUM',
          'ListView(children:[]) 未虚拟化导致渲染性能下降 ${mountSlowdown.toStringAsFixed(2)}x',
          '全量子组件一次性构建',
          rBad['worst']!,
          '一次性构建全部列表项丧失视图回收机制，拖慢首屏并造成滑动与点击延迟。',
          '使用 ListView.builder 懒加载。',
        );
      }
    });

    testWidgets('Provider + 重建风暴：State 变动引发无差别子树重绘', (tester) async {
      final listData = data.sublist(0, 200);

      Widget buildList({bool useSelect = false}) {
        return ProviderScope(
          child: MaterialApp(
            home: Consumer(
              builder: (ctx, ref, _) {
                final globalVal = ref.watch(globalCounterProvider);
                return Scaffold(
                  appBar: AppBar(
                    title: Text(useSelect ? 'SELECT' : 'WATCH-ALL'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Global: $globalVal'),
                      )
                    ],
                  ),
                  body: ListView.builder(
                    cacheExtent: 500,
                    itemCount: listData.length,
                    itemBuilder: (c, i) {
                      return Consumer(
                        builder: (ctx2, ref2, _) {
                          final int v = useSelect
                              ? ref2.watch(globalCounterProvider.select((val) => val.isOdd ? 1 : 0))
                              : ref2.watch(globalCounterProvider);
                          return _ComplexTile(
                            p: listData[i].copyWith(callCount: listData[i].callCount + v),
                            onTap: () =>
                                ref2.read(globalCounterProvider.notifier).increment(),
                          );
                        },
                      );
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      ref.read(globalCounterProvider.notifier).increment();
                    },
                    child: const Icon(Icons.refresh),
                  ),
                );
              },
            ),
          ),
        );
      }

      Future<Map<String, double>> runCase(String name, bool useSelect) async {
        await tester.pumpWidget(buildList(useSelect: useSelect));
        await tester.pumpAndSettle();

        final perTapFrames = <double>[];
        const taps = 30;
        for (int t = 0; t < taps; t++) {
          final fw = Stopwatch()..start();
          final items = find.byType(_ComplexTile, skipOffstage: true);
          if (items.evaluate().isEmpty) break;
          await tester.tap(items.at(5 % items.evaluate().length));
          await tester.pump();
          fw.stop();
          perTapFrames.add(fw.elapsedMicroseconds / 1000.0);
        }
        perTapFrames.sort();
        final p95 = perTapFrames[(perTapFrames.length * 0.95).floor()];
        final avg = perTapFrames.reduce((a, b) => a + b) / perTapFrames.length;
        final worst = perTapFrames.last;
        final jank = perTapFrames.where((t) => t > 16.6).length;

        return {'p95': p95, 'avg': avg, 'worst': worst, 'jank': jank.toDouble()};
      }

      final rBad = await runCase('global_watch_all_tiles', false);
      final rGood = await runCase('select_odd_even_only', true);

      final slowdown = rBad['p95']! / max(rGood['p95']!, 0.01);
      if (slowdown > 1.8 || rBad['worst']! > 80) {
        cause(
          'rebuild-storm-watch-all',
          slowdown > 3.0 ? 'HIGH' : 'MEDIUM',
          'ref.watch(大Provider) 引发重建风暴：点击延迟变慢 ${slowdown.toStringAsFixed(2)}x',
          '大粒度 Provider 监听',
          rBad['p95']!,
          '整个 Widget 树无差别重建导致界面跟手度明显下降。',
          '使用 ref.watch(provider.select(...)) 缩小监听范围。',
        );
      }
    });
  });
}

extension on _TilePayload {
  _TilePayload copyWith({
    int? id,
    String? name,
    String? phone,
    String? subtitle,
    int? callCount,
    Color? color,
    bool? blocked,
  }) {
    return _TilePayload(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      subtitle: subtitle ?? this.subtitle,
      callCount: callCount ?? this.callCount,
      color: color ?? this.color,
      blocked: blocked ?? this.blocked,
    );
  }
}
