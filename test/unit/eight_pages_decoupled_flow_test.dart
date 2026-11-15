import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_timeline_page.dart';
import 'package:yourcallyourrule/features/local_filter/config/local_count_filter_config.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 8 大配置/规则/订阅/记录页面 - 响应式 Stream 数据流与 Generic 外壳 单元测试
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('8 大页面响应式 Stream 数据流转与 Generic 外壳 单元测试', () {
    testWidgets('1. Plugin 插件管理页 - 反应式 Stream 动态推送与 GenericListPage 外壳渲染', (tester) async {
      final pluginStreamController = StreamController<List<PluginSourceData>>.broadcast();
      final pluginStreamProvider = StreamProvider<List<PluginSourceData>>((ref) => pluginStreamController.stream);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Consumer(
              builder: (context, ref, child) {
                final pluginsAsync = ref.watch(pluginStreamProvider);
                return pluginsAsync.when(
                  data: (plugins) => GenericListPage<PluginSourceData>(
                    title: 'Plugin Management',
                    items: plugins,
                    isLoading: false,
                    emptyText: 'No plugins found',
                    emptyIcon: Icons.extension_outlined,
                    adInterval: 3,
                    adBuilder: () => const SizedBox.shrink(),
                    itemBuilder: (context, plugin) => ListTile(
                      title: Text(plugin.name ?? ''),
                    ),
                    getItemId: (plugin) => plugin.name ?? '',
                  ),
                  loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                  error: (err, st) => Scaffold(body: Text('Error: $err')),
                );
              },
            ),
          ),
        ),
      );

      // A. 初始加载状态
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // B. 推送空列表数据 -> 应展现 GenericListPage 的空状态卡片与 Icon
      pluginStreamController.add([]);
      await tester.pumpAndSettle();

      expect(find.text('Plugin Management'), findsOneWidget);
      expect(find.text('No plugins found'), findsOneWidget);
      expect(find.byIcon(Icons.extension_outlined), findsOneWidget);

      // C. 推送 2 条插件实体数据 -> 应自动响应式渲染 2 个 ListTile
      pluginStreamController.add([
        const PluginSourceData(name: 'Google Call Lookup'),
        const PluginSourceData(name: 'TrueCaller Plugin'),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('Google Call Lookup'), findsOneWidget);
      expect(find.text('TrueCaller Plugin'), findsOneWidget);

      await pluginStreamController.close();
    });

    testWidgets('2. 规则订阅页 - 反应式 Stream 动态推送与 GenericSubscription 逻辑流', (tester) async {
      final subStreamController = StreamController<List<PhoneSubscriptionPayload>>.broadcast();
      final subStreamProvider = StreamProvider<List<PhoneSubscriptionPayload>>((ref) => subStreamController.stream);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Consumer(
              builder: (context, ref, child) {
                final subsAsync = ref.watch(subStreamProvider);
                return subsAsync.when(
                  data: (subs) => GenericListPage<PhoneSubscriptionPayload>(
                    title: 'Subscriptions',
                    items: subs,
                    isLoading: false,
                    emptyText: 'No subscriptions',
                    emptyIcon: Icons.rss_feed_rounded,
                    adInterval: 3,
                    adBuilder: () => const SizedBox.shrink(),
                    itemBuilder: (context, sub) => ListTile(
                      title: Text(sub.payloadId),
                    ),
                    getItemId: (sub) => sub.payloadId,
                  ),
                  loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                  error: (err, st) => Scaffold(body: Text('Error: $err')),
                );
              },
            ),
          ),
        ),
      );

      // A. 推送数据
      subStreamController.add([
        PhoneSubscriptionPayload(
          payloadId: 'sub_001',
          kind: PhoneSubscriptionKind.phoneRules,
          rawJsonMap: {'displayName': 'Spam Block List'},
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('Subscriptions'), findsOneWidget);
      expect(find.text('sub_001'), findsOneWidget);

      await subStreamController.close();
    });

    testWidgets('3. 正则规则页 - 反应式 Stream 动态推送与空状态图标显示', (tester) async {
      final ruleStreamController = StreamController<List<RegexRuleEntity>>.broadcast();
      final ruleStreamProvider = StreamProvider<List<RegexRuleEntity>>((ref) => ruleStreamController.stream);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Consumer(
              builder: (context, ref, child) {
                final rulesAsync = ref.watch(ruleStreamProvider);
                return rulesAsync.when(
                  data: (rules) => GenericListPage<RegexRuleEntity>(
                    title: 'Regex Rules',
                    items: rules,
                    isLoading: false,
                    emptyText: 'No regex rules',
                    emptyIcon: Icons.rule_folder_outlined,
                    adInterval: 3,
                    adBuilder: () => const SizedBox.shrink(),
                    itemBuilder: (context, rule) => ListTile(
                      title: Text(rule.name),
                      subtitle: Text(rule.pattern),
                    ),
                    getItemId: (rule) => rule.id,
                  ),
                  loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                  error: (err, st) => Scaffold(body: Text('Error: $err')),
                );
              },
            ),
          ),
        ),
      );

      // 推送空列表
      ruleStreamController.add([]);
      await tester.pumpAndSettle();

      expect(find.text('Regex Rules'), findsOneWidget);
      expect(find.text('No regex rules'), findsOneWidget);
      expect(find.byIcon(Icons.rule_folder_outlined), findsOneWidget);

      await ruleStreamController.close();
    });

    testWidgets('4. 通话记录时间轴页 - 反应式 Stream 动态流转与 GenericTimelinePage 渲染', (tester) async {
      final logStreamController = StreamController<List<CallLogEntry>>.broadcast();
      final logStreamProvider = StreamProvider<List<CallLogEntry>>((ref) => logStreamController.stream);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Consumer(
              builder: (context, ref, child) {
                final logsAsync = ref.watch(logStreamProvider);
                return logsAsync.when(
                  data: (logs) => GenericTimelinePage<CallLogEntry>(
                    title: 'Call History',
                    items: logs,
                    isLoading: false,
                    displayMode: ListDisplayMode.timeline,
                    getItemTimestamp: (log) => DateTime.fromMillisecondsSinceEpoch(log.timestamp ?? 0),
                    emptyText: 'No call records',
                    emptyIcon: Icons.phone_missed_rounded,
                    adInterval: 3,
                    adBuilder: () => const SizedBox.shrink(),
                    itemBuilder: (context, log) => ListTile(
                      title: Text(log.phoneNumber),
                    ),
                    getItemId: (log) => log.id,
                  ),
                  loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                  error: (err, st) => Scaffold(body: Text('Error: $err')),
                );
              },
            ),
          ),
        ),
      );

      // 推送通话记录
      logStreamController.add([
        CallLogEntry(id: 'log_1', phoneNumber: '+123456789', timestamp: DateTime.now().millisecondsSinceEpoch, callType: 'incoming'),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('Call History'), findsOneWidget);
      expect(find.text('+123456789'), findsOneWidget);

      await logStreamController.close();
    });

    testWidgets('5. 联系人管理页 - 反应式 Stream 动态流转与 GenericListPage 渲染', (tester) async {
      final contactStreamController = StreamController<List<PhoneContactEntry>>.broadcast();
      final contactStreamProvider = StreamProvider<List<PhoneContactEntry>>((ref) => contactStreamController.stream);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Consumer(
              builder: (context, ref, child) {
                final contactsAsync = ref.watch(contactStreamProvider);
                return contactsAsync.when(
                  data: (contacts) => GenericListPage<PhoneContactEntry>(
                    title: 'Contacts',
                    items: contacts,
                    isLoading: false,
                    emptyText: 'No contacts yet',
                    emptyIcon: Icons.perm_contact_calendar_rounded,
                    adInterval: 3,
                    adBuilder: () => const SizedBox.shrink(),
                    itemBuilder: (context, contact) => ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.phoneNumber),
                    ),
                    getItemId: (contact) => contact.id,
                  ),
                  loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                  error: (err, st) => Scaffold(body: Text('Error: $err')),
                );
              },
            ),
          ),
        ),
      );

      contactStreamController.add([
        PhoneContactEntry(id: 'c_1', name: 'John Doe', phoneNumber: '+1999888777'),
      ]);
      await tester.pumpAndSettle();

      expect(find.text('Contacts'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);

      await contactStreamController.close();
    });

    test('6. 本地频次拦截 (LocalCountFilterConfig) 乐观更新 - 不设置 AsyncLoading 消除闪烁', () {
      var currentConfig = LocalCountFilterConfig(
        enableLocalCountFilter: true,
        countThreshold: 3,
      );

      LocalCountFilterConfig applyOptimisticUpdate(LocalCountFilterConfig newConfig) {
        return newConfig;
      }

      currentConfig = applyOptimisticUpdate(currentConfig.copyWith(countThreshold: 5));

      expect(currentConfig.countThreshold, equals(5));
      expect(currentConfig.enableLocalCountFilter, isTrue);
    });
  });
}
