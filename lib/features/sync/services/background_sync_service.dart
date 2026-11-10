import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/sync/services/app_sync_bridge_connector.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_service.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_sync_service.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import '../../common/error/logger.dart';
import 'package:yourcallyourrule/features/common/services/firebase_service.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/features/sync/constants/background_task_keys.dart';

part 'background_sync_service.g.dart';

/// 后台同步服务提供者
@Riverpod(keepAlive: true)
BackgroundSyncService backgroundSyncService(Ref ref) {
  final syncManager = ref.watch(appSyncBridgeConnectorProvider);
  return BackgroundSyncService(syncManager);
}

const syncCallLogTask = BackgroundTaskKeys.syncCallLogTask;
const autoUpdateTask = BackgroundTaskKeys.autoUpdateTask;
const dataSyncTask = BackgroundTaskKeys.dataSyncTask;

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await FirebaseService().initialize();
      AppLogger.initialize();
      DatabaseService();

      final container = ProviderContainer();

      switch (task) {
        case autoUpdateTask:
          final phoneService = container.read(phoneSubscriptionServiceProvider);
          final smsService = container.read(smsSubscriptionServiceProvider);
          final contactService = container.read(contactSubscriptionServiceProvider);
          final pluginService = container.read(pluginManagerServiceProvider);
          final configRepo = container.read(configRepositoryProvider);

          final autoUpdateService = AutoUpdateService(
            phoneService: phoneService,
            smsService: smsService,
            contactService: contactService,
            pluginService: pluginService,
            configRepository: configRepo,
          );

          await autoUpdateService.updateAll();
          break;

        case dataSyncTask:
          final syncManager = container.read(appSyncBridgeConnectorProvider);
          await syncManager.syncIncremental();
          break;

        default:
          container.dispose();
          return false;
      }

      container.dispose();
      return true;
    } catch (e) {
      debugPrint('后台任务执行错误: $e');
      return false;
    }
  });
}

/// 后台同步服务，负责管理应用的后台同步任务
class BackgroundSyncService {
  static const String syncTaskName = BackgroundTaskKeys.syncTaskTag;
  final AppSyncBridgeConnector _syncConnector;

  BackgroundSyncService(this._syncConnector);

  Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
    );

    await Workmanager().registerPeriodicTask(
      BackgroundTaskKeys.autoUpdateTaskId,
      autoUpdateTask,
      frequency: const Duration(days: 1),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  }

  Future<void> cancelAllSyncTasks() async {
    await Workmanager().cancelByTag(syncTaskName);
  }
}
