import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:plugindemo/core/router/app_router_provider.dart';
import 'package:plugindemo/features/plugin/services/plugin_execution_service.dart';
import 'package:plugindemo/generated/app_localizations.dart';

/// 全局 Overlay 模式标识 (插件测试 Demo 默认为 false)
bool isOverlayMode = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final container = ProviderContainer();

    await container.read(pluginExecutionServiceProvider).initialize();

    runApp(
      UncontrolledProviderScope(container: container, child: const MyApp()),
    );
  } catch (e, stackTrace) {
    debugPrint('初始化错误: $e');
    debugPrint('堆栈跟踪: $stackTrace');
    runApp(const MyApp());
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Plugin Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      routerConfig: appRouter.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
