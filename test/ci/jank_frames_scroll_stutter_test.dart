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

class _JankCounterNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
  void setVal(int v) => state = v;
}

/// 模拟真实首页: ListView + 重建 + 图片/透明度等贵操作
class _RealisticHomeList extends ConsumerStatefulWidget {
  final List<_TilePayload> data;
  final bool useOpacityAntiPattern;
  final bool useBackdropFilter;
  final bool useListViewChildren;
  final NotifierProvider<_JankCounterNotifier, int> counterProvider;
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
      // 坏味道：一次性实例化全部
      list = ListView(
        controller: _controller,
        cacheExtent: 0,
        children: widget.data
            .map((p) => _ComplexTile(
                  p: p,
                  onTap: () {
                    ref
                        .read(widget.counterProvider.notifier)
                        .increment();
                  },
                ))
            .toList(),
      );
    } else {
      // 好：懒加载 builder
      list = ListView.builder(
        controller: _controller,
        cacheExtent: 300,
        itemCount: widget.data.length,
        itemBuilder: (ctx, i) {
          final p = widget.data[i];
          return _ComplexTile(
            p: p,
            onTap: () {
              ref
                  .read(widget.counterProvider.notifier)
                  .increment();
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
  group('掉帧 & 滚动卡顿 & 重建风暴 Jank 检测（真实 App 体感）', () {
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
      required NotifierProvider<_JankCounterNotifier, int> counter,
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

      // 反向滚回
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
        'metric': 'p99_frame_ms',
        'value': p99,
        'unit': 'ms',
      });
      emit({
        'phase': 'scroll_jank',
        'run': runName,
        'metric': 'worst_frame_ms',
        'value': worst,
        'unit': 'ms',
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
      emit({
        'phase': 'scroll_jank',
        'run': runName,
        'metric': 'jank_over_32ms_count',
        'value': jank32.toDouble(),
        'unit': 'count',
      });

      // 点击一下按钮，测 rebuild 延迟
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
      emit({
        'phase': 'scroll_jank',
        'run': runName,
        'metric': 'tap_settle_p95_ms',
        'value': tapP95,
        'unit': 'ms',
        'threshold_hard': 80.0,
        'threshold_warn': 40.0,
      });

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

    testWidgets('基准（好）: ListView.builder 虚拟化 滚动掉帧基准',
        (tester) async {
      final counter =
          NotifierProvider<_JankCounterNotifier, int>(_JankCounterNotifier.new);
      final r = await scrollAndMeasure(
        tester,
        'baseline_listview_builder',
        counter: counter,
      );
      final jankPct = r['jank16']! / 240 * 100;
      if (jankPct > 20 || r['p95']! > 50) {
        cause(
          'baseline-scroll-jank',
          r['p95']! > 80 ? 'HIGH' : 'MEDIUM',
          '虚拟化 ListView.builder 基准场景已出现 P95 ${r['p95']!.toStringAsFixed(1)}ms 掉帧 ${jankPct.toStringAsFixed(1)}%',
          '首页 ListView + item 复杂度 (头像/卡片/多 Icon)',
          r['p95']!,
          '基础场景也有掉帧，说明 tile build 本身过于复杂。真实 EliteHomePage 往往还叠加广告、图片解码，掉帧会更严重。',
          '(a) 复杂 tile 拆成独立 StatelessWidget 加 const；(b) Text 样式缓存；(c) leading CircleAvatar 用 precacheImage；(d) 重对象(RegExp/DateFormat)提成 static final。',
        );
      }
    });

    testWidgets('反模式 1: Opacity() 包裹整棵列表 → SaveLayer 掉帧',
        (tester) async {
      final counter =
          NotifierProvider<_JankCounterNotifier, int>(_JankCounterNotifier.new);
      final r1 = await scrollAndMeasure(
        tester,
        'with_opacity_wrapper',
        opacity: true,
        counter: counter,
      );
      // 单独再跑一次基准 (无 Opacity) 做对比
      addTearDown(tester.view.resetPhysicalSize);
      // 使用单独 Provider 避免状态污染
      final counter2 =
          NotifierProvider<_JankCounterNotifier, int>(_JankCounterNotifier.new);
      final r0 = await scrollAndMeasure(
        tester,
        'baseline_for_opacity_compare',
        counter: counter2,
      );

      final slowdown = r1['p95']! / max(r0['p95']!, 0.01);
      emit({
        'phase': 'antipattern_delta',
        'antipattern': 'Opacity_wrapper_over_list',
        'metric': 'p95_slowdown_x',
        'value': slowdown,
        'unit': 'x',
        'baseline_p95_ms': r0['p95'],
        'with_p95_ms': r1['p95'],
      });

      if (slowdown > 1.5 || r1['jank16']! > r0['jank16']! * 1.3) {
        cause(
          'antipattern-opacity-savelayer',
          slowdown > 2.5 ? 'HIGH' : 'MEDIUM',
          'Opacity() 包裹整个列表造成 P95 ${slowdown.toStringAsFixed(2)}x 变慢 (${r0['p95']!.toStringAsFixed(1)} → ${r1['p95']!.toStringAsFixed(1)} ms)',
          'home 页面: 任何使用 Opacity( child: ListView / 大子树 ) 的代码',
          r1['p95']! - r0['p95']!,
          'Opacity 会对整个子树强制 GPU SaveLayer → 分配离屏缓冲区 → 每帧开销翻倍以上。表现为"滚动一下一顿一顿"。',
          '(a) 改 AnimatedOpacity 并设 alwaysIncludeSemantics；(b) 单元素透明度用 Color.withOpacity()；(c) 确需整张子树透明时，用 ShaderMask 或 RepaintBoundary 隔离。',
        );
      }
    });

    testWidgets('反模式 2: ListView(children:[]) 一次性实例化 → 大列表首帧 & 内存爆',
        (tester) async {
      final counter =
          NotifierProvider<_JankCounterNotifier, int>(_JankCounterNotifier.new);
      final rBad = await scrollAndMeasure(
        tester,
        'listview_children_antipattern',
        listViewChildren: true,
        counter: counter,
      );
      final counter2 =
          NotifierProvider<_JankCounterNotifier, int>(_JankCounterNotifier.new);
      final rGood = await scrollAndMeasure(
        tester,
        'listview_builder_good',
        counter: counter2,
      );

      final mountSlowdown = rBad['worst']! / max(rGood['worst']!, 0.01);
      emit({
        'phase': 'antipattern_delta',
        'antipattern': 'ListView_children_non_virtualized',
        'metric': 'worst_slowdown_x',
        'value': mountSlowdown,
        'unit': 'x',
        'bad_worst_ms': rBad['worst'],
        'good_worst_ms': rGood['worst'],
        'baseline_avg_ms': rGood['avg'],
        'bad_avg_ms': rBad['avg'],
      });
      if (mountSlowdown > 2.0 || rBad['tap_p95']! > rGood['tap_p95']! * 1.8) {
        cause(
          'antipattern-listview-children-all-render',
          mountSlowdown > 4 ? 'HIGH' : 'MEDIUM',
          'ListView(children:[]) 非虚拟化：首帧+最差帧 ${mountSlowdown.toStringAsFixed(2)}x 变慢',
          '通话历史 / 规则列表 / 标签列表: ListView 默认构造 children: [...all]',
          rBad['worst']!,
          '一次性实例化全部 item → 首帧 CPU 飙升 → 低端机型打开列表页直接卡几秒，且内存暴涨 (OOM 风险)。同时 setState 触发全量重建 → 掉帧"一顿一顿"。',
          '(a) 改为 ListView.builder / SliverList 懒加载；(b) 大图片加 MemCache 高度和缩略图；(c) itemExtent/prototypeItem 降低布局计算。',
        );
      }
    });

    testWidgets('Provider + 重建风暴：点击一次 FAB → 所有 item 重建 → 掉帧',
        (tester) async {
      // 全局 NotifierProvider，所有 tile 通过 ref.watch 监听整个 state（坏味道）
      final global =
          NotifierProvider<_JankCounterNotifier, int>(_JankCounterNotifier.new);
      final data = this.data.sublist(0, 200);

      Widget buildList({bool useSelect = false}) {
        return ProviderScope(
          overrides: [global.overrideWith(_JankCounterNotifier.new)],
          child: MaterialApp(
            home: Consumer(
              builder: (ctx, ref, _) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(useSelect ? 'SELECT' : 'WATCH-ALL'),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Global: ${ref.watch(global)}'),
                      )
                    ],
                  ),
                  body: ListView.builder(
                    cacheExtent: 500,
                    itemCount: data.length,
                    itemBuilder: (c, i) {
                      return Consumer(
                        builder: (ctx2, ref2, _) {
                          // 关键: useSelect 只看奇偶，整页不会全部重建
                          final int v = useSelect
                              ? ref2.watch(
                                  global.select((v) => v.isOdd ? 1 : 0))
                              : ref2.watch(global);
                          return _ComplexTile(
                            p: data[i].copyWith(callCount: data[i].callCount + v),
                            onTap: () =>
                                ref2.read(global.notifier).increment(),
                          );
                        },
                      );
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () =>
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                      // No-op, just used to ensure pump is run
                    }),
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
        const taps = 40;
        for (int t = 0; t < taps; t++) {
          final fw = Stopwatch()..start();
          // tap a visible tile (middle item)
          final items = find.byType(_ComplexTile, skipOffstage: true);
          if (items.evaluate().isEmpty) break;
          await tester.tap(items.at(5 % items.evaluate().length));
          await tester.pump();
          fw.stop();
          perTapFrames.add(fw.elapsedMicroseconds / 1000.0);
        }
        perTapFrames.sort();
        final p95 = perTapFrames[(perTapFrames.length * 0.95).floor()];
        final p99 = perTapFrames[(perTapFrames.length * 0.99).floor()];
        final avg = perTapFrames.reduce((a, b) => a + b) / perTapFrames.length;
        final worst = perTapFrames.last;
        final jank = perTapFrames.where((t) => t > 16.6).length;
        emit({
          'phase': 'rebuild_storm_tap',
          'run': name,
          'metric': 'tap_rebuild_p95_ms',
          'value': p95,
          'unit': 'ms',
          'samples': perTapFrames.length,
        });
        emit({
          'phase': 'rebuild_storm_tap',
          'run': name,
          'metric': 'tap_rebuild_avg_ms',
          'value': avg,
          'unit': 'ms',
          'jank_over_16ms': jank,
          'p99_ms': p99,
          'worst_ms': worst,
        });
        return {'p95': p95, 'avg': avg, 'worst': worst, 'jank': jank.toDouble()};
      }

      final rBad = await runCase('global_watch_all_tiles', false);
      final rGood = await runCase('select_odd_even_only', true);

      final slowdown = rBad['p95']! / max(rGood['p95']!, 0.01);
      emit({
        'phase': 'antipattern_delta',
        'antipattern': 'ref_watch_whole_provider_in_tile',
        'metric': 'tap_rebuild_slowdown_x',
        'value': slowdown,
        'unit': 'x',
        'watch_all_p95': rBad['p95'],
        'select_p95': rGood['p95'],
        'watch_all_jank': rBad['jank'],
        'select_jank': rGood['jank'],
      });

      if (slowdown > 2.0 || rBad['worst']! > 80) {
        cause(
          'rebuild-storm-watch-all',
          slowdown > 3.5 || rBad['worst']! > 200 ? 'HIGH' : 'MEDIUM',
          '整页 ref.watch(大Provider) 引发重建风暴：点击响应 P95 ${slowdown.toStringAsFixed(2)}x 变慢 (${rGood['p95']!.toStringAsFixed(1)} → ${rBad['p95']!.toStringAsFixed(1)} ms)',
          'home_elite / call_history / settings 页面里对整棵 Widget 树 ref.watch(callLogsProvider) / rulesProvider',
          rBad['p95']!,
          '每次 state 变化 → 所有 tile Consumer 触发 build → Element 树深层 diff → 掉帧，点击/切换 Tab 明显"不跟手"。',
          '(a) 用 ref.watch(provider.select((s) => s.field)) 字段级订阅；(b) tile 拆成 Consumer 仅包裹依赖字段的子 Widget；(c) 用 NotifierProvider 拆细粒度 store，不再 watch 整个大列表。',
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
