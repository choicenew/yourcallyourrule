import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pyro_app_launch_guard/pyro_app_launch_guard.dart';
import 'package:yourcallyourrule/core/coordinator/package_connectors_initializer.dart';
import 'package:yourcallyourrule/features/common/error/logger.dart';
import 'package:yourcallyourrule/features/sync/services/background_sync_service.dart';
import 'package:yourcallyourrule/features/sync/services/foreground_sync_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_stream_sync_service.dart';
import 'package:yourcallyourrule/features/caller_identity/services/plugin_to_remote_sync_service.dart';
import 'package:yourcallyourrule/features/phone_location/services/location_sync_service.dart';
import 'package:yourcallyourrule/features/common/router/app_router_provider.dart';
import 'package:yourcallyourrule/features/common/services/firebase_service.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/features/call_history/provider/call_event_listener_provider.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/call_overlay_entry.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/overlay_control_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/services/caller_id_monitor_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';
import 'package:yourcallyourrule/features/widgets/services/app_widget_sync_service.dart';
import 'package:yourcallyourrule/features/splash/splash_screen.dart';
import 'package:yourcallyourrule/features/onboarding/pages/onboarding_page.dart';
import 'package:yourcallyourrule/features/onboarding/services/onboarding_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/theme/app_theme.dart';
import 'package:yourcallyourrule/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // === 一行调起独立文件的全量 Connector 注册 ===
  initPackageConnectors();

  try {
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

    AppLogger.initialize();

    unawaited(
      MobileAds.instance.initialize().catchError((e) {
        debugPrint('MobileAds init error: $e');
        return Future<InitializationStatus>.value(InitializationStatus({}));
      }),
    );

    DatabaseService();

    final container = ProviderContainer();

    container.read(callerIdMonitorServiceProvider);
    container.read(callEventListenerProvider);

    container.read(notificationServiceProvider);
    container.read(overlayControlHandlerProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 第一帧绘制完成后平滑移除原生 Splash，绝不提前移除导致真机黑屏
      FlutterNativeSplash.remove();

      container.read(locationSyncServiceProvider);

      container.read(labelStreamSyncServiceProvider);

      container.read(pluginSyncServiceInitializerProvider);

      if (!isOverlayMode) {
        container.read(backgroundSyncServiceProvider).initialize();
      }

      container.read(foregroundSyncServiceProvider).syncIfNeeded();

      container.read(appWidgetSyncServiceProvider.notifier);
    });

    runApp(
      UncontrolledProviderScope(container: container, child: const MyApp()),
    );
  } catch (e, stackTrace) {
    debugPrint('初始化错误: $e');
    debugPrint('堆栈跟踪: $stackTrace');

    try {
      FirebaseService().recordError(e, stackTrace);
    } catch (_) {
      // 忽略
    }
    FlutterNativeSplash.remove();
  }
}

bool isOverlayMode = false;

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('Running overlayMain entrypoint...');

  isOverlayMode = true;

  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Caller ID Overlay',
        home: CallOverlayEntry(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
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

    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);

    final locale = ref.watch(localeProvider).value;

    return MaterialApp.router(
      title: 'Your Call Your Rule',
      builder: PyroAppLaunchGuard.builder(
        splashBuilder: (context) => const SplashScreen(),
        config: LaunchConfig(
          shouldShowOnboardingCheck: () async {
            final onboardingService = ref.read(onboardingServiceProvider);
            final isCompleted = await onboardingService.isOnboardingCompleted();
            return !isCompleted;
          },
          onOnboardingCompletedSaveCallback: () async {
            final onboardingService = ref.read(onboardingServiceProvider);
            await onboardingService.completeOnboarding();
          },
        ),
        onboardingBuilder: (context, onComplete) {
          return OnboardingPage(onComplete: onComplete);
        },
      ),
      theme: AppTheme.buildLightTheme(seedColor: themeColor),
      darkTheme: AppTheme.buildDarkTheme(seedColor: themeColor),
      themeMode: themeMode,
      routerConfig: appRouter.router,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
