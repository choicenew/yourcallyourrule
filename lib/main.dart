import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/app_router_provider_riverpod.dart';

import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_overlay_entry.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/services/firebase_service.dart';
import 'package:yourcallyourrule/common/error/logger.dart';
import 'package:yourcallyourrule/core/provider/providers/background_sync_service_provider.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
 // 导入 FFI 包

Future<void> main() async {
  // 确保 Flutter 绑定初始化
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 保持原生启动屏幕直到 Flutter 渲染第一帧
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    // 初始化Firebase服务
    final firebaseService = FirebaseService();
    await firebaseService.initialize();
    
    // 初始化应用日志服务
    AppLogger.initialize();
    
    // 初始化广告SDK
    await MobileAds.instance.initialize();

    // 初始化数据库服务
    await DatabaseService().initialize();
    
    // 后台同步服务将通过Provider系统初始化
    
    // 记录应用启动事件
    firebaseService.logAppOpen();

    runApp(const ProviderScope(
      child: MyApp(),
    ));
  } catch (e, stackTrace) {
    // 记录错误但不中断应用启动
    print('初始化错误: $e');
    print('堆栈跟踪: $stackTrace');
    
    // 尝试记录错误到Firebase Crashlytics
    try {
      FirebaseService().recordError(e, stackTrace);
    } catch (_) {
      // 如果Crashlytics也无法初始化，则忽略错误
    }
  } finally {
    // 无论初始化是否成功，都确保移除原生启动屏幕
    // 这样可以防止应用卡在启动屏幕
    FlutterNativeSplash.remove();
  }
}

// 全局变量，标记当前是否处于覆盖层模式（只读模式）
bool isOverlayMode = false;

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置为覆盖层模式（只读模式）
  isOverlayMode = true;



  runApp(const ProviderScope(
    child: MaterialApp(
      title: 'Caller ID Overlay',
      home: CallerIdOverlayEntry(), // 展示overlay内容
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    
    // 仅在非覆盖层模式下初始化后台同步服务
    // 后台同步服务已包含通话记录同步任务，不需要再单独初始化前台同步服务
    if (!isOverlayMode) {
      // 初始化后台同步服务
      ref.watch(backgroundSyncInitProvider);


    }
    
    return MaterialApp.router(
      title: 'Your Call Your Rule',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF9800),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: appRouter.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}