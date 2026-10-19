import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/onboarding/services/onboarding_service.dart';
import 'package:yourcallyourrule/features/initial_setup/services/initial_setup_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding 与 InitialSetup 多类型兼容与持久化深度校验测试', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('1. 默认状态下 firstLaunch 为 true, hasCompletedInitialSetup 为 false', () async {
      final configRepo = SharedPreferencesConfigRepository();
      final onboardingConfig = await configRepo.getConfig(AppPrefsKeys.firstLaunch);
      final setupConfig = await configRepo.getConfig(AppPrefsKeys.hasCompletedInitialSetup);

      expect(onboardingConfig?['completed'] == true, isFalse);
      expect(setupConfig?['completed'] == true, isFalse);
    });

    test('2. 通过 OnboardingService 完成 Onboarding 正确同步 firstLaunch=false 与 hasCompletedInitialSetup=false', () async {
      final configRepo = SharedPreferencesConfigRepository();
      final service = OnboardingService(configRepo);
      
      final result = await service.completeOnboarding();
      expect(result, isTrue);

      final onboardingConfig = await configRepo.getConfig(AppPrefsKeys.firstLaunch);
      final setupConfig = await configRepo.getConfig(AppPrefsKeys.hasCompletedInitialSetup);

      expect(onboardingConfig?['completed'] == true, isTrue);
      expect(setupConfig?['completed'] == true, isFalse);
    });

    test('3. 状态判定与强类型读取接口一致性', () async {
      final configRepo = SharedPreferencesConfigRepository();
      final onboardingService = OnboardingService(configRepo);
      final initialSetupService = InitialSetupService(configRepository: configRepo);

      await onboardingService.completeOnboarding();
      expect(await onboardingService.isOnboardingCompleted(), isTrue);
      expect(await onboardingService.hasCompletedInitialSetup(), isFalse);

      await initialSetupService.completeInitialSetup();
      expect(await onboardingService.hasCompletedInitialSetup(), isTrue);
      expect(await initialSetupService.isInitialSetupCompleted(), isTrue);
    });
  });
}
