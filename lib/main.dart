import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/registry_provider/provider_config.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_overlay_entry.dart';
import 'package:yourcallyourrule/features/splash/splash_screen.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 保持原生启动屏幕直到 Flutter 渲染第一帧
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  
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
    // 注意：不在这里移除原生启动屏幕，而是在SplashScreen中控制移除时机
    // FlutterNativeSplash.remove() 将在SplashScreen中调用
  }

  @override
  Widget build(BuildContext context) {
    // 获取服务提供者列表
    final serviceProviders = getServiceProviders();
    final appProviders = getAppProviders();
    
    return MultiProvider(
      providers: [
        ...appProviders,
        ...serviceProviders,
      ],
      child: MaterialApp.router(
        title: 'Your Call Your Rule',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: const Color(0xFFFF9800),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: Provider.of<AppRouter>(context, listen: false).router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}