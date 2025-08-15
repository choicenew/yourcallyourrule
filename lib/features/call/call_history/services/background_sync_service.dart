import 'package:workmanager/workmanager.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_sync_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/sync/incremental_sync_manager_remote_database.dart';
import 'package:yourcallyourrule/features/auto_update/services/auto_update_service.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/core/provider/providers/phone_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/sms_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/contact_subscription_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/plugin_manager_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';

const syncCallLogTask = "syncCallLogTask";
const autoUpdateTask = "autoUpdateTask";
const dataSyncTask = "dataSyncTask";

// 这是一个顶层函数，用作后台任务的入口点
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
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
          final syncManager = IncrementalSyncManager();
          await syncManager.initialize();
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
      print('后台任务执行错误: $e');
      return Future.value(false);
    }
  });
}

class BackgroundSyncService {
  final IncrementalSyncManager _syncManager = IncrementalSyncManager();
  
  Future<void> initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true, // 在调试模式下启用日志
    );
    
    // 注册通话记录同步任务
    await Workmanager().registerPeriodicTask(
      "1",
      syncCallLogTask,
      frequency: const Duration(hours: 1), // 每小时同步一次
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
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
    );
    
    // 注册数据同步任务
    await Workmanager().registerPeriodicTask(
      "3",
      dataSyncTask,
      frequency: const Duration(hours: 3), // 每3小时同步一次
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
    
    // 初始化同步管理器
    await _syncManager.initialize();
  }
}