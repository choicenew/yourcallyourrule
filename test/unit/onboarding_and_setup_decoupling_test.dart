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

    test('2. 通过 OnboardingService 完成 Onboarding 正确记录 hasCompletedOnboarding=true', () async {
      final service = OnboardingService();
      
      final result = await service.completeOnboarding();
      expect(result, isTrue);

      expect(await service.isOnboardingCompleted(), isTrue);
      final initialSetupService = InitialSetupService();
      expect(await initialSetupService.isInitialSetupCompleted(), isFalse);
    });

    test('3. 状态判定与强类型读取接口一致性（各自管各自，完全解耦）', () async {
      final onboardingService = OnboardingService();
      final initialSetupService = InitialSetupService();

      expect(await onboardingService.isOnboardingCompleted(), isFalse);
      expect(await initialSetupService.isInitialSetupCompleted(), isFalse);

      await onboardingService.completeOnboarding();
      expect(await onboardingService.isOnboardingCompleted(), isTrue);
      expect(await initialSetupService.isInitialSetupCompleted(), isFalse);

      await initialSetupService.completeInitialSetup();
      expect(await onboardingService.isOnboardingCompleted(), isTrue);
      expect(await initialSetupService.isInitialSetupCompleted(), isTrue);
    });

    test('4. 兼容旧版 ConfigRepository 保存的 JSON 完成标记', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('config_has_completed_onboarding', '{"value":true}');
      await prefs.setString('config_has_completed_initial_setup', '{"value":true}');

      expect(await OnboardingService().isOnboardingCompleted(), isTrue);
      expect(await InitialSetupService().isInitialSetupCompleted(), isTrue);
    });
  });
}
