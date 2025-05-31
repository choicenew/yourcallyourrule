import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/registry_provider/provider_config.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: Container(), // 将在调用时替换为实际内容
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: Consumer<AppRouter>(
        builder: (context, appRouter, child) => MaterialApp.router(
            title: 'Your Call Your Rule',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              primaryColor: const Color(0xFFFF9800),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routerConfig: appRouter.router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          )
        
      ),
    );
  }
}