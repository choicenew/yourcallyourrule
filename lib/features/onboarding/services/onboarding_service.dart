import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';

/// 负责 Onboarding 引导状态持久化的核心服务类（独立业务逻辑）
class OnboardingService {
  /// 标记 Onboarding 流程完成（保存 config_first_launch 为 false）
  Future<bool> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final success = await prefs.setBool(AppPrefsKeys.firstLaunch, false);
      try {
        await prefs.reload();
      } catch (_) {}
      return success;
    } catch (_) {
      return false;
    }
  }

  /// 获取当前初始规则设置（hasCompletedInitialSetup）的状态
  Future<bool> hasCompletedInitialSetup() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      try {
        await prefs.reload();
      } catch (_) {}
      return prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false;
    } catch (_) {
      return false;
    }
  }
}
