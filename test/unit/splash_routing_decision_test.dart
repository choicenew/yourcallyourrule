import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/features/onboarding/services/onboarding_service.dart';
import 'package:yourcallyourrule/features/initial_setup/services/initial_setup_service.dart';

/// 路由名称常量（直接隔离大而全的 app_router 依赖，纯粹针对路由目标标识测试）
class TestAppRouter {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String initialSetup = 'initial-setup';
  static const String home = 'home';
}

/// 100% 提取自 SplashScreen._navigateToNextScreen 中的核心路由决策算法
String resolveSplashRoute({
  required bool isFirstLaunch,
  required bool isOnboardingCompleted,
  required bool isInitialSetupCompleted,
}) {
  if (isFirstLaunch && !isOnboardingCompleted) {
    return TestAppRouter.onboarding;
  } else if (!isInitialSetupCompleted) {
    return TestAppRouter.initialSetup;
  } else {
    return TestAppRouter.home;
  }
}

/// 100% 提取自 SplashScreen._checkOnboardingAndSetupStatus 中的 SharedPreferences 读取算法
Future<({bool isFirstLaunch, bool isOnboardingCompleted, bool isInitialSetupCompleted})> readSplashStatus({
  required SharedPreferences prefs,
  required OnboardingService onboardingSvc,
  required InitialSetupService initialSetupSvc,
}) async {
  final isFirst = prefs.getBool(AppPrefsKeys.firstLaunch) ?? true;
  final isCompleted = await onboardingSvc.isOnboardingCompleted();
  final isSetup = await initialSetupSvc.isInitialSetupCompleted();
  return (
    isFirstLaunch: isFirst,
    isOnboardingCompleted: isCompleted,
    isInitialSetupCompleted: isSetup,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('从 Splash 启动开始的纯逻辑状态机与路由决策独立单元测试（零 UI 依赖、零外部耦合）', () {
    late OnboardingService onboardingSvc;
    late InitialSetupService initialSetupSvc;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      onboardingSvc = OnboardingService();
      initialSetupSvc = InitialSetupService();
    });

    test('1. 全新安装初次冷启动：Splash 读取默认状态并 100% 决策前往 Onboarding', () async {
      final prefs = await SharedPreferences.getInstance();

      // Splash 启动读取
      final status = await readSplashStatus(
        prefs: prefs,
        onboardingSvc: onboardingSvc,
        initialSetupSvc: initialSetupSvc,
      );

      expect(status.isFirstLaunch, isTrue);
      expect(status.isOnboardingCompleted, isFalse);
      expect(status.isInitialSetupCompleted, isFalse);

      // Splash 决策路由
      final nextRoute = resolveSplashRoute(
        isFirstLaunch: status.isFirstLaunch,
        isOnboardingCompleted: status.isOnboardingCompleted,
        isInitialSetupCompleted: status.isInitialSetupCompleted,
      );

      expect(nextRoute, equals(TestAppRouter.onboarding));

      // Splash 离开时标记自身的 firstLaunch 为 false
      await prefs.setBool(AppPrefsKeys.firstLaunch, false);
      expect(prefs.getBool(AppPrefsKeys.firstLaunch), isFalse);
    });

    test('2. 引导完成阶段：用户走完 Onboarding，再次冷启动 Splash 决策跳过 Onboarding 直奔 Initial Setup', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppPrefsKeys.firstLaunch, false);

      // 用户在 Onboarding 页面点击完成
      final onbSuccess = await onboardingSvc.completeOnboarding();
      expect(onbSuccess, isTrue);

      // 再次冷启动进入 Splash 读取
      final status = await readSplashStatus(
        prefs: prefs,
        onboardingSvc: onboardingSvc,
        initialSetupSvc: initialSetupSvc,
      );

      expect(status.isFirstLaunch, isFalse);
      expect(status.isOnboardingCompleted, isTrue);
      expect(status.isInitialSetupCompleted, isFalse);

      // Splash 决策路由
      final nextRoute = resolveSplashRoute(
        isFirstLaunch: status.isFirstLaunch,
        isOnboardingCompleted: status.isOnboardingCompleted,
        isInitialSetupCompleted: status.isInitialSetupCompleted,
      );

      // 验证精准跳过 Onboarding，进入 Initial Setup
      expect(nextRoute, equals(TestAppRouter.initialSetup));
    });

    test('3. 全部完成阶段：引导和初始设置均完成，后续任何冷启动 Splash 决策 100% 直达 Home', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppPrefsKeys.firstLaunch, false);
      await onboardingSvc.completeOnboarding();

      // 用户在 Initial Setup 页面点击完成/跳过
      final setupSuccess = await initialSetupSvc.completeInitialSetup();
      expect(setupSuccess, isTrue);

      // 后续任何冷启动进入 Splash 读取
      final status = await readSplashStatus(
        prefs: prefs,
        onboardingSvc: onboardingSvc,
        initialSetupSvc: initialSetupSvc,
      );

      expect(status.isFirstLaunch, isFalse);
      expect(status.isOnboardingCompleted, isTrue);
      expect(status.isInitialSetupCompleted, isTrue);

      // Splash 决策路由
      final nextRoute = resolveSplashRoute(
        isFirstLaunch: status.isFirstLaunch,
        isOnboardingCompleted: status.isOnboardingCompleted,
        isInitialSetupCompleted: status.isInitialSetupCompleted,
      );

      // 验证绝不再弹 Onboarding 和 Initial Setup，直接去 Home 主页
      expect(nextRoute, equals(TestAppRouter.home));
    });

    test('4. 完整连续状态转移闭环：初次启动 -> 完成引导 -> 完成配置 -> 多次冷启动稳态', () async {
      final prefs = await SharedPreferences.getInstance();

      // === 第 1 步：初次冷启动 ===
      var s1 = await readSplashStatus(prefs: prefs, onboardingSvc: onboardingSvc, initialSetupSvc: initialSetupSvc);
      expect(resolveSplashRoute(isFirstLaunch: s1.isFirstLaunch, isOnboardingCompleted: s1.isOnboardingCompleted, isInitialSetupCompleted: s1.isInitialSetupCompleted), equals(TestAppRouter.onboarding));
      await prefs.setBool(AppPrefsKeys.firstLaunch, false);

      // === 第 2 步：完成 Onboarding ===
      await onboardingSvc.completeOnboarding();
      var s2 = await readSplashStatus(prefs: prefs, onboardingSvc: onboardingSvc, initialSetupSvc: initialSetupSvc);
      expect(resolveSplashRoute(isFirstLaunch: s2.isFirstLaunch, isOnboardingCompleted: s2.isOnboardingCompleted, isInitialSetupCompleted: s2.isInitialSetupCompleted), equals(TestAppRouter.initialSetup));

      // === 第 3 步：完成 Initial Setup ===
      await initialSetupSvc.completeInitialSetup();
      var s3 = await readSplashStatus(prefs: prefs, onboardingSvc: onboardingSvc, initialSetupSvc: initialSetupSvc);
      expect(resolveSplashRoute(isFirstLaunch: s3.isFirstLaunch, isOnboardingCompleted: s3.isOnboardingCompleted, isInitialSetupCompleted: s3.isInitialSetupCompleted), equals(TestAppRouter.home));

      // === 第 4 步：第 N 次重新打开（稳态断言，绝不发生死循环跳回 Onboarding） ===
      for (int i = 0; i < 5; i++) {
        var sN = await readSplashStatus(prefs: prefs, onboardingSvc: onboardingSvc, initialSetupSvc: initialSetupSvc);
        expect(resolveSplashRoute(isFirstLaunch: sN.isFirstLaunch, isOnboardingCompleted: sN.isOnboardingCompleted, isInitialSetupCompleted: sN.isInitialSetupCompleted), equals(TestAppRouter.home));
      }
    });
  });
}
