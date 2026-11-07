import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/common/error/logger.dart';
import 'package:yourcallyourrule/core/services/background_sync_service.dart';
import 'package:yourcallyourrule/core/services/foreground_sync_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_stream_sync_service.dart';
import 'package:yourcallyourrule/features/caller_identity/services/plugin_to_remote_sync_service.dart';
import 'package:yourcallyourrule/features/location/services/location_sync_service.dart';
import 'package:yourcallyourrule/core/router/app_router_provider.dart';
import 'package:yourcallyourrule/core/services/firebase_service.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/features/call/call_history/provider/call_event_listener_provider.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/call_overlay_entry.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/overlay_control_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/services/caller_id_monitor_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';
import 'package:yourcallyourrule/features/widgets/services/app_widget_sync_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/theme/app_theme.dart';
import 'package:yourcallyourrule/theme/theme_provider.dart';

// === All 33 Package Suite Connectors ===
import 'package:pyro_telephony_connector/pyro_telephony_connector.dart';
import 'package:pyro_call_redirection_connector/pyro_call_redirection_connector.dart';
import 'package:pyro_call_screening_connector/pyro_call_screening_connector.dart';
import 'package:pyro_phone_location_connector/pyro_phone_location_connector.dart';
import 'package:pyro_sim_slot_rules_connector/pyro_sim_slot_rules_connector.dart';
import 'package:pyro_call_interception_policy_connector/pyro_call_interception_policy_connector.dart';
import 'package:pyro_deletion_proposal_connector/pyro_deletion_proposal_connector.dart';
import 'package:pyro_time_interceptor_connector/pyro_time_interceptor_connector.dart';
import 'package:pyro_phone_lookup_plugin_connector/pyro_phone_lookup_plugin_connector.dart';
import 'package:pyro_phone_subscription_connector/pyro_phone_subscription_connector.dart';
import 'package:pyro_phone_rules_connector/pyro_phone_rules_connector.dart';
import 'package:pyro_phone_count_filter_connector/pyro_phone_count_filter_connector.dart';
import 'package:pyro_phone_remote_filter_connector/pyro_phone_remote_filter_connector.dart';
import 'package:pyro_phone_call_history_connector/pyro_phone_call_history_connector.dart';
import 'package:pyro_phone_live_activities_connector/pyro_phone_live_activities_connector.dart';
import 'package:pyro_phone_call_overlay_connector/pyro_phone_call_overlay_connector.dart';
import 'package:pyro_phone_call_statistic_connector/pyro_phone_call_statistic_connector.dart';
import 'package:pyro_phone_country_sync_connector/pyro_phone_country_sync_connector.dart';
import 'package:pyro_device_profile_connector/pyro_device_profile_connector.dart';
import 'package:pyro_phone_contacts_connector/pyro_phone_contacts_connector.dart';
import 'package:pyro_app_auto_update_connector/pyro_app_auto_update_connector.dart';
import 'package:pyro_call_filter_connector/pyro_call_filter_connector.dart';
import 'package:pyro_caller_identity_connector/pyro_caller_identity_connector.dart';
import 'package:pyro_call_monitor_connector/pyro_call_monitor_connector.dart';
import 'package:pyro_call_coordinator_connector/pyro_call_coordinator_connector.dart';
import 'package:pyro_phone_marking_connector/pyro_phone_marking_connector.dart';

void _initPackageConnectors() {
  TelephonyConnectors.ensureMounted();
  CallRedirectionConnectors.ensureMounted();
  CallScreeningConnectors.ensureMounted();
  SimSlotRuleConnector.registerAll();
  PyroPhoneLocationConnector.registerAll();
  PyroCallInterceptionPolicyConnector.registerAll();
  PyroDeletionProposalConnector.registerAll();
  PyroTimeInterceptorConnector.registerAll();
  PyroPhoneLookupPluginConnector.registerAll();
  PyroPhoneSubscriptionConnector.registerAll();
  PyroPhoneRulesConnector.registerAll();
  PyroPhoneCountFilterConnector.registerAll();
  PyroPhoneRemoteFilterConnector.registerAll();
  PyroPhoneCallHistoryConnector.registerAll();
  PyroPhoneLiveActivitiesConnector.registerAll();
  PyroPhoneCallOverlayConnector.registerAll();
  PyroPhoneCallStatisticConnector.registerAll();
  PyroPhoneCountrySyncConnector.registerAll();
  PyroDeviceProfileConnector.registerAll();
  PyroPhoneContactsConnector.registerAll();
  PyroAppAutoUpdateConnector.registerAll();
  PyroCallFilterConnector.registerAll();
  PyroCallerIdentityConnector.registerAll();
  PyroCallMonitorConnector.registerAll();
  PyroCallCoordinatorConnector.registerAll();
  PyroPhoneMarkingConnector.registerAll();
  debugPrint('[Main] 33 个 Package Suite Connector 全外观自注册装配完成！');
}

Future<void> main() async {
  // 确保 Flutter 绑定初始化
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // 保持原生启动屏幕直到 Flutter 渲染第一帧
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // === 静态外观装配线全自动自注册 ===
  _initPackageConnectors();

  try {
    // 异步初始化Firebase服务（非阻塞后台执行）
    final firebaseService = FirebaseService();
    unawaited(
      firebaseService
          .initialize()
          .then((_) {
            firebaseService.logAppOpen();
          })
          .catchError((e, st) {
            debugPrint('Firebase init error: $e');
          }),
    );

    // 初始化应用日志服务
    AppLogger.initialize();

    // 初始化广告SDK（非阻塞后台执行）
    unawaited(
      MobileAds.instance.initialize().catchError((e) {
        debugPrint('MobileAds init error: $e');
        return InitializationStatus({});
      }),
    );

    // 初始化数据库服务（单例构造已完成内部初始化，无需显式 initialize）
    DatabaseService();

    // 创建一个顶层ProviderContainer
    final container = ProviderContainer();

    // 核心来电监控与事件监听服务在后台激活（不需要在 main 里用 await 阻塞首帧渲染）
    container.read(callerIdMonitorServiceProvider.notifier);
    container.read(callEventListenerProvider);

    // 初始化通知服务
    container.read(notificationServiceProvider);
    // --- Add ---
    container.read(overlayControlHandlerProvider);

    // 后台与云端同步服务让出首帧，待首屏渲染完毕后异步启动
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 【重要】读取一次 locationSyncServiceProvider 来激活它
      container.read(locationSyncServiceProvider);

      // 从而建立起 CallerIdService 和 LabelStreamSyncService 之间的连接。
      container.read(labelSyncServiceInitializerProvider);

      // 初始化插件同步服务
      container.read(pluginSyncServiceInitializerProvider);

      // 后台同步服务将通过Provider系统初始化
      if (!isOverlayMode) {
        container.read(backgroundSyncServiceProvider).initialize();
      }

      // 在应用启动时触发一次前台同步检查
      container.read(foregroundSyncServiceProvider).syncIfNeeded();

      // 初始化桌面小组件同步服务
      container.read(appWidgetSyncServiceProvider);
    });

    runApp(
      UncontrolledProviderScope(container: container, child: const MyApp()),
    );
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
  debugPrint('Running overlayMain entrypoint...');

  // 设置为覆盖层模式（只读模式）
  isOverlayMode = true;

  runApp(
    const ProviderScope(
      child: MaterialApp(
        title: 'Caller ID Overlay',
        home: CallOverlayEntry(), // 展示overlay内容
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    // 监听全局主题模式与种子色彩
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);

    final locale = ref.watch(localeProvider).value;

    return MaterialApp.router(
      title: 'Your Call Your Rule',

      // 1. 全局亮色与暗色主题接管
      theme: AppTheme.buildLightTheme(seedColor: themeColor),
      darkTheme: AppTheme.buildDarkTheme(seedColor: themeColor),

      // 2. 绑定全局主题模式 (Light / Dark / Follow System)
      themeMode: themeMode,

      routerConfig: appRouter.router,

      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
