import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/theme/app_theme.dart';
import 'package:yourcallyourrule/theme/theme_provider.dart';

// === All 33 Package Suite Connectors ===
import 'package:pyro_app_launch_guard/pyro_app_launch_guard.dart';
import 'package:pyro_telephony_connector/pyro_telephony_connector.dart';
import 'package:pyro_call_redirection_connector/pyro_call_redirection_connector.dart';
import 'package:pyro_call_screening_connector/pyro_call_screening_connector.dart';
import 'package:pyro_phone_location_connector/pyro_phone_location_connector.dart';
import 'package:pyro_phone_sim_slot_rules_connector/pyro_phone_sim_slot_rules_connector.dart';
import 'package:pyro_phone_call_interception_policy_connector/pyro_phone_call_interception_policy_connector.dart';
import 'package:pyro_deletion_proposal_connector/pyro_deletion_proposal_connector.dart';
import 'package:pyro_phone_time_interceptor_connector/pyro_phone_time_interceptor_connector.dart';
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
import 'package:pyro_phone_call_filter_connector/pyro_phone_call_filter_connector.dart';
import 'package:pyro_phone_caller_identity_connector/pyro_phone_caller_identity_connector.dart';
import 'package:pyro_phone_call_monitor_connector/pyro_phone_call_monitor_connector.dart';
import 'package:pyro_phone_call_coordinator_connector/pyro_phone_call_coordinator_connector.dart';
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
  debugPrint('[Main] 33 个 Package Suite Connector 全外观自注册装配完成');
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // === 静态外观装配线全自动自注册 ===
  _initPackageConnectors();

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
  } finally {
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

    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);

    final locale = ref.watch(localeProvider).value;

    return MaterialApp.router(
      title: 'Your Call Your Rule',
      builder: PyroAppLaunchGuard.builder(),
      theme: AppTheme.buildLightTheme(seedColor: themeColor),
      darkTheme: AppTheme.buildDarkTheme(seedColor: themeColor),
      themeMode: themeMode,
      routerConfig: appRouter.router,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
