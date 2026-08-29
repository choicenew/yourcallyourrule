import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_remote_database.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_service.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_sync_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/phone_subscription_service_provider.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_subscription_service_provider.dart';
import 'package:yourcallyourrule/features/sms/providers/sms_subscription_service_provider.dart';

import 'package:yourcallyourrule/core/provider/providers/plugin_manager_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_provider.dart';
import 'package:yourcallyourrule/common/error/logger.dart';
import 'package:yourcallyourrule/core/services/firebase_service.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';





const syncCallLogTask = "syncCallLogTask";
const autoUpdateTask = "autoUpdateTask";
const dataSyncTask = "dataSyncTask";

// 这是一个顶层函数，用作后台任务的入口点
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // 在后台 Isolate 中，我们需要手动初始化应用所需的服务
      // 确保 Flutter 核心引擎已绑定
      WidgetsFlutterBinding.ensureInitialized();
      
      // 初始化 Firebase 服务，以便能够记录潜在的错误
      await FirebaseService().initialize();
      
      // 初始化日志服务
      AppLogger.initialize();
      
      // 初始化数据库服务，这是同步所必需的
      DatabaseService();

      // 为了在后台任务中访问 Riverpod provider，我们需要创建一个 ProviderContainer
      final container = ProviderContainer();
      
      switch (task) {
        case syncCallLogTask:
          // 同步通话记录
          final syncService = container.read(callLogSyncServiceProvider);
          await syncService.syncSystemCallLogs();
          break;
          
        case autoUpdateTask:
          // 执行自动更新任务
          // 注意：这里我们直接创建AutoUpdateService实例
          // 在实际应用中，可能需要通过Provider获取
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
          // 执行数据同步任务
          final syncManager = container.read(incrementalSyncManagerProvider);
          await syncManager.syncIncremental();
          break;
          
        default:
          // 未知任务类型
          container.dispose();
          return Future.value(false);
      }
      
      // 记得在任务完成后释放 container
      container.dispose();
      
      return Future.value(true);
    } catch (e) {
      debugPrint('后台任务执行错误: $e');
      return Future.value(false);
    }
  });
}

/// 后台同步服务，负责管理应用的后台同步任务
class BackgroundSyncService {
  static const String syncTaskName = 'com.yourcallyourrule.sync';
  final IncrementalSyncManager _syncManager;

  BackgroundSyncService(this._syncManager);
  
  /// 初始化后台同步服务
  Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
    );
    
    // 注册通话记录同步任务
    await Workmanager().registerPeriodicTask(
      "1",
      syncCallLogTask,
      frequency: const Duration(hours: 1), // 每小时同步一次
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
    
    // 注册自动更新任务
    await Workmanager().registerPeriodicTask(
      "2",
      autoUpdateTask,
      frequency: const Duration(days: 1), // 每天更新一次
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
    /*
    // 注册数据同步任务
    await Workmanager().registerPeriodicTask(
      "3",
      dataSyncTask,
      frequency: const Duration(days: 1), // 每天同步一次
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    );
    */
  }
  
  /// 取消所有同步任务
  Future<void> cancelAllSyncTasks() async {
    await Workmanager().cancelByTag(syncTaskName);
  }
}