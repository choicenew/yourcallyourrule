import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 领域层
import '../domain/repositories/rule_repository.dart';
import '../domain/repositories/contact_repository.dart';
import '../domain/repositories/call_repository.dart';
import '../domain/repositories/sms_repository.dart';
import '../domain/services/rule_matcher_service.dart';
import '../domain/services/rule_priority_service.dart';

// 基础设施层
import '../infrastructure/datasources/local/preferences/app_preferences.dart';
import '../infrastructure/datasources/local/database/app_database.dart';
import '../infrastructure/repositories/rule_repository_impl.dart';
import '../infrastructure/repositories/contact_repository_impl.dart';
import '../infrastructure/repositories/call_repository_impl.dart';
import '../infrastructure/repositories/sms_repository_impl.dart';
import '../infrastructure/services/permission_service_impl.dart';
import '../infrastructure/services/notification_service_impl.dart';
import '../infrastructure/services/platform_service_impl.dart';

// 应用层
import '../application/usecases/rule/add_rule.dart';
import '../application/usecases/rule/delete_rule.dart';
import '../application/usecases/rule/update_rule.dart';
import '../application/usecases/rule/get_rules.dart';
import '../application/usecases/rule/match_rule.dart';
import '../application/usecases/call/filter_call.dart';
import '../application/usecases/call/log_call.dart';
import '../application/usecases/sms/filter_sms.dart';
import '../application/usecases/sms/log_sms.dart';
import '../application/usecases/contact/get_contacts.dart';
import '../application/usecases/contact/sync_contacts.dart';

// 表现层
import '../presentation/state/providers/app_provider.dart';
import '../presentation/state/providers/rule_provider.dart';
import '../presentation/state/providers/call_provider.dart';
import '../presentation/state/providers/sms_provider.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  // 外部依赖
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  // 数据库
  final appDatabase = await AppDatabase.getInstance();
  getIt.registerSingleton<AppDatabase>(appDatabase);
  
  // 本地数据源
  getIt.registerSingleton<AppPreferences>(AppPreferences(getIt<SharedPreferences>()));
  
  // 服务实现
  getIt.registerSingleton<PermissionServiceImpl>(PermissionServiceImpl());
  getIt.registerSingleton<NotificationServiceImpl>(NotificationServiceImpl());
  getIt.registerSingleton<PlatformServiceImpl>(PlatformServiceImpl());
  
  // 仓库实现
  getIt.registerSingleton<RuleRepository>(RuleRepositoryImpl(appDatabase));
  getIt.registerSingleton<ContactRepository>(ContactRepositoryImpl(appDatabase));
  getIt.registerSingleton<CallRepository>(CallRepositoryImpl(appDatabase));
  getIt.registerSingleton<SmsRepository>(SmsRepositoryImpl(appDatabase));
  
  // 领域服务
  getIt.registerSingleton<RuleMatcherService>(RuleMatcherService());
  getIt.registerSingleton<RulePriorityService>(RulePriorityService());
  
  // 用例
  getIt.registerFactory<AddRule>(() => AddRule(getIt<RuleRepository>()));
  getIt.registerFactory<DeleteRule>(() => DeleteRule(getIt<RuleRepository>()));
  getIt.registerFactory<UpdateRule>(() => UpdateRule(getIt<RuleRepository>()));
  getIt.registerFactory<GetRules>(() => GetRules(getIt<RuleRepository>()));
  getIt.registerFactory<MatchRule>(() => MatchRule(
    getIt<RuleRepository>(),
    getIt<RuleMatcherService>(),
    getIt<RulePriorityService>(),
  ));
  
  getIt.registerFactory<FilterCall>(() => FilterCall(
    getIt<MatchRule>(),
    getIt<CallRepository>(),
  ));
  getIt.registerFactory<LogCall>(() => LogCall(getIt<CallRepository>()));
  
  getIt.registerFactory<FilterSms>(() => FilterSms(
    getIt<MatchRule>(),
    getIt<SmsRepository>(),
  ));
  getIt.registerFactory<LogSms>(() => LogSms(getIt<SmsRepository>()));
  
  getIt.registerFactory<GetContacts>(() => GetContacts(getIt<ContactRepository>()));
  getIt.registerFactory<SyncContacts>(() => SyncContacts(getIt<ContactRepository>()));
  
  // Provider
  getIt.registerFactory<AppProvider>(() => AppProvider());
  getIt.registerFactory<RuleProvider>(() => RuleProvider(
    getIt<AddRule>(),
    getIt<DeleteRule>(),
    getIt<UpdateRule>(),
    getIt<GetRules>(),
  ));
  getIt.registerFactory<CallProvider>(() => CallProvider(
    getIt<FilterCall>(),
    getIt<LogCall>(),
  ));
  getIt.registerFactory<SmsProvider>(() => SmsProvider(
    getIt<FilterSms>(),
    getIt<LogSms>(),
  ));
}