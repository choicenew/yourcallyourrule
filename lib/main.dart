import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yourcallyourrule/core/registry_provider/provider_config.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_overlay_entry.dart';
import 'package:yourcallyourrule/features/splash/splash_screen.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/services/firebase_service.dart';
import 'package:yourcallyourrule/common/error/logger.dart';

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
    
    // 获取服务提供者列表
    final serviceProviders = getServiceProviders();
    final appProviders = getAppProviders();

    // 初始化广告SDK
    await MobileAds.instance.initialize();
    
    // 记录应用启动事件
    firebaseService.logAppOpen();

    runApp(MultiProvider(
      providers: [
        ...appProviders,
        ...serviceProviders,
      ],
      child: const MyApp(),
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

  // 获取服务提供者列表
  final serviceProviders = getServiceProviders();
  final appProviders = getAppProviders();

  runApp(MultiProvider(
    providers: [
      ...appProviders,
      ...serviceProviders,
    ],
    child: MaterialApp(
      title: 'Caller ID Overlay',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF9800),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CallerIdOverlayEntry(), // 展示overlay内容
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // 原生启动屏幕已在main函数的finally块中移除
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Your Call Your Rule',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF9800),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: Provider.of<AppRouter>(context, listen: false).router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
