import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/auto_update/pages/pages/auto_update_settings_page.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/enhanced_filter_settings_page.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/sim_slot_rule_page.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/call_history/pages/call_history_page_with_timeline.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/screens/caller_id_customization_screen.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/presentation/pages/time_interceptor_settings_page.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/pages/blocked_calls_page.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/pages/call_statistics_page.dart';
import 'package:yourcallyourrule/features/caller_id/pages/end_call_settings_page.dart';
import 'package:yourcallyourrule/features/contacts/pages/contact_subscription_page.dart';
import 'package:yourcallyourrule/features/contacts/pages/contacts_management_page.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/dashboard/pages/dashboard_page.dart';
import 'package:yourcallyourrule/features/home/pages/home_page.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';

import 'package:yourcallyourrule/features/local_filter/presentation/pages/local_filter_settings_page.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/onboarding/pages/onboarding_page.dart';
import 'package:yourcallyourrule/features/permissions/pages/permission_management_page.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/pages/remote_filter_settings_page.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/call_filter_settings_page.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';

import 'package:yourcallyourrule/features/rules/pages/allowed_blocked_page_refactored.dart';

import 'package:yourcallyourrule/features/rules/pages/rule_management_page.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/search/pages/search_page.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/presentation/settings/pages/filter_settings_page.dart';
import 'package:yourcallyourrule/presentation/settings/pages/settings_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_filter_settings_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_management_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_subscription_page.dart';
import 'package:yourcallyourrule/presentation/backup_restore/backup_restore_page.dart';
import 'package:yourcallyourrule/presentation/cloud/cloud_settings_page.dart';

import 'package:yourcallyourrule/presentation/device_management/device_management_page.dart';
import 'package:yourcallyourrule/presentation/plugin_test_page.dart';
import 'package:yourcallyourrule/presentation/regex_test_page.dart';
import 'package:yourcallyourrule/presentation/verification_page.dart';
import 'package:yourcallyourrule/purchase/purchase_page.dart';

/// 应用路由配置
/// 使用GoRouter管理全局路由表
class AppRouter {
  // 服务依赖
  final ConfigRepository configRepository;
  final TimeInterceptorService timeInterceptorService;
  final LocalCountFilterService localCountFilterService;
  final RemoteNumberFilterService remoteNumberFilterService;
  final RemoteNumberService remoteNumberService;
  final SimSlotRuleService simSlotRuleService;
  final EnhancedCompositeFilterService enhancedCompositeFilterService;
  
  // 构造函数
  AppRouter({
    required this.configRepository,
    required this.timeInterceptorService,
    required this.localCountFilterService,
    required this.remoteNumberFilterService,
    required this.remoteNumberService,
    required this.simSlotRuleService,
    required this.enhancedCompositeFilterService,
  });
  
  // 路由名称常量
  static const String timeInterceptorSettings = 'time-interceptor-settings';
  static const String localFilterSettings = 'local-filter-settings';
  static const String remoteFilterSettings = 'remote-filter-settings';
  static const String simSlotRuleSettings = 'sim-slot-rule-settings';
  static const String callFilterSettings = 'call-filter-settings';
  static const String allowedBlockedSettings = 'allowed-blocked-settings';
  static const String ruleManagementSettings = 'rule-management-settings';
  static const String callerIdCustomization = 'caller-id-customization';
  static const String endCallSettings = 'end-call-settings';
  static const String smsFilterSettings = 'sms-filter-settings';
  static const String backupRestore = 'backup-restore';
  static const String cloudSettings = 'cloud-settings';
  static const String deviceManagement = 'device-management';
  static const String purchaseSettings = 'purchase-settings';
  static const String enhancedFilterSettings = 'enhanced-filter-settings';
  static const String enhancedCompositeFilterSettings = 'enhanced-composite-filter-settings';
  static const String verificationPage = 'verification-page';
  static const String pluginTest = 'plugin-test';
  static const String regexTest = 'regex-test';
  static const String smsManagement = 'sms-management';
  static const String smsSubscription = 'sms-subscription';
  static const String contactSubscription = 'contact-subscription';
  static const String contactsManagement = 'contacts-management';
  static const String blockedCalls = 'blocked-calls';
  static const String callStatistics = 'call-statistics';
  static const String callHistory = 'call-history';
  static const String autoUpdate = 'auto-update';
  static const String permissionManagement = 'permission-management';
  static const String onboarding = 'onboarding';
  static const String dashboard = 'dashboard';
  static const String home = 'home';
  static const String filterSettings = 'filter-settings';
  static const String search = 'search';
  
  // 创建路由器
  late final router = GoRouter(
    initialLocation: '/',
    routes: [
      // 设置页面路由
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      // 主页路由
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/filter-settings',
        name: filterSettings,
        builder: (context, state) => const FilterSettingsPage(),
      ),
      
    GoRoute(
      path: '/allowed-blocked-settings',
      name: allowedBlockedSettings,
      builder: (context, state) => const AllowedBlockedPage(),
    ),
    GoRoute(
      path: '/rule-management-settings',
      name: ruleManagementSettings,
      builder: (context, state) => const RuleManagementPage(),
    ),

    // 搜索页面路由
    GoRoute(
      path: '/search',
      name: search,
      builder: (context, state) {
        final contactService = Provider.of<ContactService>(context, listen: false);
        final labelService = Provider.of<LabelService>(context, listen: false);
        final ruleManagementService = Provider.of<RuleManagementService>(context, listen: false);
        final allowedBlockedService = Provider.of<AllowedBlockedService>(context, listen: false);
        final remoteNumberService = Provider.of<RemoteNumberService>(context, listen: false);
        
        final searchService = SearchService(
          contactService: contactService,
          labelService: labelService,
          ruleManagementService: ruleManagementService,
          allowedBlockedService: allowedBlockedService,
          remoteNumberService: remoteNumberService,
          context: context,
        );
        
        return Provider.value(
          value: searchService,
          child: const SearchPage(),
        );
      },
    ),

      // 来电频率拦截设置页面
      GoRoute(
        path: '/$timeInterceptorSettings',
        name: timeInterceptorSettings,
        builder: (context, state) => TimeInterceptorSettingsPage(
          timeInterceptorService: timeInterceptorService,
          configRepository: configRepository,
        ),
      ),
      
      // 本地过滤器设置页面
      GoRoute(
        path: '/$localFilterSettings',
        name: localFilterSettings,
        builder: (context, state) => LocalFilterSettingsPage(
          localCountFilterService: localCountFilterService,
          configRepository: configRepository,
        ),
      ),
      
      // 远程号码过滤器设置页面
      GoRoute(
        path: '/$remoteFilterSettings',
        name: remoteFilterSettings,
        builder: (context, state) => RemoteFilterSettingsPage(
          remoteNumberFilterService: remoteNumberFilterService,
          remoteNumberService: remoteNumberService,
          configRepository: configRepository,
        ),
      ),
      
      // 增强过滤器设置页面
      GoRoute(
        path: '/enhanced_filter_settings',
        name: 'enhanced_filter_settings',
        builder: (context, state) => EnhancedFilterSettingsPage(
          enhancedCompositeFilterService: enhancedCompositeFilterService,
          simSlotRuleService: simSlotRuleService,
          localCountFilterService: localCountFilterService,
          remoteNumberFilterService: remoteNumberFilterService,
          remoteNumberService: remoteNumberService,
          configRepository: configRepository,
          ruleRepository: Provider.of<RuleRepository>(context, listen: false),
        ),
      ),
        
      // 增强版组合过滤器设置页面
      GoRoute(
        path: '/enhanced_composite_filter_settings',
        name: 'enhanced_composite_filter_settings',
        builder: (context, state) => EnhancedFilterSettingsPage(
          enhancedCompositeFilterService: enhancedCompositeFilterService,
          simSlotRuleService: simSlotRuleService,
          localCountFilterService: localCountFilterService,
          remoteNumberFilterService: remoteNumberFilterService,
          remoteNumberService: remoteNumberService,
          configRepository: configRepository,
          ruleRepository: Provider.of<RuleRepository>(context, listen: false),
        ),
      ),
      
      // SIM卡槽位规则设置页面
      GoRoute(
        path: '/$simSlotRuleSettings/:simSlotIndex',
        name: simSlotRuleSettings,
        builder: (context, state) {
          final simSlotIndex = int.parse(state.pathParameters['simSlotIndex'] ?? '0');
          return SimSlotRulePage(
            simSlotRuleService: simSlotRuleService,
            enhancedCompositeFilterService: state.extra as dynamic,
            configRepository: configRepository,
            ruleRepository: state.extra as dynamic,
            simSlotIndex: simSlotIndex,
          );
        },
      ),
      
      // 通话过滤设置页面
      GoRoute(
        path: '/$callFilterSettings',
        name: callFilterSettings,
        builder: (context, state) => CallFilterSettingsPage(
          callFilterService: state.extra as dynamic,
        ),
      ),

      // 来电显示自定义页面
      GoRoute(
        path: '/$callerIdCustomization',
        name: callerIdCustomization,
        builder: (context, state) => const CallerIdCustomizationScreen(),
      ),

      // 结束通话设置页面
      GoRoute(
        path: '/$endCallSettings',
        name: endCallSettings,
        builder: (context, state) => const EndCallSettingsPage(),
      ),

      // 短信过滤设置页面
      GoRoute(
        path: '/$smsFilterSettings',
        name: smsFilterSettings,
        builder: (context, state) => const SmsFilterSettingsPage(),
      ),

      // 备份还原页面
      GoRoute(
        path: '/$backupRestore',
        name: backupRestore,
        builder: (context, state) => const BackupRestorePage(),
      ),

      // 云端设置页面
      GoRoute(
        path: '/$cloudSettings',
        name: cloudSettings,
        builder: (context, state) => const CloudSettingsPage(),
      ),

      // 设备管理页面
      GoRoute(
        path: '/$deviceManagement',
        name: deviceManagement,
        builder: (context, state) => const DeviceManagementPage(),
      ),

      // 购买设置页面
      GoRoute(
        path: '/$purchaseSettings',
        name: purchaseSettings,
        builder: (context, state) => const PurchasePage(),
      ),

      // 增强过滤器设置页面
      GoRoute(
        path: '/$enhancedFilterSettings',
        name: enhancedFilterSettings,
        builder: (context, state) => EnhancedFilterSettingsPage(
          enhancedCompositeFilterService: enhancedCompositeFilterService,
          simSlotRuleService: simSlotRuleService,
          localCountFilterService: localCountFilterService,
          remoteNumberFilterService: remoteNumberFilterService,
          remoteNumberService: remoteNumberService,
          configRepository: configRepository,
          ruleRepository: Provider.of<RuleRepository>(context, listen: false),
        ),
      ),

      // 验证页面
      GoRoute(
        path: '/$verificationPage',
        name: verificationPage,
        builder: (context, state) => const VerificationPage(),
      ),

      // 插件测试页面
      GoRoute(
        path: '/$pluginTest',
        name: pluginTest,
        builder: (context, state) => const TestPage(title: '插件测试'),
      ),

      // 正则测试页面
      GoRoute(
        path: '/$regexTest',
        name: regexTest,
        builder: (context, state) => const RegexTestPage(),
      ),

      // 短信管理页面
      GoRoute(
        path: '/$smsManagement',
        name: smsManagement,
        builder: (context, state) => const SmsManagementPage(),
      ),

      // 短信订阅页面
      GoRoute(
        path: '/$smsSubscription',
        name: smsSubscription,
        builder: (context, state) => const SmsSubscriptionPage(),
      ),

      // 联系人订阅页面
      GoRoute(
        path: '/$contactSubscription',
        name: contactSubscription,
        builder: (context, state) => const ContactSubscriptionPage(),
      ),

      // 联系人管理页面
      GoRoute(
        path: '/$contactsManagement',
        name: contactsManagement,
        builder: (context, state) => const ContactsManagementPage(),
      ),

      // 已拦截通话页面
      GoRoute(
        path: '/$blockedCalls',
        name: blockedCalls,
        builder: (context, state) => BlockedCallsPage(
          repository: state.extra as BlockedCallRepository,
        ),
      ),

      // 通话统计页面
      GoRoute(
        path: '/$callStatistics',
        name: callStatistics,
        builder: (context, state) => const CallStatisticsPage(),
      ),

      // 通话历史页面
      GoRoute(
        path: '/$callHistory',
        name: callHistory,
        builder: (context, state) => const CallHistoryPageWithTimeline(),
      ),

      // 自动更新设置页面
      GoRoute(
        path: '/$autoUpdate',
        name: autoUpdate,
        builder: (context, state) => const AutoUpdateSettingsPage(),
      ),

      // 权限管理页面
      GoRoute(
        path: '/$permissionManagement',
        name: permissionManagement,
        builder: (context, state) => const PermissionManagementPage(),
      ),

      // 引导页面
      GoRoute(
        path: '/$onboarding',
        name: onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),

      // 仪表盘页面
      GoRoute(
        path: '/$dashboard',
        name: dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
  
  // 导航到来电频率拦截设置页面
  void navigateToTimeInterceptorSettings(BuildContext context) {
    context.goNamed(timeInterceptorSettings);
  }
  
  // 导航到本地过滤器设置页面
  void navigateToLocalFilterSettings(BuildContext context) {
    context.goNamed(localFilterSettings);
  }
  
  // 导航到远程号码过滤器设置页面
  void navigateToRemoteFilterSettings(BuildContext context) {
    context.goNamed(remoteFilterSettings);
  }
  
  // 导航到SIM卡槽位规则设置页面
  void navigateToSimSlotRuleSettings(BuildContext context, int simSlotIndex, dynamic extra) {
    context.goNamed(
      simSlotRuleSettings,
      pathParameters: {'simSlotIndex': simSlotIndex.toString()},
      extra: extra,
    );
  }
  
  // 导航到通话过滤设置页面
  void navigateToCallFilterSettings(BuildContext context, dynamic callFilterService) {
    context.goNamed(
      callFilterSettings,
      extra: callFilterService,
    );
  }

  // 导航到搜索页面
  void navigateToSearch(BuildContext context) {
    context.goNamed(search);
  }
}