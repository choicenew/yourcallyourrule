import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/provider/labels_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/contact_service_provider.dart';

import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/features/auto_update/pages/auto_update_settings_page.dart';

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/enhanced_filter_settings_page.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/sim_slot_rule_page.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/call_history/pages/call_history_page_with_timeline_with_ads.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/screens/caller_id_customization_screen.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/pages/fraud_alert_settings_page.dart';
import 'package:yourcallyourrule/features/caller_id/presentation/pages/caller_id_settings_page.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/presentation/pages/time_interceptor_settings_page.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/pages/blocked_calls_page.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/pages/call_statistics_page.dart';
import 'package:yourcallyourrule/features/caller_id/presentation/pages/end_call_settings_page.dart';
import 'package:yourcallyourrule/features/contacts/pages/contact_subscription_page_with_ads.dart';
import 'package:yourcallyourrule/features/contacts/pages/contacts_management_page_with_ads.dart';
import 'package:yourcallyourrule/features/dashboard/pages/dashboard_page.dart';
import 'package:yourcallyourrule/features/deletion_proposal/pages/deletion_proposal_page.dart';
import 'package:yourcallyourrule/features/deletion_proposal/pages/proposal_detail_page.dart';
import 'package:yourcallyourrule/features/home/pages/home_page.dart';
import 'package:yourcallyourrule/features/labels/pages/label_management_page_with_ads.dart';
import 'package:yourcallyourrule/features/labels/pages/mark_phone_management_page_with_ads.dart';
import 'package:yourcallyourrule/features/notifications/pages/notifications_page.dart';
import 'package:yourcallyourrule/features/phone/pages/phone_subscription_page_refactored_with_ads.dart';
import 'package:yourcallyourrule/features/plugin/pages/plugin_management_page_with_ads.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_service_provider.dart';
import 'package:yourcallyourrule/features/rules/pages/allowed_blocked_page.dart';
import 'package:yourcallyourrule/features/rules/pages/allowed_blocked_page_with_ads.dart';
import 'package:yourcallyourrule/features/rules/pages/regex_rule_page.dart';
import 'package:yourcallyourrule/features/rules/pages/regex_rule_page_with_ads.dart';
import 'package:yourcallyourrule/features/rules/pages/rule_management_page_with_ads.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_filter_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_subscription_page_with_ads.dart';

import 'package:yourcallyourrule/features/local_filter/presentation/pages/local_filter_settings_page.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/onboarding/pages/onboarding_page.dart';
import 'package:yourcallyourrule/features/splash/splash_screen.dart';
import 'package:yourcallyourrule/features/permissions/pages/permission_management_page.dart';
import 'package:yourcallyourrule/features/permissions/pages/special_permission_page.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/pages/remote_filter_settings_page.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/pages/call_filter_settings_page.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/live_activities/presentation/pages/live_activities_test_page.dart';
import 'package:yourcallyourrule/features/call/live_activities/presentation/pages/live_notification_customization_screen.dart';



import 'package:yourcallyourrule/features/rules/pages/rule_management_page.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/search/pages/search_page.dart';
import 'package:yourcallyourrule/features/search/services/search_service.dart';
import 'package:yourcallyourrule/presentation/backup_restore/backup_restore_page.dart';
import 'package:yourcallyourrule/presentation/settings/pages/filter_settings_page.dart';
import 'package:yourcallyourrule/presentation/settings/pages/settings_page.dart';

import 'package:yourcallyourrule/features/sms/pages/sms_filter_settings_page.dart';
import 'package:yourcallyourrule/features/sms/services/sms_subscription_service.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_subscription_service.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';

import 'package:yourcallyourrule/features/sms/services/sms_filter_service.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_management_page.dart';
import 'package:yourcallyourrule/features/language/pages/language_settings_page.dart';
import 'package:yourcallyourrule/features/sync_country/widget/country_selection_widget.dart';

import 'package:yourcallyourrule/presentation/cloud/cloud_settings_page.dart';

import 'package:yourcallyourrule/presentation/device_management/device_management_page.dart';
import 'package:yourcallyourrule/presentation/plugin_test_page.dart';
import 'package:yourcallyourrule/presentation/regex_test_page.dart';
import 'package:yourcallyourrule/presentation/verification_page.dart';
import 'package:yourcallyourrule/purchase/purchase_page.dart';
import 'package:yourcallyourrule/purchase/pages/vip_exchange_page.dart';

/// 应用路由配置
/// 使用GoRouter管理全局路由表
class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // 服务依赖
  final ConfigRepository configRepository;
  final TimeInterceptorService timeInterceptorService;
  final LocalCountFilterService localCountFilterService;
  final RemoteNumberFilterService remoteNumberFilterService;
  final RemoteNumberService remoteNumberService;
  final SimSlotRuleService simSlotRuleService;
  final EnhancedCompositeFilterService enhancedCompositeFilterService;
  final SmsSubscriptionService smsSubscriptionService;
  final ContactSubscriptionService contactSubscriptionService;
  final AllowedBlockedService allowedBlockedService;
  final RegexService regexService;
  final CallFilterService callFilterService;
  final SmsFilterService smsFilterService;
  final Ref ref;
  
  // 构造函数
  AppRouter({
    required this.configRepository,
    required this.timeInterceptorService,
    required this.localCountFilterService,
    required this.remoteNumberFilterService,
    required this.remoteNumberService,
    required this.simSlotRuleService,
    required this.enhancedCompositeFilterService,
    required this.smsSubscriptionService,
    required this.contactSubscriptionService,
    required this.allowedBlockedService,
    required this.regexService,
    required this.callFilterService,
    required this.smsFilterService,
    required this.ref,
  });
  
  // 路由名称常量
  static const String timeInterceptorSettings = 'time-interceptor-settings';
  static const String localFilterSettings = 'local-filter-settings';
  static const String remoteFilterSettings = 'remote-filter-settings';
  static const String simSlotRuleSettings = 'sim-slot-rule-settings';
  static const String callFilterSettings = 'call-filter-settings';
  static const String allowedBlockedSettings = 'allowed-blocked-settings';
  static const String allowedBlockedSettingsWithAds = 'allowed-blocked-settings-with-ads';
  static const String ruleManagementSettings = 'rule-management-settings';
  static const String ruleManagementSettingsWithAds = 'rule-management-settings-with-ads';
  static const String callerIdCustomization = 'caller-id-customization';
  static const String callerIdSettings = 'caller-id-settings';
  static const String endCallSettings = 'end-call-settings';
  static const String fraudAlertSettings = 'fraud-alert-settings';
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
  static const String smsSubscriptionWithAds = 'sms-subscription-with-ads';
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
  static const String pluginManagement = 'plugin-management-with-ads';
  static const String phoneSubscription = 'phone-subscription-with-ads';
  static const String regexRule = 'regex-rule';
  static const String regexRuleWithAds = 'regex-rule-with-ads';
  static const String smsFilter = 'sms-filter';
  static const String labelManagement = 'label-management';
  static const String labelManagementWithAds = 'label-management-with-ads';
  static const String splash = 'splash';
  static const String markPhoneManagement = 'mark-phone-management';
  static const String markPhoneManagementWithAds = 'mark-phone-management-with-ads';
  static const String vipExchange = 'vip-exchange';
  static const String purchase = 'purchase';
  static const String settings = 'settings';
  static const String languageSettings = 'language-settings';
  static const String countrySyncSettings = 'country-sync-settings';
  static const String notifications = 'notifications';
  static const String liveNotificationCustomization = 'live-notification-customization';
  static const String liveActivitiesTest = 'live-activities-test';
  static const String deletionProposal = 'deletion-proposal';


  // 创建路由器
  late final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/$splash',
    routes: [
      // 启动屏幕路由
      GoRoute(
          path: '/special-permissions',
          builder: (context, state) => const SpecialPermissionPage(),
        ),
        GoRoute(
        path: '/$splash',
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      // 设置页面路由
      GoRoute(
        path: '/$settings',
        name: settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/$languageSettings',
        name: languageSettings,
        builder: (context, state) => const LanguageSettingsPage(),
      ),
      GoRoute(
        path: '/$countrySyncSettings',
        name: countrySyncSettings,
        builder: (context, state) => const CountrySelectionWidget(),
      ),
      // 主页路由
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/$purchase',
        name: purchase,
        builder: (context, state) => const PurchasePage(),
      ),
      GoRoute(
        path: '/$filterSettings',
        name: filterSettings,
        builder: (context, state) => const FilterSettingsPage(),
      ),
      
    GoRoute(
      path: '/$allowedBlockedSettings',
      name: allowedBlockedSettings,
      builder: (context, state) => const AllowedBlockedPage(),
    ),
    GoRoute(
      path: '/$allowedBlockedSettingsWithAds',
      name: allowedBlockedSettingsWithAds,
      builder: (context, state) => const AllowedBlockedPageWithAds(),
    ),
    GoRoute(
      path: '/$ruleManagementSettings',
      name: ruleManagementSettings,
      builder: (context, state) => const RuleManagementPage(),
    ),
    GoRoute(
      path: '/$ruleManagementSettingsWithAds',
      name: ruleManagementSettingsWithAds,
      builder: (context, state) => const RuleManagementPageWithAds(),
    ),

    // 搜索页面路由
    GoRoute(
      path: '/$search',
      name: search,
      builder: (context, state) {
        // 使用Riverpod获取服务
        final contactService = ref.read(contactServiceProvider);
        final labelService = ref.read(labelServiceProvider);
        final ruleManagementService = ref.read(ruleManagementServiceProvider);
        final allowedBlockedService = ref.read(allowedBlockedServiceProvider);
        final remoteNumberService = ref.read(remoteNumberServiceProvider);
        
        final searchService = SearchService(
          contactService: contactService,
          labelService: labelService,
          ruleManagementService: ruleManagementService,
          allowedBlockedService: allowedBlockedService,
          remoteNumberService: remoteNumberService,
          context: context,
        );
        
        return Consumer(
          builder: (context, ref, _) {
            return SearchPage();
          },
        );
      },
    ),

      // 来电频率拦截设置页面
      GoRoute(
        path: '/$timeInterceptorSettings',
        name: timeInterceptorSettings,
        builder: (context, state) => const TimeInterceptorSettingsPage(),
      ),
      
      // 来电显示设置页面
      GoRoute(
        path: '/$callerIdSettings',
        name: callerIdSettings,
        builder: (context, state) => const CallerIdSettingsPage(),
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
        path: '/$enhancedFilterSettings',
        name: enhancedFilterSettings,
        builder: (context, state) => Consumer(
          builder: (context, ref, _) {
            final ruleRepository = ref.watch(ruleRepositoryProvider);
            return EnhancedFilterSettingsPage(
              enhancedCompositeFilterService: enhancedCompositeFilterService,
              simSlotRuleService: simSlotRuleService,
              localCountFilterService: localCountFilterService,
              remoteNumberFilterService: remoteNumberFilterService,
              remoteNumberService: remoteNumberService,
              configRepository: configRepository,
              ruleRepository: ruleRepository,
            );
          },
        ),
      ),
        
      // 增强版组合过滤器设置页面
      GoRoute(
        path: '/$enhancedCompositeFilterSettings',
        name: enhancedCompositeFilterSettings,
        builder: (context, state) => Consumer(
          builder: (context, ref, _) {
            final ruleRepository = ref.watch(ruleRepositoryProvider);
            return EnhancedFilterSettingsPage(
              enhancedCompositeFilterService: enhancedCompositeFilterService,
              simSlotRuleService: simSlotRuleService,
              localCountFilterService: localCountFilterService,
              remoteNumberFilterService: remoteNumberFilterService,
              remoteNumberService: remoteNumberService,
              configRepository: configRepository,
              ruleRepository: ruleRepository,
            );
          },
        ),
      ),
      
      // SIM卡槽位规则设置页面
      GoRoute(
        path: '/$simSlotRuleSettings/:simSlotIndex',
        name: simSlotRuleSettings,
        builder: (context, state) {
          final simSlotIndex = int.parse(state.pathParameters['simSlotIndex'] ?? '0');
          return Consumer(
            builder: (context, ref, _) {
              final ruleRepository = ref.watch(ruleRepositoryProvider);
              return SimSlotRulePage(
                simSlotRuleService: simSlotRuleService,
                enhancedCompositeFilterService: state.extra as dynamic,
                configRepository: configRepository,
                ruleRepository: ruleRepository,
                simSlotIndex: simSlotIndex,
              );
            },
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

      GoRoute(
        path: '/$liveNotificationCustomization',
        name: liveNotificationCustomization,
        builder: (context, state) => const LiveNotificationCustomizationScreen(),
      ),
      GoRoute(
        path: '/$liveActivitiesTest',
        name: liveActivitiesTest,
        builder: (context, state) => const LiveActivitiesTestPage(),
      ),

      GoRoute(
        path: '/$deletionProposal',
        name: deletionProposal,
          builder: (context, state) => const DeletionProposalPage(),
  routes: [
    // =======================================================================
    // 【核心修正】: 添加一个用于处理详情页的子路由。
    // REASON: 这是让 `router.push('/deletion-proposal/:proposalId')` 能够工作的关键。
    // =======================================================================
    GoRoute(
      // 路径参数 `:proposalId` 会捕获 URL 中 `/deletion-proposal/` 之后的部分
      path: ':proposalId', 
      name: 'proposalDetails', // 详情页的名称
      builder: (context, state) {
        // 1. 从 `state.pathParameters` 中安全地获取 `proposalId`
        final proposalId = state.pathParameters['proposalId'];
        
        // 2. 安全检查：如果 proposalId 不存在，可以导航到一个错误页面或返回列表页
        if (proposalId == null) {
          // 理论上，如果路由匹配，这里不会是 null，但做个检查更安全
          return const DeletionProposalPage(); 
        }
        
        // 3. 构建并返回我们新创建的 `ProposalDetailPage`
        return ProposalDetailPage(proposalId: proposalId); 
      },
    ),
  ],
      ),

      // 欺诈警报设置页面
      GoRoute(
        path: '/$fraudAlertSettings',
        name: fraudAlertSettings,
        builder: (context, state) => const FraudAlertSettingsPage(),
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
        builder: (context, state) => const TestPage(title: 'PluginTest'),
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
        builder: (context, state) => const SmsSubscriptionPageWithAds(),
      ),

      // 带广告的短信订阅页面
      GoRoute(
        path: '/$smsSubscriptionWithAds',
        name: smsSubscriptionWithAds,
        builder: (context, state) => const SmsSubscriptionPageWithAds(),
      ),

      // 联系人订阅页面
      GoRoute(
        path: '/$contactSubscription',
        name: contactSubscription,
        builder: (context, state) => const ContactSubscriptionPageWithAds(),
      ),

      // 联系人管理页面
      GoRoute(
        path: '/$contactsManagement',
        name: contactsManagement,
        builder: (context, state) => const ContactsManagementPageWithAds(),
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
        builder: (context, state) => const CallHistoryPageWithTimelineWithAds(),
      ),

      // 自动更新设置页面
      GoRoute(
        path: '/$autoUpdate',
        name: autoUpdate,
        builder: (context, state) => const AutoUpdateSettingsPage(),
      ),
      
      // 通知页面
      GoRoute(
        path: '/notifications',
        name: notifications,
        builder: (context, state) => const NotificationsPage(),
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

      // 插件管理页面
      GoRoute(
        path: '/$pluginManagement',
        name: pluginManagement,
        builder: (context, state) => const PluginManagementPageWithAds(),
      ),

      // 电话订阅页面
      GoRoute(
        path: '/$phoneSubscription',
        name: phoneSubscription,
        builder: (context, state) => const PhoneSubscriptionPageRefactoredWithAds(),
      ),

      // 正则规则页面
      GoRoute(
        path: '/$regexRule',
        name: regexRule,
        builder: (context, state) => const RegexRulePage(),
      ),
      
      // 带广告的正则规则页面
      GoRoute(
        path: '/$regexRuleWithAds',
        name: regexRuleWithAds,
        builder: (context, state) => const RegexRulePageWithAds(),
      ),

      // 短信过滤页面
      GoRoute(
        path: '/$smsFilter',
        name: smsFilter,
        builder: (context, state) => const SmsFilterPage(),
      ),

      // 标签管理页面
      GoRoute(
        path: '/$labelManagement',
        name: labelManagement,
        builder: (context, state) => const LabelManagementPageWithAds(),
      ),

      // 带广告的标签管理页面
      GoRoute(
        path: '/$labelManagementWithAds',
        name: labelManagementWithAds,
        builder: (context, state) => const LabelManagementPageWithAds(),
      ),

      // 号码标记管理页面
      GoRoute(
        path: '/$markPhoneManagement',
        name: markPhoneManagement,
        builder: (context, state) => const MarkPhoneManagementPageWithAds(),
      ),
      
      // 带广告的号码标记管理页面
      GoRoute(
        path: '/$markPhoneManagementWithAds',
        name: markPhoneManagementWithAds,
        builder: (context, state) => const MarkPhoneManagementPageWithAds(),
      ),

      // VIP兑换页面
      GoRoute(
        path: '/$vipExchange',
        name: vipExchange,
        builder: (context, state) => const VipExchangePage(),
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

  // 导航到号码标记管理页面
  void navigateToMarkPhoneManagement(BuildContext context) {
    context.goNamed(markPhoneManagementWithAds);
  }

  // 导航到带广告的标签管理页面
  void navigateToLabelManagementWithAds(BuildContext context) {
    context.goNamed(labelManagementWithAds);
  }

  // 导航到带广告的号码标记管理页面
  void navigateToMarkPhoneManagementWithAds(BuildContext context) {
    context.goNamed(markPhoneManagementWithAds);
  }
}













