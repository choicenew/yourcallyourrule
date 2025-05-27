import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/registry_provider/provider_config.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
          )
        
      ),
    );
  }
}