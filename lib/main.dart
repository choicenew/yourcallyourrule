import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/router/app_router_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_sync_service_initializer.dart';
import 'package:yourcallyourrule/features/call/call_history/provider/call_event_listener_provider.dart';

import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_overlay_entry.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_control_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/location/services/provider/location_sync_service_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/services/firebase_service.dart';
import 'package:yourcallyourrule/common/error/logger.dart';
import 'package:yourcallyourrule/core/provider/providers/background_sync_service_provider.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/theme/app_theme.dart';
import 'package:yourcallyourrule/theme/theme_provider.dart';
import 'package:yourcallyourrule/features/plugin/providers/plugin_webview_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/plugin_sync_service_initializer.dart';

import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';
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
    
   
   
    
    // --- Add ---
    // 创建一个顶层ProviderContainer
    final container = ProviderContainer();
    
    // 初始化插件WebView服务
    await container.read(pluginWebViewServiceProvider).initialize();
    
    // 初始化核心来电监控服务
    debugPrint("Initializing Caller ID Monitor Service...");

    
  
   // 1. 只需 `await` Provider 的 `.future` 即可。
    //    这一步会自动执行 `CallerIdMonitorService` 的 `build` 方法，并等待其所有初始化逻辑完成。
    await container.read(callerIdMonitorServiceProvider.future);
  

   
   

    debugPrint("Caller ID Monitor Service initialized successfully.");
    
    // 初始化通话事件监听服务，确保它在应用启动时就开始工作
    await container.read(callEventListenerProvider.future);
    
      // 【重要】读取一次 locationSyncServiceProvider 来激活它
      // 我们不需要使用它的返回值，只是为了让它开始工作
    container.read(locationSyncServiceProvider);

       // 从而建立起 CallerIdService 和 LabelStreamSyncService 之间的连接。
    container.read(labelSyncServiceInitializerProvider);
    
    // 初始化插件同步服务
    container.read(pluginSyncServiceInitializerProvider);
    
    // 初始化通知服务
    container.read(notificationServiceProvider);
    // --- Add ---
 container.read(overlayControlHandlerProvider);
    // 后台同步服务将通过Provider系统初始化
    
    // 记录应用启动事件
    firebaseService.logAppOpen();

    runApp(UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ));
  } catch (e, stackTrace) {
    // 记录错误但不中断应用启动
    debugPrint('初始化错误: $e');
    debugPrint('堆栈跟踪: $stackTrace');
    
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
  isOverlayMode = false;



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
    








       // 2. Watch the new provider to get the current theme mode
    final themeMode = ref.watch(themeModeProvider);

    // 1. 监听 localeProvider 的状态
    // 直接 watch provider 并获取其 .value
    // .value 在有数据时返回 Locale，在加载或错误时返回 null
    // 这正是 MaterialApp 的 locale 属性所期望的 (Locale?)
    final locale = ref.watch(localeProvider).value;

    // 仅在非覆盖层模式下初始化后台同步服务
    // 后台同步服务已包含通话记录同步任务，不需要再单独初始化前台同步服务
    if (!isOverlayMode) {
      // 初始化后台同步服务
      ref.watch(backgroundSyncInitProvider);


    }
    
    return MaterialApp.router(
      title: 'Your Call Your Rule',
      /*
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFF9800),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      */

      // 2. 设置亮色主题
      theme: AppTheme.lightTheme,
      
      // 3. 设置暗色主题
      darkTheme: AppTheme.darkTheme,
      
      // 4. 设置主题模式为“跟随系统”，实现自适应
      // ThemeMode.system: 跟随操作系统设置（亮/暗）
      // ThemeMode.light: 始终使用亮色主题
      // ThemeMode.dark:  始终使用暗色主题
  //Set the themeMode from our provider!
      // This will now automatically rebuild the app with the new theme
      // whenever the user makes a change.
      themeMode: themeMode,


      routerConfig: appRouter.router,


          // 直接将获取到的 locale 或 null 赋值
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}