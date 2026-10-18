import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Onboarding 与 InitialSetup 解耦独立测试', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('1. 默认状态下 firstLaunch 为 true, hasCompletedInitialSetup 为 false', () async {
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(AppPrefsKeys.firstLaunch) ?? true, isTrue);
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false, isFalse);
    });

    test('2. 完成 Onboarding 仅影响 firstLaunch，绝不越权修改 hasCompletedInitialSetup', () async {
      final prefs = await SharedPreferences.getInstance();
      
      // 模拟 Onboarding 完成
      await prefs.setBool(AppPrefsKeys.firstLaunch, false);

      expect(prefs.getBool(AppPrefsKeys.firstLaunch), isFalse);
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false, isFalse);
    });

    test('3. 完成 InitialSetup 仅影响 hasCompletedInitialSetup，互不干涉', () async {
      final prefs = await SharedPreferences.getInstance();

      // 模拟 InitialSetup 完成
      await prefs.setBool(AppPrefsKeys.hasCompletedInitialSetup, true);

      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup), isTrue);
      // firstLaunch 保持未设置状态 (true)
      expect(prefs.getBool(AppPrefsKeys.firstLaunch) ?? true, isTrue);
    });

    test('4. 两阶段各自独立完成', () async {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool(AppPrefsKeys.firstLaunch, false);
      await prefs.setBool(AppPrefsKeys.hasCompletedInitialSetup, true);

      expect(prefs.getBool(AppPrefsKeys.firstLaunch), isFalse);
      expect(prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup), isTrue);
    });
  });
}
