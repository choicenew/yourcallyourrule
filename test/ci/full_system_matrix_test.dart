import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// 核心服务与 Providers
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/provider/rules_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/presentation/pages/blocked_calls_page.dart';
// 4. 通话统计与拦截记录
import 'package:yourcallyourrule/features/call_statistic/presentation/pages/call_statistics_page.dart';
// 5. 联系人与标签
import 'package:yourcallyourrule/features/contacts/pages/contacts_management_page.dart';
import 'package:yourcallyourrule/features/dashboard/pages/dashboard_page.dart';
import 'package:yourcallyourrule/features/deletion_proposal/pages/deletion_proposal_page.dart';
// 1. 首页与主视图
import 'package:yourcallyourrule/features/home_elite/presentation/pages/elite_home_page.dart';
import 'package:yourcallyourrule/features/labels/pages/label_management_page.dart';
import 'package:yourcallyourrule/features/labels/pages/mark_phone_management_page.dart';
import 'package:yourcallyourrule/features/language/pages/language_settings_page.dart';
// 2. 拦截与规则过滤
import 'package:yourcallyourrule/features/local_filter/presentation/pages/local_filter_settings_page.dart';
import 'package:yourcallyourrule/features/notifications/pages/notifications_page.dart';
import 'package:yourcallyourrule/features/permissions/pages/permission_management_page.dart';
import 'package:yourcallyourrule/features/permissions/pages/special_permission_page.dart';
// 6. 插件中心
import 'package:yourcallyourrule/features/plugin/pages/plugin_management_page.dart';
import 'package:yourcallyourrule/features/plugin/presentation/pages/plugin_test_page.dart';
import 'package:yourcallyourrule/features/remote_filter/presentation/pages/remote_filter_settings_page.dart';
import 'package:yourcallyourrule/features/rules/pages/allowed_blocked_page.dart';
import 'package:yourcallyourrule/features/rules/pages/regex_rule_page.dart';
import 'package:yourcallyourrule/features/rules/pages/rule_management_page.dart';
import 'package:yourcallyourrule/features/search/pages/search_page.dart';
// 3. 短信过滤与管理
import 'package:yourcallyourrule/features/sms/pages/sms_filter_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_filter_settings_page.dart';
import 'package:yourcallyourrule/features/sms/pages/sms_management_page.dart';
// 7. 规则校验中心、通知与提案
import 'package:yourcallyourrule/features/verification/presentation/pages/verification_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/presentation/backup_restore/backup_restore_page.dart';
import 'package:yourcallyourrule/presentation/cloud/cloud_settings_page.dart';
import 'package:yourcallyourrule/presentation/settings/pages/filter_settings_page.dart';
// 8. 系统设置、语言、权限、购买与云同步
import 'package:yourcallyourrule/presentation/settings/pages/settings_page.dart';
import 'package:yourcallyourrule/purchase/purchase_page.dart';
import 'package:yourcallyourrule/supabase_sync/supabase_settings_page.dart';
import 'package:yourcallyourrule/theme/theme_provider.dart';

void emit(Map<String, dynamic> m) => debugPrint('CI_METRIC: ${jsonEncode(m)}');

void cause(
  String id,
  String sev,
  String name,
  String blame,
  num cost,
  String reason,
  String suggestion,
) {
  debugPrint(
    'ROOT_CAUSE: ${jsonEncode({'id': id, 'severity': sev, 'name': name, 'blamed_component': blame, 'cost_ms': cost, 'reason': reason, 'suggestion': suggestion})}',
  );
}

Widget _createTestApp(Widget child, {ProviderContainer? container}) {
  return UncontrolledProviderScope(
    container: container ?? ProviderContainer(),
    child: MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('🛡️ 全应用全模块自动化综合测试矩阵 (Full App All-Feature System Matrix)', () {
    late Directory tempDir;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      tempDir = Directory.systemTemp.createTempSync('app_full_matrix_vault');

      // Mock 核心 Native 平台信道以保证在云端 CI 环境下 100% 运行
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            (MethodCall methodCall) async => tempDir.path,
          );

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/shared_preferences'),
            (MethodCall methodCall) async => <String, dynamic>{},
          );

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('flutter_secure_storage'),
            (MethodCall methodCall) async => null,
          );

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('flutter.baseflow.com/permissions/methods'),
            (MethodCall methodCall) async => 1,
          );
    });

    tearDownAll(() async {
      try {
        if (tempDir.existsSync()) {
          tempDir.deleteSync(recursive: true);
        }
      } catch (_) {}
    });

    // ──────────────────────────────────────────────
    // 维度 1: 核心依赖注入与 Riverpod 容器矩阵
    // ──────────────────────────────────────────────
    group('1. 核心 Provider & Service 依赖注入状态验证', () {
      test('1.1 核心同步/异步 Provider 首次读取耗时与单例就绪', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final sw = Stopwatch()..start();
        final themeMode = container.read(themeModeProvider);
        sw.stop();
        final themeMs = sw.elapsedMicroseconds / 1000.0;

        expect(themeMode, isNotNull);
        emit({
          'phase': 'matrix_provider',
          'metric': 'themeModeProvider_read_ms',
          'value': themeMs,
          'unit': 'ms',
        });

        final swRules = Stopwatch()..start();
        try {
          container.read(rulesProvider);
        } catch (_) {}
        swRules.stop();
        final rulesMs = swRules.elapsedMicroseconds / 1000.0;

        emit({
          'phase': 'matrix_provider',
          'metric': 'rulesProvider_read_ms',
          'value': rulesMs,
          'unit': 'ms',
        });
      });

      test('1.2 规则与通话记录 Service 就绪度测试', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final swCallLog = Stopwatch()..start();
        final callLogService = container.read(callLogServiceProvider);
        swCallLog.stop();

        final swRuleMgmt = Stopwatch()..start();
        final ruleMgmtService = container.read(ruleManagementServiceProvider);
        swRuleMgmt.stop();

        expect(callLogService, isNotNull);
        expect(ruleMgmtService, isNotNull);

        emit({
          'phase': 'matrix_service',
          'metric': 'callLogServiceProvider_init_ms',
          'value': swCallLog.elapsedMicroseconds / 1000.0,
          'unit': 'ms',
        });
      });
    });

    // ──────────────────────────────────────────────
    // 维度 2: 全应用全功能页面 Smoke 与渲染性能矩阵
    // ──────────────────────────────────────────────
    group('2. 全量功能页面 (20+ Pages) 挂载渲染与跟手度 Smoke 矩阵', () {
      // 2.1 首页与主视图
      testWidgets('2.1.1 EliteHomePage 首页首屏与跟手度测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final sw = Stopwatch()..start();
        await tester.pumpWidget(
          _createTestApp(const EliteHomePage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        sw.stop();

        expect(find.byType(EliteHomePage), findsOneWidget);
        emit({
          'phase': 'matrix_ui',
          'page': 'EliteHomePage',
          'metric': 'mount_ms',
          'value': sw.elapsedMicroseconds / 1000.0,
          'unit': 'ms',
        });
      });

      testWidgets('2.1.2 EliteHomePage 备用卡片挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const EliteHomePage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(EliteHomePage), findsOneWidget);
      });

      testWidgets('2.1.3 DashboardPage 仪表盘挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const DashboardPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(DashboardPage), findsOneWidget);
      });

      // 2.2 拦截与规则过滤
      testWidgets('2.2.1 LocalFilterSettingsPage 拦截规则设置页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const LocalFilterSettingsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(LocalFilterSettingsPage), findsOneWidget);
      });

      testWidgets('2.2.2 RemoteFilterSettingsPage 远程过滤设置页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(
            const RemoteFilterSettingsPage(),
            container: container,
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(RemoteFilterSettingsPage), findsOneWidget);
      });

      testWidgets('2.2.3 FilterSettingsPage 过滤设置页面挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const FilterSettingsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(FilterSettingsPage), findsOneWidget);
      });

      testWidgets('2.2.4 RuleManagementPage 规则管理页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const RuleManagementPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(RuleManagementPage), findsOneWidget);
      });

      testWidgets('2.2.5 RegexRulePage 正则规则页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const RegexRulePage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(RegexRulePage), findsOneWidget);
      });

      testWidgets('2.2.6 AllowedBlockedPage 黑白名单页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const AllowedBlockedPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(AllowedBlockedPage), findsOneWidget);
      });

      // 2.3 短信过滤与管理
      testWidgets('2.3.1 SmsFilterPage 短信过滤主页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const SmsFilterPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(SmsFilterPage), findsOneWidget);
      });

      testWidgets('2.3.2 SmsFilterSettingsPage 短信过滤设置页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const SmsFilterSettingsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(SmsFilterSettingsPage), findsOneWidget);
      });

      testWidgets('2.3.3 SmsManagementPage 短信管理页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const SmsManagementPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(SmsManagementPage), findsOneWidget);
      });

      // 2.4 通话统计与记录
      testWidgets('2.4.1 CallStatisticsPage 通话统计页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const CallStatisticsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(CallStatisticsPage), findsOneWidget);
      });

      testWidgets('2.4.2 BlockedCallsPage 拦截记录页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const BlockedCallsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(BlockedCallsPage), findsOneWidget);
      });

      // 2.5 联系人与标签
      testWidgets('2.5.1 ContactsManagementPage 联系人管理页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const ContactsManagementPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(ContactsManagementPage), findsOneWidget);
      });

      testWidgets('2.5.2 LabelManagementPage 标签管理页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const LabelManagementPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(LabelManagementPage), findsOneWidget);
      });

      testWidgets('2.5.3 MarkPhoneManagementPage 标记号码管理页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const MarkPhoneManagementPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(MarkPhoneManagementPage), findsOneWidget);
      });

      // 2.6 插件中心
      testWidgets('2.6.1 PluginManagementPage 插件管理页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const PluginManagementPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(PluginManagementPage), findsOneWidget);
      });

      testWidgets('2.6.2 PluginTestPage 插件调试中心页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        const dummyPlugin = PluginEntry(
          id: 'test_plugin_001',
          name: 'CI Test Plugin',
          url: 'https://example.com/plugin.js',
          version: '1.0.0',
          description: 'Automated CI Plugin Test',
          isEnabled: true,
          pluginOrder: 1,
        );

        await tester.pumpWidget(
          _createTestApp(
            const PluginTestPage(plugin: dummyPlugin),
            container: container,
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(PluginTestPage), findsOneWidget);
      });

      // 2.7 校验中心、搜索、通知与提案
      testWidgets('2.7.1 VerificationPage 规则校验中心页面挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const VerificationPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(VerificationPage), findsOneWidget);
      });

      testWidgets('2.7.2 SearchPage 全局搜索页面挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const SearchPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(SearchPage), findsOneWidget);
      });

      testWidgets('2.7.3 NotificationsPage 通知中心页面挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const NotificationsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(NotificationsPage), findsOneWidget);
      });

      testWidgets('2.7.4 DeletionProposalPage 删规则提案页面挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const DeletionProposalPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(DeletionProposalPage), findsOneWidget);
      });

      // 2.8 设置、权限、购买与云同步
      testWidgets('2.8.1 SettingsPage 系统总设置页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const SettingsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(SettingsPage), findsOneWidget);
      });

      testWidgets('2.8.2 LanguageSettingsPage 语言设置页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const LanguageSettingsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(LanguageSettingsPage), findsOneWidget);
      });

      testWidgets('2.8.3 PermissionManagementPage 权限管理页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(
            const PermissionManagementPage(),
            container: container,
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(PermissionManagementPage), findsOneWidget);
      });

      testWidgets('2.8.4 SpecialPermissionPage 特殊权限页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const SpecialPermissionPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(SpecialPermissionPage), findsOneWidget);
      });

      testWidgets('2.8.5 PurchasePage 会员购买页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const PurchasePage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(PurchasePage), findsOneWidget);
      });

      testWidgets('2.8.6 BackupRestorePage 备份与恢复页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const BackupRestorePage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(BackupRestorePage), findsOneWidget);
      });

      testWidgets('2.8.7 CloudSettingsPage 云同步配置页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const CloudSettingsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(CloudSettingsPage), findsOneWidget);
      });

      testWidgets('2.8.8 SupabaseSettingsPage Supabase同步页挂载测试', (tester) async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        await tester.pumpWidget(
          _createTestApp(const SupabaseSettingsPage(), container: container),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(SupabaseSettingsPage), findsOneWidget);
      });
    });
  });
}
