import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/initial_setup/pages/initial_setup_page.dart';
import 'package:yourcallyourrule/features/initial_setup/widgets/initial_setup_bottom_bar.dart';
import 'package:yourcallyourrule/features/onboarding/pages/onboarding_page.dart';
import 'package:yourcallyourrule/features/splash/splash_screen.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('连贯全流程真实 E2E 视图集成测试 (Splash -> Onboarding 交互 -> InitialSetup 交互 -> Home -> 重启检验)', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('连贯交互链：从 Splash 启动，在 UI 上逐页点击 Onboarding 和 InitialSetup，进入主页后重启验证直达主页', (tester) async {
      final prefs = await SharedPreferences.getInstance();

      Widget buildTestApp() {
        return ProviderScope(
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: GoRouter(
              initialLocation: '/splash',
              routes: [
                GoRoute(
                  path: '/splash',
                  name: AppRouter.splash,
                  builder: (context, state) => const SplashScreen(),
                ),
                GoRoute(
                  path: '/onboarding',
                  name: AppRouter.onboarding,
                  builder: (context, state) => const OnboardingPage(),
                ),
                GoRoute(
                  path: '/initial-setup',
                  name: AppRouter.initialSetup,
                  builder: (context, state) => const InitialSetupPage(),
                ),
                GoRoute(
                  path: '/',
                  name: AppRouter.home,
                  builder: (context, state) => const Scaffold(body: Text('HOME_PAGE_TARGET')),
                ),
              ],
            ),
          ),
        );
      }

      // --- 阶段一：全新启动 Splash ---
      await tester.pumpWidget(buildTestApp());
      await tester.pump(const Duration(milliseconds: 1600));
      await tester.pumpAndSettle();

      // 验证自动由 Splash 导航到了 OnboardingPage
      expect(find.byType(OnboardingPage), findsOneWidget);

      // --- 阶段二：真实模拟用户在 Onboarding 界面上点击跳过 ---
      final textButtons = find.byType(TextButton);
      expect(textButtons, findsWidgets);
      await tester.tap(textButtons.first);
      await tester.pumpAndSettle();

      // 验证 OnboardingPage 在点击后，路由自动导航到了 InitialSetupPage
      expect(find.byType(InitialSetupPage), findsOneWidget);
      // 验证 OnboardingPage 完成后，firstLaunch 已被真实保存为 false
      expect(prefs.getBool(AppPrefsKeys.firstLaunch), isFalse);

      // --- 阶段三：真实模拟用户在 InitialSetup 界面上点击跳过 ---
      final bottomBarTextButtons = find.descendant(
        of: find.byType(InitialSetupBottomBar),
        matching: find.byType(TextButton),
      );
      expect(bottomBarTextButtons, findsOneWidget);
      await tester.tap(bottomBarTextButtons);
      await tester.pumpAndSettle();

      // 验证 InitialSetup 通关后，路由进入主页 HOME_PAGE_TARGET
      expect(find.text('HOME_PAGE_TARGET'), findsOneWidget);
      // 验证 InitialSetup 完成后，hasCompletedInitialSetup 已被真实保存为 true
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup), isTrue);

      // --- 阶段四：重启 App（重新启动 SplashScreen，保持相同的 SharedPreferences mock 数据）---
      await tester.pumpWidget(buildTestApp());
      await tester.pump(const Duration(milliseconds: 1600));
      await tester.pumpAndSettle();

      // 验证再次启动时，Splash 读取到 firstLaunch=false 且 hasCompletedInitialSetup=true，直达 HOME_PAGE_TARGET
      expect(find.text('HOME_PAGE_TARGET'), findsOneWidget);
      // 断言绝不弹出 OnboardingPage 或 InitialSetupPage
      expect(find.byType(OnboardingPage), findsNothing);
      expect(find.byType(InitialSetupPage), findsNothing);
    });
  });
}
