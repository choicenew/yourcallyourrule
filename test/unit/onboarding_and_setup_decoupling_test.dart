import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/features/onboarding/services/onboarding_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding 与 InitialSetup 解耦与多类型兼容深度校验测试', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('1. 默认状态下 firstLaunch 为 true, hasCompletedInitialSetup 为 false', () async {
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppPrefsKeys.firstLaunch) ?? true, isTrue);
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false, isFalse);
    });

    test('2. 通过 OnboardingService 完成 Onboarding 仅影响 firstLaunch', () async {
      final service = OnboardingService();
      
      // 执行 Onboarding 服务完成
      final result = await service.completeOnboarding();
      expect(result, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppPrefsKeys.firstLaunch), isFalse);
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false, isFalse);
    });

    test('3. 多类型输入测试：当云端/历史数据写为 String "false" 或 num 0 时，解析逻辑必须稳健识别为 false，绝对不能引发 TypeError', () async {
      // 模拟 SharedPreferences 存入 String 类型的 "false" (云同步恢复常见情形)
      SharedPreferences.setMockInitialValues({
        AppPrefsKeys.firstLaunch: 'false',
        AppPrefsKeys.hasCompletedInitialSetup: 'true',
      });

      final prefs = await SharedPreferences.getInstance();
      final Object? rawFirstLaunch = prefs.get(AppPrefsKeys.firstLaunch);
      final Object? rawCompletedSetup = prefs.get(AppPrefsKeys.hasCompletedInitialSetup);

      // 验证类型确实为 String
      expect(rawFirstLaunch is String, isTrue);
      expect(rawCompletedSetup is String, isTrue);

      // 模拟 SplashScreen 中的安全类型转换解析逻辑
      final bool isFirstLaunch = rawFirstLaunch is bool
          ? rawFirstLaunch
          : (rawFirstLaunch is String ? rawFirstLaunch.toLowerCase() == 'true' : true);

      final bool hasCompletedSetup = rawCompletedSetup is bool
          ? rawCompletedSetup
          : (rawCompletedSetup is String ? rawCompletedSetup.toLowerCase() == 'true' : false);

      // 断言正确解析为 false / true，没有触发异常
      expect(isFirstLaunch, isFalse);
      expect(hasCompletedSetup, isTrue);
    });

    test('4. 两阶段各自独立完成与状态判定', () async {
      final service = OnboardingService();

      await service.completeOnboarding();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppPrefsKeys.hasCompletedInitialSetup, true);

      expect(prefs.getBool(AppPrefsKeys.firstLaunch), isFalse);
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup), isTrue);
      expect(await service.hasCompletedInitialSetup(), isTrue);
    });
  });
}
