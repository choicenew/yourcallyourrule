import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/display_mode.dart';
import 'package:yourcallyourrule/features/caller_id/presentation/widgets/caller_id_display_mode_selector.dart';
import 'package:yourcallyourrule/features/caller_id/presentation/widgets/notification_settings_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Widget buildTestWidget({required ProviderContainer container}) {
    return UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: CallerIdDisplayModeSelector(),
          ),
        ),
      ),
    );
  }

  testWidgets('验证当未选择 Notification Mode 时，NotificationSettingsWidget 不展开显示', (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // 设置初始模式为 Overlay
    container.read(callerIdConfigProvider.notifier).setDisplayMode(DisplayMode.overlay);

    await tester.pumpWidget(buildTestWidget(container: container));
    await tester.pump();

    // 校验 NotificationSettingsWidget 未渲染在树中
    expect(find.byType(NotificationSettingsWidget), findsNothing);
  });

  testWidgets('验证选择 Notification Mode 时，NotificationSettingsWidget 动态展开并展示优化后的文案', (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // 设置模式为 Notification
    container.read(callerIdConfigProvider.notifier).setDisplayMode(DisplayMode.notification);

    await tester.pumpWidget(buildTestWidget(container: container));
    await tester.pump();

    // 校验 NotificationSettingsWidget 渲染展开
    expect(find.byType(NotificationSettingsWidget), findsOneWidget);

    // 校验优化后的新文案已出现在界面中
    expect(find.text('Show Call Notifications'), findsOneWidget);
    expect(find.text('Auto-Clear Notification'), findsOneWidget);
  });
}
