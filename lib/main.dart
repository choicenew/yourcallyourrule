import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'features/home/pages/home_page.dart';
import 'features/home/providers/home_stats_provider.dart';
import 'features/language/provider/language_provider.dart';
import 'features/language/services/locale_service.dart';
import 'features/call/call_history/services/call_log_service.dart';
import 'features/rules/services/blacklist_whitelist_service.dart';
import 'data/repositories/call/config_repository.dart';
import 'data/repositories/call_log_repository_impl.dart';
import 'data/database/database_service.dart';
import 'core/provider/basic_provider/rule_repository_provider.dart';
import 'features/language/config/locale_config.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 创建所需的仓库实例
    final configRepository = SharedPreferencesConfigRepository();
    final databaseService = DatabaseService();
    final callLogRepository = CallLogRepositoryImpl(databaseService);
    
    // 创建服务实例
    final callLogService = CallLogService(callLogRepository);
    final blacklistWhitelistService = BlacklistWhitelistService(RuleRepositoryImpl(databaseService));
    final localeService = LocaleService(configRepository);
    
    return MultiProvider(
      providers: [
        // 提供正确的依赖参数
        ChangeNotifierProvider(create: (_) => HomeStatsProvider(callLogService, blacklistWhitelistService)),
        ChangeNotifierProvider(create: (_) => LocaleProvider(localeService)),
      
        // 这里可以添加其他Provider
      ],
      child: MaterialApp.router(
        title: 'Your Call Your Rule',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: const Color(0xFFFF9800),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: _router,
      ),
    );
  }
}

// 路由配置
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    // 其他路由可以在这里添加
  ],
);