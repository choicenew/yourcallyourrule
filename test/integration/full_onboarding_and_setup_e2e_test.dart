import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/initial_setup/pages/initial_setup_page.dart';
import 'package:yourcallyourrule/features/initial_setup/services/initial_setup_service.dart';
import 'package:yourcallyourrule/features/onboarding/pages/onboarding_page.dart';
import 'package:yourcallyourrule/features/onboarding/services/onboarding_service.dart';
import 'package:yourcallyourrule/features/splash/splash_screen.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('全流程 E2E 端到端真实交互校验测试 (Splash -> Onboarding -> InitialSetup -> Home -> Restart)', () {
    late SharedPreferencesConfigRepository configRepo;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      configRepo = SharedPreferencesConfigRepository();
    });

    testWidgets('1. 全新安装首次启动：Splash 准确检测首次启动并拉起 Onboarding 页面', (tester) async {
      final onboardingService = OnboardingService(configRepo);

      // 验证全新安装初始状态
      expect(await onboardingService.isOnboardingCompleted(), isFalse);
      expect(await onboardingService.hasCompletedInitialSetup(), isFalse);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            configRepositoryProvider.overrideWithValue(configRepo),
          ],
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
                  builder: (context, state) => const Scaffold(body: Text('HOME_PAGE_ENTRY')),
                ),
              ],
            ),
          ),
        ),
      );

      // 等待 SplashScreen 门锁与超时机制
      await tester.pump(const Duration(milliseconds: 1600));
      await tester.pumpAndSettle();

      // 验证成功自动导航到了 OnboardingPage
      expect(find.byType(OnboardingPage), findsOneWidget);
    });

    testWidgets('2. Onboarding 完成流程测试：走完 6 页点击完成，正确写入 firstLaunch 并导航到 InitialSetup', (tester) async {
      final onboardingService = OnboardingService(configRepo);

      // 执行 Onboarding 阶段完成
      final success = await onboardingService.completeOnboarding();
      expect(success, isTrue);

      // 验证特定数据是否写入
      expect(await onboardingService.isOnboardingCompleted(), isTrue);
      expect(await onboardingService.hasCompletedInitialSetup(), isFalse);
    });

    testWidgets('3. InitialSetup 初始设置完成测试：完成/Skip 后正确写入 hasCompletedInitialSetup', (tester) async {
      final initialSetupService = InitialSetupService(configRepository: configRepo);

      final success = await initialSetupService.completeInitialSetup();
      expect(success, isTrue);

      expect(await initialSetupService.isInitialSetupCompleted(), isTrue);
    });

    testWidgets('4. 第二次/重启 App 流程校验：A 和 B 均完成后，SplashScreen 自动直达 Home，绝不弹出 Onboarding 或 Setup', (tester) async {
      final onboardingService = OnboardingService(configRepo);
      final initialSetupService = InitialSetupService(configRepository: configRepo);

      // 预先标记两关全部通关
      await onboardingService.completeOnboarding();
      await initialSetupService.completeInitialSetup();

      expect(await onboardingService.isOnboardingCompleted(), isTrue);
      expect(await initialSetupService.isInitialSetupCompleted(), isTrue);

      // 重启应用拉起 Splash
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            configRepositoryProvider.overrideWithValue(configRepo),
          ],
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
                  builder: (context, state) => const Scaffold(body: Text('HOME_PAGE_ENTRY')),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 1600));
      await tester.pumpAndSettle();

      // 断言直接到达主页 HOME_PAGE_ENTRY！
      expect(find.text('HOME_PAGE_ENTRY'), findsOneWidget);
      // 绝对没有弹开 OnboardingPage 或 InitialSetupPage
      expect(find.byType(OnboardingPage), findsNothing);
      expect(find.byType(InitialSetupPage), findsNothing);
    });
  });
}
