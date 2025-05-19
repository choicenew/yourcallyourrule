import 'package:provider/provider.dart';

// 广告和购买相关
import 'package:yourcallyourrule/ads/ad_state.dart';
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
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';

// 数据提供者

// 云同步相关

// 服务和仓库
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
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
import '../../features/rules/services/blacklist_whitelist_service.dart';
import '../../features/language/services/locale_service.dart';

// 功能模块
import '../../features/call/caller_id/providers/caller_id_style_provider.dart';

// 云同步服务
import '../../cloud_sync/services/backup_encryption_service.dart';
import '../../cloud_sync/services/backup_restore_service.dart';
import '../../cloud_sync/services/local_storage_service.dart';
import '../../cloud_sync/services/rule_import_export_service.dart';

List<ChangeNotifierProvider> getAppProviders() {
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
  final blacklistWhitelistService = BlacklistWhitelistService(ruleRepository);
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
    blacklistWhitelistService: blacklistWhitelistService,
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

  // 注意：AsyncNotifierProvider类型的提供者不能直接转换为ChangeNotifierProvider
  // 这些提供者应该在使用Riverpod的地方通过ref.watch()方式获取

  return [
    // 核心服务 - 这些是真正的ChangeNotifier子类
    ChangeNotifierProvider(
        create: (_) =>
            HomeStatsProvider(callLogService, blacklistWhitelistService)),
    ChangeNotifierProvider(create: (_) => LocaleProvider(localeService)),
    ChangeNotifierProvider(create: (_) => CallerIdStyleProvider()),
    ChangeNotifierProvider(
        create: (context) => PurchaseProvider(
            context, PurchaseState(configRepository: configRepository))),
    ChangeNotifierProvider(
        create: (_) => PurchaseState(configRepository: configRepository)),
    ChangeNotifierProvider(create: (_) => AdState()),

    // 注意：其他服务不是ChangeNotifier的子类，不能直接注册为ChangeNotifierProvider
    // 这些服务应该通过Provider.value()方式提供，或者在使用的地方直接引用实例
    // 例如：Provider.value(value: callerIdService)
  ];

  // 注意：以下服务和仓库已经初始化，可以在应用中直接使用：
  // callerIdService, contactService, labelService, locationService,
  // predefinedLabelService, remoteNumberService, pluginService,
  // callLogService, blacklistWhitelistService, labelPhoneService

  // 注意：以下Riverpod提供者在此处不能直接注册为ChangeNotifierProvider
  // callLogsProvider, contactsProvider, rulesProvider, pluginsProvider,
  // predefinedLabelsProvider, labelPhonesProvider, locationsProvider,
  // listsProvider, subscriptionsProvider, smsSubscriptionsProvider,
  // contactSubscriptionsProvider
}
