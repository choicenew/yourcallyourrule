import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// 广告和购买相关
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_phone_service.dart';
import 'package:yourcallyourrule/purchase/purchase_provider.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

// 基础仓库提供者
import 'package:yourcallyourrule/core/provider/basic_provider/call_log_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/contact_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/contact_subscription_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/label_phone_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/list_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/location_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/plugin_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/predefined_label_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/sms_subscription_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/subscription_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/remote/remote_number_repository_impl.dart';
import 'package:yourcallyourrule/data/repositories/label/label_repository_impl.dart';
import 'package:yourcallyourrule/data/database/remote/remote_data_access_restriction.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_webview_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/plugin_to_remote_sync_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_to_remote_sync_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';

// 数据提供者

// 云同步相关

// 服务和仓库
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/home/providers/home_stats_provider.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_invoker_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

// 核心服务
import '../../data/database/database_service.dart';
import '../../data/database/local/local_database_manager.dart';
import '../../features/call/call_history/services/call_log_service.dart';
import '../../features/rules/services/rule_management_service.dart';
import '../../features/language/services/locale_service.dart';

// 功能模块
import '../../features/call/caller_id/providers/caller_id_style_provider.dart';

// 云同步服务
import '../../cloud_sync/services/backup_encryption_service.dart';
import '../../cloud_sync/services/backup_restore_service.dart';
import '../../cloud_sync/services/local_storage_service.dart';
import '../../cloud_sync/services/rule_import_export_service.dart';

List<SingleChildStatelessWidget> getAppProviders() {
  // 初始化核心服务
  final databaseService = DatabaseService();
  final localDatabaseManager = LocalDatabaseManagerImpl();
  final configRepository = SharedPreferencesConfigRepository();

  // 初始化核心仓库
  final contactRepository = ContactRepositoryImpl(databaseService);
  final labelRepository = LabelRepositoryImpl();
  final remoteNumberRepository = RemoteNumberRepositoryImpl(configRepository);
  // 获取RemoteDataAccessRestriction的单例实例
  final remoteDataAccess = RemoteDataAccessRestrictionImpl();
  final callLogRepository = CallLogRepositoryImpl(databaseService);
  // 注意：这里需要使用正确的构造函数参数类型
  final ruleRepository = RuleRepositoryImpl(databaseService);
  final pluginRepository = PluginRepositoryImpl(databaseService);
  final predefinedLabelRepository =
      PredefinedLabelRepositoryImpl(localDatabaseManager);
  final locationRepository = LocationRepositoryImpl(databaseService);
  final labelPhoneRepository = LabelPhoneRepositoryImpl(databaseService);
  final listRepository = ListRepositoryImpl(databaseService);
  final subscriptionRepository = SubscriptionRepositoryImpl(databaseService);
  final smsSubscriptionRepository =
      SmsSubscriptionRepositoryImpl(databaseService);
  final contactSubscriptionRepository =
      ContactSubscriptionRepositoryImpl(databaseService);

  // 核心服务初始化
  final callLogService = CallLogService(callLogRepository);
  final callLogRecorder = CallLogRecorder(callLogService);
  final ruleManagementService = RuleManagementService(ruleRepository);
  final localeService = LocaleService(configRepository);
  // 初始化插件WebView服务
  final pluginWebViewService = PluginWebViewService();

  // 初始化插件管理服务
  final pluginManagerService = PluginManagerService(pluginRepository,
      configRepository: configRepository);

  // 初始化插件调用服务
  final pluginService =
      PluginInvokerService(pluginManagerService, pluginWebViewService);
  final predefinedLabelService =
      PredefinedLabelService(predefinedLabelRepository);
  final locationService = LocationService(locationRepository);
  final contactService = ContactService(contactRepository);
  final labelService = LabelService(ruleRepository, predefinedLabelService);
  final remoteNumberService =
      RemoteNumberService(ruleRepository, remoteDataAccess);
  final labelPhoneService =
      LabelPhoneService(ruleRepository, predefinedLabelService);
  
  // 初始化标签到远程号码同步服务
  final labelToRemoteSyncService = LabelToRemoteSyncService(
      remoteNumberService, labelService, predefinedLabelService);

  // 初始化云同步服务
  final backupRestoreService = BackupRestoreService(
    BackupEncryptionService(),
    RuleImportExportService(
      LocalStorageService(localDatabaseManager),
      configRepository: configRepository,
    ),
  );

  // 初始化调用者ID服务
  final callerIdService = CallerIdService(
    pluginService: pluginService,
    contactService: contactService,
    ruleManagementService: ruleManagementService,
    labelService: labelService,
    locationService: locationService,
    predefinedLabelService: predefinedLabelService,
    remoteNumberService: remoteNumberService,
  );

  // 初始化插件数据同步服务，将CallerIdService的数据流连接到RemoteNumberService
  // 这里直接集成了SyncServiceInitializer的功能
  final pluginToRemoteSyncService =
      PluginToRemoteSyncService(remoteNumberService);
  pluginToRemoteSyncService.startSync(
    callerIdService.pluginDataStream,
    callerIdService.labelPhoneEntryStream,
  );
  
  // 初始化本地号码计数过滤服务
  final localCountFilterService = LocalCountFilterService(
    callerIdService: callerIdService,
    configRepository: configRepository,
  );
  // 初始化服务并设置数据流订阅
  localCountFilterService.initialize();

   // 初始化远程号码过滤服务
 final remoteNumberFilterService = RemoteNumberFilterService(
   remoteNumberService: remoteNumberService,
   configRepository: configRepository,
 );
  // 初始化服务
   remoteNumberFilterService.initialize();
   
  // 初始化时间拦截服务
  final timeInterceptorService = TimeInterceptorService(configRepository, callLogRepository);
  // 初始化服务
  timeInterceptorService.initialize();

  // 初始化SIM卡槽位规则服务
   final simSlotRuleService = SimSlotRuleService(
     ruleRepository: ruleRepository,
     configRepository: configRepository
   );
  
  // 初始化增强版组合过滤器服务
  final enhancedCompositeFilterService = EnhancedCompositeFilterService(
    filters: [
      // 添加远程号码过滤服务作为过滤器
      remoteNumberFilterService,
      // 添加本地号码计数过滤服务作为过滤器
      localCountFilterService,
      // 可以在此处添加更多过滤器
    ],
    simSlotRuleService: simSlotRuleService,
    configRepository: configRepository,
  );
  // 初始化组合过滤器服务
  enhancedCompositeFilterService.initialize();

  // 注意：AsyncNotifierProvider类型的提供者不能直接转换为ChangeNotifierProvider
  // 这些提供者应该在使用Riverpod的地方通过ref.watch()方式获取

  // 创建路由器
  final appRouter = AppRouter(
    configRepository: configRepository,
    timeInterceptorService: timeInterceptorService,
    localCountFilterService: localCountFilterService,
    remoteNumberFilterService: remoteNumberFilterService,
    remoteNumberService: remoteNumberService,
    simSlotRuleService: simSlotRuleService,
    enhancedCompositeFilterService: enhancedCompositeFilterService,
  );

  // 返回ChangeNotifierProvider列表
  final changeNotifierProviders = [
    // 核心服务 - 这些是真正的ChangeNotifier子类
    ChangeNotifierProvider(
        create: (_) =>
            HomeStatsProvider(callLogService, ruleManagementService)),
    ChangeNotifierProvider(create: (_) => LocaleProvider(localeService)),
    ChangeNotifierProvider(create: (_) => CallerIdStyleProvider()),
    // 提供路由器
    Provider<AppRouter>.value(value: appRouter),
    ChangeNotifierProvider(
        create: (context) => PurchaseProvider(
            context, PurchaseState(configRepository: configRepository))),
    ChangeNotifierProvider(
        create: (_) => PurchaseState(configRepository: configRepository)),
    ChangeNotifierProvider(create: (_) => AdState()),
    // 添加广告控制服务
    ChangeNotifierProvider(
        create: (context) => AdControlService(
            Provider.of<PurchaseState>(context, listen: false),
            Provider.of<AdState>(context, listen: false))),
    Provider<CallLogRecorder>.value(value: callLogRecorder),
  ];
  
 
 
  
  return changeNotifierProviders;
  

  // 注意：以下服务和仓库已经初始化，可以在应用中直接使用：
  // callerIdService, contactService, labelService, locationService,
  // predefinedLabelService, remoteNumberService, pluginService,
  // callLogService, ruleManagementService, labelPhoneService, labelToRemoteSyncService

  // 注意：以下Riverpod提供者在此处不能直接注册为ChangeNotifierProvider
  // callLogsProvider, contactsProvider, rulesProvider, pluginsProvider,
  // predefinedLabelsProvider, labelPhonesProvider, locationsProvider,
  // listsProvider, subscriptionsProvider, smsSubscriptionsProvider,
  // contactSubscriptionsProvider
}

/// 获取所有服务的Provider列表，用于在应用的根MultiProvider中使用
/// 这些服务不是ChangeNotifier的子类，不能直接注册为ChangeNotifierProvider
List<Provider> getServiceProviders() {
  // 初始化核心服务
  final databaseService = DatabaseService();
  final localDatabaseManager = LocalDatabaseManagerImpl();
  final configRepository = SharedPreferencesConfigRepository();

  // 初始化核心仓库
  final contactRepository = ContactRepositoryImpl(databaseService);
  final labelRepository = LabelRepositoryImpl();
  final remoteNumberRepository = RemoteNumberRepositoryImpl(configRepository);
  final remoteDataAccess = RemoteDataAccessRestrictionImpl();
  final callLogRepository = CallLogRepositoryImpl(databaseService);
  final ruleRepository = RuleRepositoryImpl(databaseService);
  final pluginRepository = PluginRepositoryImpl(databaseService);
  final predefinedLabelRepository =
      PredefinedLabelRepositoryImpl(localDatabaseManager);
  final locationRepository = LocationRepositoryImpl(databaseService);
  final labelPhoneRepository = LabelPhoneRepositoryImpl(databaseService);
  
  // 核心服务初始化
  final callLogService = CallLogService(callLogRepository);
  final callLogRecorder = CallLogRecorder(callLogService);
  final ruleManagementService = RuleManagementService(ruleRepository);
  final localeService = LocaleService(configRepository);
  final pluginWebViewService = PluginWebViewService();
  final pluginManagerService = PluginManagerService(pluginRepository,
      configRepository: configRepository);
  final pluginService =
      PluginInvokerService(pluginManagerService, pluginWebViewService);
  final predefinedLabelService =
      PredefinedLabelService(predefinedLabelRepository);
  final locationService = LocationService(locationRepository);
  final contactService = ContactService(contactRepository);
  final labelService = LabelService(ruleRepository, predefinedLabelService);
  final remoteNumberService =
      RemoteNumberService(ruleRepository, remoteDataAccess);
  final labelPhoneService =
      LabelPhoneService(ruleRepository, predefinedLabelService);
  
  // 初始化标签到远程号码同步服务
  final labelToRemoteSyncService = LabelToRemoteSyncService(
      remoteNumberService, labelService, predefinedLabelService);

  // 初始化调用者ID服务
  final callerIdService = CallerIdService(
    pluginService: pluginService,
    contactService: contactService,
    ruleManagementService: ruleManagementService,
    labelService: labelService,
    locationService: locationService,
    predefinedLabelService: predefinedLabelService,
    remoteNumberService: remoteNumberService,
  );

  // 初始化插件数据同步服务
  final pluginToRemoteSyncService =
      PluginToRemoteSyncService(remoteNumberService);
  pluginToRemoteSyncService.startSync(
    callerIdService.pluginDataStream,
    callerIdService.labelPhoneEntryStream,
  );
  
  // 初始化本地号码计数过滤服务
  final localCountFilterService = LocalCountFilterService(
    callerIdService: callerIdService,
    configRepository: configRepository,
  );
  
  // 初始化远程号码过滤服务
  final remoteNumberFilterService = RemoteNumberFilterService(
    remoteNumberService: remoteNumberService,
    configRepository: configRepository,
  );
  
  // 初始化SIM卡槽位规则服务
   final simSlotRuleService = SimSlotRuleService(
     ruleRepository: ruleRepository,
     configRepository: configRepository
   );
  
  // 初始化增强版组合过滤器服务
  final enhancedCompositeFilterService = EnhancedCompositeFilterService(
    filters: [
      remoteNumberFilterService,
      localCountFilterService,
    ],
    simSlotRuleService: simSlotRuleService,
    configRepository: configRepository,
  );
  
  // 确保所有服务都已初始化
  localCountFilterService.initialize();
  remoteNumberFilterService.initialize();
  simSlotRuleService.initialize();

  enhancedCompositeFilterService.initialize();
  
  // 初始化允许/阻止规则服务
  final allowedBlockedService = AllowedBlockedService(ruleRepository);
  
  // 初始化广告控制服务
  final purchaseState = PurchaseState(configRepository: configRepository);
  final adState = AdState();
  final adControlService = AdControlService(purchaseState, adState);
  
  // 注意：SearchService 需要 BuildContext，所以我们在使用时创建实例
  // 这里只提供必要的服务，让使用方能够创建 SearchService
  
  // 返回所有服务的Provider
  return [
    Provider.value(value: callerIdService),
    Provider.value(value: labelService),
    Provider.value(value: remoteNumberService),
    Provider.value(value: callLogRecorder),
    Provider.value(value: remoteNumberFilterService),
    Provider.value(value: labelToRemoteSyncService),
    Provider.value(value: callLogService),
    Provider.value(value: enhancedCompositeFilterService),
    Provider.value(value: ruleManagementService),
    Provider.value(value: contactService),
    Provider.value(value: locationService),
    Provider.value(value: predefinedLabelService),
    Provider.value(value: pluginService),
    Provider.value(value: labelPhoneService),
    Provider.value(value: localCountFilterService),
    Provider.value(value: simSlotRuleService),
    Provider.value(value: allowedBlockedService),
    Provider.value(value: adControlService),
  ];


}
