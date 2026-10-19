import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/features/onboarding/services/onboarding_service.dart';
import 'package:yourcallyourrule/features/initial_setup/services/initial_setup_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding 与 InitialSetup 多类型兼容与持久化深度校验测试', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('1. 默认状态下 firstLaunch 为 true, hasCompletedInitialSetup 为 false', () async {
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppPrefsKeys.firstLaunch) ?? true, isTrue);
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false, isFalse);
    });

    test('2. 通过 OnboardingService 完成 Onboarding 正确同步 firstLaunch=false 与 hasCompletedInitialSetup=false', () async {
      final service = OnboardingService();
      
      final result = await service.completeOnboarding();
      expect(result, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppPrefsKeys.firstLaunch), isFalse);
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false, isFalse);
    });

    test('3. 状态判定与强类型读取接口一致性', () async {
      final onboardingService = OnboardingService();
      final initialSetupService = InitialSetupService();

      await onboardingService.completeOnboarding();
      expect(await onboardingService.isOnboardingCompleted(), isTrue);
      expect(await onboardingService.hasCompletedInitialSetup(), isFalse);

      await initialSetupService.completeInitialSetup();
      expect(await onboardingService.hasCompletedInitialSetup(), isTrue);
      expect(await initialSetupService.isInitialSetupCompleted(), isTrue);
    });
  });
}
