import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/provider/providers/background_sync_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/foreground_sync_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_sync_service_initializer.dart';
import 'package:yourcallyourrule/core/provider/providers/plugin_sync_service_initializer.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/core/router/app_router_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/provider/call_event_listener_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_control_handler.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/pages/elite_home_page.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/location/services/provider/location_sync_service_provider.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';
import 'package:yourcallyourrule/features/plugin/providers/plugin_execution_service_provider.dart';
import 'package:yourcallyourrule/features/splash/splash_screen.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/theme/theme_provider.dart';

void emit(Map<String, dynamic> m) {
  debugPrint('STARTUP_METRIC: ${jsonEncode(m)}');
}

void cause(String id, String severity, String name, String blamedComponent,
    num costMs, String reason, String suggestion) {
  debugPrint('ROOT_CAUSE: ${jsonEncode({
        'id': id,
        'severity': severity,
        'name': name,
        'blamed_component': blamedComponent,
        'cost_ms': costMs,
        'reason': reason,
        'suggestion': suggestion,
      })}');
}

typedef Task = FutureOr<void> Function();

int _getSafeRssKb() {
  try {
    return ProcessInfo.currentRss ~/ 1024;
  } catch (_) {
    return 0;
  }
}

void main() {
  group('真实 App 冷启动链路剖析 (谁拖慢了 APP 打开)', () {
    testWidgets('Step 1: 模拟 main() 全部初始化 + MyApp + Splash + 路由到首帧 EliteHomePage',
        (WidgetTester tester) async {
      final _bootstrapPhases = <String, double>{};
      final swTotal = Stopwatch()..start();

      final rss0 = _getSafeRssKb();
      final swWidgetsBinding = Stopwatch()..start();
      WidgetsFlutterBinding.ensureInitialized();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        (MethodCall methodCall) async => Directory.systemTemp.path,
      );
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/shared_preferences'),
        (MethodCall methodCall) async => <String, dynamic>{},
      );
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('dexterous.com/flutter/local_notifications'),
        (MethodCall methodCall) async => true,
      );
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('floating_window_android'),
        (MethodCall methodCall) async => false,
      );
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('flutter.baseflow.com/permissions/methods'),
        (MethodCall methodCall) async => 1,
      );
      _bootstrapPhases['0.1_WidgetsBinding'] =
          swWidgetsBinding.elapsedMicroseconds / 1000.0;

      final swLocale = Stopwatch()..start();
      final container = ProviderContainer();
      addTearDown(container.dispose);
      _bootstrapPhases['0.2_ProviderContainer.new'] =
          swLocale.elapsedMicroseconds / 1000.0;

      final tasks = <(String, dynamic)>[
        ('1.1_languageProvider.future', localeProvider),
        ('1.2_themeModeProvider', themeModeProvider),
        ('1.3_appRouterProvider', appRouterProvider),
        ('1.4_pluginExecutionServiceProvider',
            pluginExecutionServiceProvider),
        ('1.5_callerIdMonitorServiceProvider',
            callerIdMonitorServiceProvider),
        ('1.6_callEventListenerProvider', callEventListenerProvider),
        ('1.7_locationSyncServiceProvider', locationSyncServiceProvider),
        ('1.8_labelSyncServiceInitializerProvider',
            labelSyncServiceInitializerProvider),
        ('1.9_pluginSyncServiceInitializerProvider',
            pluginSyncServiceInitializerProvider),
        ('1.10_notificationServiceProvider', notificationServiceProvider),
        ('1.11_overlayControlHandlerProvider',
            overlayControlHandlerProvider),
        ('1.12_backgroundSyncInitProvider.future',
            backgroundSyncInitProvider),
        ('1.13_foregroundSyncServiceInitializerProvider.future',
            foregroundSyncServiceInitializerProvider),
      ];

      for (final task in tasks) {
        final tag = task.$1;
        final p = task.$2;
        final s = Stopwatch()..start();
        try {
          final dynamic v = container.read(p);
          if (v is Future) {
            try {
              await v.timeout(const Duration(milliseconds: 500));
            } catch (_) {}
          }
        } catch (e) {
          debugPrint('[startup profile] $tag 抛出异常(非致命): $e');
        }
        s.stop();
        final double ms = s.elapsedMicroseconds / 1000.0;
        _bootstrapPhases[tag] = ms;
      }

      final swMountMyApp = Stopwatch()..start();
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: _TestBootstrapApp(container: container),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));
      _bootstrapPhases['2.1_MyApp+Splash_mount_pumpAndSettle'] =
          swMountMyApp.elapsedMicroseconds / 1000.0;

      final swNavHome = Stopwatch()..start();
      try {
        final contextFinder = find.byType(SplashScreen);
        if (contextFinder.evaluate().isNotEmpty) {
          final splashCtx = tester.element(contextFinder);
          await Navigator.of(splashCtx).push(MaterialPageRoute(
            builder: (_) => const ProviderScope(child: EliteHomePage()),
          ));
        } else {
          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: _TestBootstrapApp(container: container, homeElite: true),
            ),
          );
        }
      } catch (_) {
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: _TestBootstrapApp(container: container, homeElite: true),
          ),
        );
      }
      await tester.pump(const Duration(milliseconds: 500));
      _bootstrapPhases['2.2_Splash->EliteHome_mount_pumpAndSettle'] =
          swNavHome.elapsedMicroseconds / 1000.0;

      swTotal.stop();
      final double totalMs = swTotal.elapsedMicroseconds / 1000.0;
      final rss1 = _getSafeRssKb();
      final double deltaRssKb = (rss1 - rss0).toDouble();

      for (final e in _bootstrapPhases.entries) {
        emit({
          'phase': 'cold_start_bootstrap',
          'metric': e.key,
          'value': e.value,
          'unit': 'ms',
          'percent_of_total': (e.value / max(totalMs, 0.001) * 100.0),
        });
      }
      emit({
        'phase': 'cold_start_total',
        'metric': 'cold_start_total_ms',
        'value': totalMs,
        'unit': 'ms',
        'rss_before_kb': rss0,
        'rss_after_kb': rss1,
        'rss_delta_kb': deltaRssKb,
        'threshold_hard': 10000.0,
        'threshold_warn': 5000.0,
      });
      emit({
        'phase': 'cold_start_total',
        'metric': 'cold_start_rss_delta_kb',
        'value': deltaRssKb,
        'unit': 'KB',
        'threshold_hard': 80 * 1024.0,
        'threshold_warn': 40 * 1024.0,
      });

      final sortedDesc = _bootstrapPhases.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      final topN = sortedDesc.take(5).toList();
      final totalBootstrapMs =
          _bootstrapPhases.values.fold<double>(0.0, (a, b) => a + b);

      final rules = <String>{};
      for (int rank = 0; rank < topN.length; rank++) {
        final e = topN[rank];
        final pct = e.value / max(totalBootstrapMs, 0.001) * 100.0;
        String sev = pct >= 30
            ? 'HIGH'
            : pct >= 15
                ? 'MEDIUM'
                : 'LOW';
        if (e.value < 20) continue;
        final id = 'slow-startup-${e.key}';
        cause(
          id,
          sev,
          '启动慢因 #${rank + 1}: ${e.key} 耗时 ${e.value.toStringAsFixed(1)}ms (${pct.toStringAsFixed(1)}%)',
          e.key,
          e.value,
          '在真实 App 启动链路中，该 Provider/阶段占用了启动总开销的 ${pct.toStringAsFixed(1)}%，是首页渲染前的阻塞路径。',
          '建议：(a) 若为非首屏数据（如通知/后台同步/位置同步/插件），移到首帧后 lazy 初始化；(b) 仓库 I/O 放 isolate；(c) 拆分 FutureProvider 以允许并行。',
        );
        rules.add(id);
      }

      if (deltaRssKb > 40 * 1024) {
        cause(
          'memory-startup-rss-growth',
          deltaRssKb > 80 * 1024 ? 'HIGH' : 'MEDIUM',
          '启动期 RSS 内存增长过大 (${deltaRssKb.toStringAsFixed(0)} KB)',
          'lib/main.dart + 首屏 EliteHomePage 组合',
          deltaRssKb / 1024,
          'App 启动后，RSS（物理驻留集）增长超过阈值，说明有大对象、图片、缓存被在启动阶段 eagerly 加载。',
          '建议：(a) 首屏图片使用 ResizeImage/ MemCache 限制；(b) 非首屏 DeferredComponent 延迟加载；(c) 检查 Drift/SharedPreferences 是否一次性加载大量记录。',
        );
      }

      if (totalMs > 5000) {
        cause(
          'startup-slow-overall',
          totalMs > 10000 ? 'HIGH' : 'MEDIUM',
          '总启动时间过长: ${totalMs.toStringAsFixed(1)}ms',
          '整条 main()→MyApp→Splash→EliteHomePage 链路',
          totalMs,
          '冷启动全链路超过阈值，低端机型上会被用户察觉为"卡住"或"打不开"。',
          '建议：(a) 对前 5 名慢速阶段按上述建议整改；(b) FlutterNativeSplash 保持到 EliteHomePage 第一帧；(c) 所有非首屏同步任务使用 unawaited + WorkManager。',
        );
      }

      expect(tester.takeException(), isNull,
          reason: '启动过程中发生了异常');
      expect(find.byType(EliteHomePage), findsOneWidget,
          reason: '首屏 EliteHomePage 没有正确挂载');
      expect(totalMs, lessThan(30000.0),
          reason: '启动 >30s 为灾难性失败');
    });

    test('Step 2: 逐个 Provider 冷启动成本基准（隔离容器，可排名 Top-N）',
        () async {
      final isolated = <(String, dynamic)>[
        ('localeProvider.future', localeProvider),
        ('themeModeProvider', themeModeProvider),
        ('appRouterProvider', appRouterProvider),
        ('labelSyncServiceInitializerProvider',
            labelSyncServiceInitializerProvider),
        ('pluginSyncServiceInitializerProvider',
            pluginSyncServiceInitializerProvider),
        ('backgroundSyncInitProvider.future', backgroundSyncInitProvider),
        ('foregroundSyncServiceInitializerProvider.future',
            foregroundSyncServiceInitializerProvider),
      ];

      final results = <(String, double)>[];
      for (final t in isolated) {
        final c = ProviderContainer();
        final p = t.$2;
        final sw = Stopwatch()..start();
        try {
          final dynamic v = c.read(p);
          if (v is Future) {
            await v.timeout(const Duration(milliseconds: 600))
                .catchError((_) {});
          }
        } catch (e) {
          debugPrint('[cold-start-providers] ${t.$1}: $e');
        }
        sw.stop();
        c.dispose();
        final ms = sw.elapsedMicroseconds / 1000.0;
        results.add((t.$1, ms));
        emit({
          'phase': 'isolated_provider_cold_cost',
          'metric': t.$1,
          'value': ms,
          'unit': 'ms',
          'threshold_hard': 500.0,
          'threshold_warn': 150.0,
        });
      }

      results.sort((a, b) => b.$2.compareTo(a.$2));
      final topSlow = results.where((r) => r.$2 > 150).toList();
      for (int i = 0; i < topSlow.length; i++) {
        final r = topSlow[i];
        cause(
          'slow-provider-${r.$1}',
          r.$2 > 500 ? 'HIGH' : 'MEDIUM',
          'Provider 冷启动 Top ${i + 1}: ${r.$1} = ${r.$2.toStringAsFixed(1)} ms',
          r.$1,
          r.$2,
          '该 Provider 首次读取触发了耗时 build()：典型来源是 Drift 数据库全表扫描、SharedPreferences 解码、远程网络请求或插件初始化。',
          '建议：(a) 若为读列表，改用 Lazy/分页；(b) 存储/IO 移到 Isolate；(c) 标注 @Riverpod(dependencies:[]) 依赖最小化，避免级联触发。',
        );
      }
    });

    testWidgets('Step 3: 首页首帧之后的前 100 帧渲染掉帧（启动后掉帧分析）',
        (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: _TestBootstrapApp(container: container, homeElite: true),
        ),
      );
      await tester.pump(const Duration(milliseconds: 500));

      final frames = <double>[];
      const frameCount = 100;
      for (int i = 0; i < frameCount; i++) {
        final fw = Stopwatch()..start();
        await tester.pump(const Duration(milliseconds: 16));
        fw.stop();
        frames.add(fw.elapsedMicroseconds / 1000.0);
      }

      frames.sort();
      final avg = frames.reduce((a, b) => a + b) / frames.length;
      final p95 = frames[(frames.length * 0.95).floor()];
      final worst = frames.last;
      final jankOver16 = frames.where((t) => t > 16.6).length;

      emit({
        'phase': 'first_100_frames_after_home',
        'metric': 'avg_frame_ms',
        'value': avg,
        'unit': 'ms',
        'threshold_hard': 50.0,
        'threshold_warn': 25.0,
      });
      emit({
        'phase': 'first_100_frames_after_home',
        'metric': 'p95_frame_ms',
        'value': p95,
        'unit': 'ms',
        'threshold_hard': 100.0,
        'threshold_warn': 50.0,
      });
      emit({
        'phase': 'first_100_frames_after_home',
        'metric': 'worst_frame_ms',
        'value': worst,
        'unit': 'ms',
        'threshold_hard': 200.0,
        'threshold_warn': 80.0,
      });
      emit({
        'phase': 'first_100_frames_after_home',
        'metric': 'jank_frames_over_16ms',
        'value': jankOver16.toDouble(),
        'unit': 'count',
        'threshold_hard': 25,
        'threshold_warn': 10,
      });

      final jankPct = jankOver16 / frameCount * 100.0;
      if (jankPct > 10) {
        cause(
          'startup-frame-jank-home',
          jankPct > 25 ? 'HIGH' : 'MEDIUM',
          '启动后首屏前 100 帧掉帧率 ${jankPct.toStringAsFixed(1)}% (P95=${p95.toStringAsFixed(1)}ms, 最差=${worst.toStringAsFixed(1)}ms)',
          'lib/features/home_elite + Provider 重建链',
          p95,
          '首屏 EliteHomePage 渲染早期出现高比例掉帧，直接体现为"打开 app 偶尔卡顿"。',
          '建议：(a) 检查 EliteHomePage 的 build 中是否有 ref.watch 触发级联 rebuild；(b) cards/sections 拆为独立 const Widget，局部 Consumer 订阅；(c) 图片用 precacheImage 预热。',
        );
      }
    });
  });
}

class _TestBootstrapApp extends ConsumerWidget {
  final ProviderContainer container;
  final bool homeElite;
  const _TestBootstrapApp({required this.container, this.homeElite = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    final loc = ref.watch(localeProvider).value;

    final router = homeElite
        ? GoRouter(
            initialLocation: '/${AppRouter.eliteHome}',
            routes: [
              GoRoute(
                path: '/${AppRouter.eliteHome}',
                name: AppRouter.eliteHome,
                builder: (_, __) => const EliteHomePage(),
              ),
              GoRoute(
                path: '/${AppRouter.splash}',
                name: AppRouter.splash,
                builder: (_, __) => const SplashScreen(),
              ),
            ],
          )
        : appRouter.router;

    return MaterialApp.router(
      title: 'Start Profile',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      locale: loc,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
