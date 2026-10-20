import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';

part 'onboarding_service.g.dart';

@Riverpod(keepAlive: true)
OnboardingService onboardingService(Ref ref) {
  return OnboardingService();
}

/// 负责 Onboarding 引导状态持久化的核心服务类（独立 app_ Key，隔离 config_ 通配符）
class OnboardingService {
  /// 用户真正点击“完成引导”按钮时调用：直接持久化到 AppPrefsKeys.hasCompletedOnboarding
  Future<bool> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(AppPrefsKeys.hasCompletedOnboarding, true);
    } catch (_) {
      return false;
    }
  }

  /// 检查引导是否完成：优先读取 app_ Key，降级兼容旧 config_ Key
  Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // 1. 优先读取独立隔离的新 Key
      final val = prefs.get(AppPrefsKeys.hasCompletedOnboarding);
      if (val is bool) return val;
      if (val is String) return val.toLowerCase().trim() == 'true';
      if (val is num) return val != 0;

      // 2. 降级读取旧 Key 兼容存量用户
      final oldVal = prefs.get('config_has_completed_onboarding');
      if (oldVal is bool) return oldVal;
      if (oldVal is String) return oldVal.toLowerCase().trim() == 'true';
      if (oldVal is num) return oldVal != 0;

      return false;
    } catch (_) {
      return false;
    }
  }
}
