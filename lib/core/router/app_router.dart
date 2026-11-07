import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// === All Package Protocols & Models ===
import 'package:pyro_phone_country_sync_protocol/pyro_phone_country_sync_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_time_interceptor_protocol/pyro_time_interceptor_protocol.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:pyro_phone_count_filter_protocol/pyro_phone_count_filter_protocol.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:pyro_sim_slot_rules_protocol/pyro_sim_slot_rules_protocol.dart';
import 'package:pyro_phone_call_overlay_protocol/pyro_phone_call_overlay_protocol.dart';
import 'package:pyro_phone_live_activities_protocol/pyro_phone_live_activities_protocol.dart';
import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_call_statistic_protocol/pyro_phone_call_statistic_protocol.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_app_auto_update_protocol/pyro_app_auto_update_protocol.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';

// === All Package UI Exports ===
import 'package:pyro_phone_lookup_plugin_ui/pyro_phone_lookup_plugin_ui.dart';
import 'package:pyro_phone_rules_ui/pyro_phone_rules_ui.dart';
import 'package:pyro_phone_count_filter_ui/pyro_phone_count_filter_ui.dart';
import 'package:pyro_phone_remote_filter_ui/pyro_phone_remote_filter_ui.dart';
import 'package:pyro_phone_call_history_ui/pyro_phone_call_history_ui.dart';
import 'package:pyro_phone_live_activities_ui/pyro_phone_live_activities_ui.dart';
import 'package:pyro_phone_call_overlay_ui/pyro_phone_call_overlay_ui.dart';
import 'package:pyro_phone_call_statistic_ui/pyro_phone_call_statistic_ui.dart';
import 'package:pyro_phone_country_sync_ui/pyro_phone_country_sync_ui.dart';
import 'package:pyro_phone_contacts_ui/pyro_phone_contacts_ui.dart';
import 'package:pyro_app_auto_update_ui/pyro_app_auto_update_ui.dart';
import 'package:pyro_caller_identity_ui/pyro_caller_identity_ui.dart';
import 'package:pyro_deletion_proposal_ui/pyro_deletion_proposal_ui.dart';
import 'package:pyro_time_interceptor_ui/pyro_time_interceptor_ui.dart';
import 'package:pyro_sim_slot_rules_ui/pyro_sim_slot_rules_ui.dart';

// === App Core Pages ===
import 'package:yourcallyourrule/features/splash/splash_screen.dart';
import 'package:yourcallyourrule/features/home/pages/home_page.dart';
import 'package:yourcallyourrule/features/home_elite/presentation/pages/elite_home_page.dart';
import 'package:yourcallyourrule/presentation/settings/pages/settings_page.dart';
import 'package:yourcallyourrule/presentation/about.dart';
import 'package:yourcallyourrule/features/permissions/pages/special_permission_page.dart';
import 'package:yourcallyourrule/features/language/pages/language_settings_page.dart';
import 'package:yourcallyourrule/purchase/purchase_page.dart';
import 'package:yourcallyourrule/features/search/pages/search_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_filter_settings_page.dart';
import 'package:yourcallyourrule/presentation/backup_restore/backup_restore_page.dart';
import 'package:yourcallyourrule/presentation/cloud/cloud_settings_page.dart';
import 'package:yourcallyourrule/presentation/device_management/device_management_page.dart';
import 'package:yourcallyourrule/features/verification/presentation/pages/verification_page.dart';
import 'package:yourcallyourrule/presentation/plugin_test_page.dart';
import 'package:yourcallyourrule/presentation/regex_test_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_management_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_subscription_page_with_ads.dart';
import 'package:yourcallyourrule/features/notifications/pages/notifications_page.dart';
import 'package:yourcallyourrule/features/permissions/pages/permission_management_page.dart';
import 'package:yourcallyourrule/features/onboarding/pages/onboarding_page.dart';
import 'package:yourcallyourrule/features/dashboard/pages/dashboard_page.dart';
import 'package:yourcallyourrule/features/phone/pages/phone_subscription_page_refactored_with_ads.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_filter_page.dart';
import 'package:yourcallyourrule/features/labels/pages/label_management_page_with_ads.dart';
import 'package:yourcallyourrule/features/labels/pages/mark_phone_management_page_with_ads.dart';
import 'package:yourcallyourrule/purchase/pages/vip_exchange_page.dart';
import 'package:yourcallyourrule/supabase_sync/supabase_settings_page.dart';
import 'package:yourcallyourrule/features/initial_setup/pages/initial_setup_page.dart';
import 'package:yourcallyourrule/features/initial_setup/pages/deep_link_import_page.dart';

/// 应用路由配置
class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void navigateToTab(BuildContext context, int index) {
    final route = switch (index) {
      0 => '/',
      1 => '/$callHistory',
      2 => '/$contactsManagement',
      3 => '/$dashboard',
      4 => '/$settings',
      _ => null,
    };
    if (route != null) {
      context.go(route);
    }
  }

  AppRouter();

  static const String timeInterceptorSettings = 'time-interceptor-settings';
  static const String localFilterSettings = 'local-filter-settings';
  static const String remoteFilterSettings = 'remote-filter-settings';
  static const String simSlotRuleSettings = 'sim-slot-rule-settings';
  static const String simSlotRuleWithAds = 'sim-slot-rule-with-ads';
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
  static const String about = 'about';
  static const String languageSettings = 'language-settings';
  static const String countrySyncSettings = 'country-sync-settings';
  static const String notifications = 'notifications';
  static const String liveNotificationCustomization = 'live-notification-customization';
  static const String liveActivitiesTest = 'live-activities-test';
  static const String kitLiveActivitiesTest = 'kit-live-activities-test';
  static const String kitLiveNotificationCustomization = 'kit-live-notification-customization';
  static const String deletionProposal = 'deletion-proposal';
  static const String supabaseSettings = 'supabase-settings';
  static const String eliteHome = 'elite-home';
  static const String proHome = 'pro-home';
  static const String specialPermissions = 'special-permissions';
  static const String initialSetup = 'initial-setup';
  static const String externalImport = 'import';

  late final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/$splash',
    routes: [
      GoRoute(
        path: '/$specialPermissions',
        name: specialPermissions,
        builder: (context, state) => const SpecialPermissionPage(),
      ),
      GoRoute(
        path: '/$splash',
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),
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
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Country Sync')),
          body: const CountrySyncTileView(payload: CountrySyncPayload(countryIsoCode: 'CN')),
        ),
      ),
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) => const EliteHomePage(),
      ),
      GoRoute(
        path: '/$proHome',
        name: proHome,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/$eliteHome',
        name: eliteHome,
        builder: (context, state) => const EliteHomePage(),
      ),
      GoRoute(
        path: '/$purchase',
        name: purchase,
        builder: (context, state) => const PurchasePage(),
      ),
      GoRoute(
        path: '/$about',
        name: about,
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: '/$allowedBlockedSettings',
        name: allowedBlockedSettings,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Phone Rules')),
          body: const PhoneRuleTileView(rule: PhoneRuleEntity(id: '1', name: 'Rule', phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$allowedBlockedSettingsWithAds',
        name: allowedBlockedSettingsWithAds,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Phone Rules')),
          body: const PhoneRuleTileView(rule: PhoneRuleEntity(id: '1', name: 'Rule', phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$ruleManagementSettings',
        name: ruleManagementSettings,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Rule Management')),
          body: const PhoneRuleTileView(rule: PhoneRuleEntity(id: '1', name: 'Rule', phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$ruleManagementSettingsWithAds',
        name: ruleManagementSettingsWithAds,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Rule Management')),
          body: const PhoneRuleTileView(rule: PhoneRuleEntity(id: '1', name: 'Rule', phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$search',
        name: search,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/$timeInterceptorSettings',
        name: timeInterceptorSettings,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Time Interceptor Settings')),
          body: const TimeInterceptorTileView(config: TimeInterceptorConfig()),
        ),
      ),
      GoRoute(
        path: '/$callerIdSettings',
        name: callerIdSettings,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Caller Identity Settings')),
          body: const CallerProfileTileView(profile: CallerProfile(phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$localFilterSettings',
        name: localFilterSettings,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Local Count Filter')),
          body: const PhoneCountFilterTileView(config: PhoneCountFilterConfig()),
        ),
      ),
      GoRoute(
        path: '/$remoteFilterSettings',
        name: remoteFilterSettings,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Remote Filter Settings')),
          body: const PhoneRemoteFilterTileView(entry: RemoteNumberEntry(id: '1', phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$enhancedFilterSettings',
        name: enhancedFilterSettings,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Call Filter Settings')),
          body: const Center(child: Text('Enhanced Filter Settings')),
        ),
      ),
      GoRoute(
        path: '/$simSlotRuleSettings/:simSlotIndex',
        name: simSlotRuleSettings,
        builder: (context, state) {
          final simSlotIndex = int.tryParse(state.pathParameters['simSlotIndex'] ?? '') ?? 0;
          return Scaffold(
            appBar: AppBar(title: Text('SIM Slot $simSlotIndex Rule')),
            body: SimSlotRuleTileView(rule: SimSlotRuleEntity(id: '1', simSlotIndex: simSlotIndex, name: 'Rule', phoneNumber: '123')),
          );
        },
      ),
      GoRoute(
        path: '/$simSlotRuleWithAds/:simSlotIndex',
        name: simSlotRuleWithAds,
        builder: (context, state) {
          final simSlotIndex = int.tryParse(state.pathParameters['simSlotIndex'] ?? '') ?? 0;
          return Scaffold(
            appBar: AppBar(title: Text('SIM Slot $simSlotIndex Rule')),
            body: SimSlotRuleTileView(rule: SimSlotRuleEntity(id: '1', simSlotIndex: simSlotIndex, name: 'Rule', phoneNumber: '123')),
          );
        },
      ),
      GoRoute(
        path: '/$callFilterSettings',
        name: callFilterSettings,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Call Filter Settings')),
          body: const Center(child: Text('Call Filter Settings')),
        ),
      ),
      GoRoute(
        path: '/$callerIdCustomization',
        name: callerIdCustomization,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Call Overlay Customization')),
          body: const PhoneOverlayTileView(config: PhoneCallOverlayConfig()),
        ),
      ),
      GoRoute(
        path: '/$liveNotificationCustomization',
        name: liveNotificationCustomization,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Live Notification Customization')),
          body: const LiveActivityTileView(record: PhoneLiveActivityRecord(activityId: '1', phoneNumber: '123', title: 'Live Activity')),
        ),
      ),
      GoRoute(
        path: '/$deletionProposal',
        name: deletionProposal,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Deletion Proposals')),
          body: const ProposalTileView(proposal: ProposalEntity(id: '1', phoneNumber: '123', reason: 'Spam')),
        ),
      ),
      GoRoute(
        path: '/$smsFilterSettings',
        name: smsFilterSettings,
        builder: (context, state) => const SmsFilterSettingsPage(),
      ),
      GoRoute(
        path: '/$backupRestore',
        name: backupRestore,
        builder: (context, state) => const BackupRestorePage(),
      ),
      GoRoute(
        path: '/$cloudSettings',
        name: cloudSettings,
        builder: (context, state) => const CloudSettingsPage(),
      ),
      GoRoute(
        path: '/$deviceManagement',
        name: deviceManagement,
        builder: (context, state) => const DeviceManagementPage(),
      ),
      GoRoute(
        path: '/$purchaseSettings',
        name: purchaseSettings,
        builder: (context, state) => const PurchasePage(),
      ),
      GoRoute(
        path: '/$verificationPage',
        name: verificationPage,
        builder: (context, state) => VerificationPage(
          initialPhoneNumber: state.extra as String?,
        ),
      ),
      GoRoute(
        path: '/$pluginTest',
        name: pluginTest,
        builder: (context, state) => const TestPage(title: 'PluginTest'),
      ),
      GoRoute(
        path: '/$regexTest',
        name: regexTest,
        builder: (context, state) => const RegexTestPage(),
      ),
      GoRoute(
        path: '/$smsManagement',
        name: smsManagement,
        builder: (context, state) => const SmsManagementPage(),
      ),
      GoRoute(
        path: '/$smsSubscription',
        name: smsSubscription,
        builder: (context, state) => const SmsSubscriptionPageWithAds(),
      ),
      GoRoute(
        path: '/$smsSubscriptionWithAds',
        name: smsSubscriptionWithAds,
        builder: (context, state) => const SmsSubscriptionPageWithAds(),
      ),
      GoRoute(
        path: '/$contactSubscription',
        name: contactSubscription,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Contacts Subscription')),
          body: const PhoneContactTileView(entry: PhoneContactEntry(id: '1', displayName: 'Contact', phoneNumbers: ['123'])),
        ),
      ),
      GoRoute(
        path: '/$contactsManagement',
        name: contactsManagement,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Contacts Management')),
          body: const PhoneContactTileView(entry: PhoneContactEntry(id: '1', displayName: 'Contact', phoneNumbers: ['123'])),
        ),
      ),
      GoRoute(
        path: '/$blockedCalls',
        name: blockedCalls,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Blocked Calls')),
          body: const PhoneCallStatisticCardView(data: PhoneCallStatisticData()),
        ),
      ),
      GoRoute(
        path: '/$callStatistics',
        name: callStatistics,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Call Statistics')),
          body: const PhoneCallStatisticCardView(data: PhoneCallStatisticData()),
        ),
      ),
      GoRoute(
        path: '/$callHistory',
        name: callHistory,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Call History')),
          body: const CallLogTileView(entry: CallLogEntry(id: '1', phoneNumber: '123', callType: 'incoming')),
        ),
      ),
      GoRoute(
        path: '/$autoUpdate',
        name: autoUpdate,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Auto Update Settings')),
          body: const AppVersionInfoTileView(info: AppVersionInfo(latestVersion: '1.0.0', versionCode: 100, downloadUrl: '')),
        ),
      ),
      GoRoute(
        path: '/notifications',
        name: notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/$permissionManagement',
        name: permissionManagement,
        builder: (context, state) => const PermissionManagementPage(),
      ),
      GoRoute(
        path: '/$onboarding',
        name: onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/$dashboard',
        name: dashboard,
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/$pluginManagement',
        name: pluginManagement,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Plugin Management')),
          body: const PhoneLookupPluginTileView(data: PluginSourceData(name: 'Lookup Plugin', phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$phoneSubscription',
        name: phoneSubscription,
        builder: (context, state) => const PhoneSubscriptionPageRefactoredWithAds(),
      ),
      GoRoute(
        path: '/$regexRule',
        name: regexRule,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Regex Rules')),
          body: const PhoneRuleTileView(rule: PhoneRuleEntity(id: '1', name: 'Regex Rule', phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$regexRuleWithAds',
        name: regexRuleWithAds,
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Regex Rules')),
          body: const PhoneRuleTileView(rule: PhoneRuleEntity(id: '1', name: 'Regex Rule', phoneNumber: '123')),
        ),
      ),
      GoRoute(
        path: '/$smsFilter',
        name: smsFilter,
        builder: (context, state) => const SmsFilterPage(),
      ),
      GoRoute(
        path: '/$labelManagement',
        name: labelManagement,
        builder: (context, state) => const LabelManagementPageWithAds(),
      ),
      GoRoute(
        path: '/$labelManagementWithAds',
        name: labelManagementWithAds,
        builder: (context, state) => const LabelManagementPageWithAds(),
      ),
      GoRoute(
        path: '/$markPhoneManagement',
        name: markPhoneManagement,
        builder: (context, state) => const MarkPhoneManagementPageWithAds(),
      ),
      GoRoute(
        path: '/$markPhoneManagementWithAds',
        name: markPhoneManagementWithAds,
        builder: (context, state) => const MarkPhoneManagementPageWithAds(),
      ),
      GoRoute(
        path: '/$vipExchange',
        name: vipExchange,
        builder: (context, state) => const VipExchangePage(),
      ),
      GoRoute(
        path: '/supabase-settings',
        name: supabaseSettings,
        builder: (context, state) => const SupabaseSettingsPage(),
      ),
      GoRoute(
        path: '/$initialSetup',
        name: initialSetup,
        builder: (context, state) => const InitialSetupPage(),
      ),
      GoRoute(
        path: '/$externalImport',
        name: externalImport,
        builder: (context, state) => DeepLinkImportPage(
          type: state.uri.queryParameters['type'],
          url: state.uri.queryParameters['url'],
          name: state.uri.queryParameters['name'],
        ),
      ),
    ],
  );
}
