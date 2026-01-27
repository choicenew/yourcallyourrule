import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:plugindemo/core/router/app_router_provider.dart';
import 'package:plugindemo/data/database/database_service.dart';
import 'package:plugindemo/features/plugin/providers/plugin_execution_service_provider.dart';
import 'package:plugindemo/generated/app_localizations.dart';

Future<void> main() async {
  // 确保 Flutter 绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 初始化数据库服务
    DatabaseService();

    // 创建一个顶层ProviderContainer
    final container = ProviderContainer();

    // 初始化插件WebView服务
    await container.read(pluginExecutionServiceProvider).initialize();

    runApp(
      UncontrolledProviderScope(container: container, child: const MyApp()),
    );
  } catch (e, stackTrace) {
    // 记录错误但不中断应用启动
    debugPrint('初始化错误: $e');
    debugPrint('堆栈跟踪: $stackTrace');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Plugin Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
