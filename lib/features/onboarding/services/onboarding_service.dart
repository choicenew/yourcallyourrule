import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';

part 'onboarding_service.g.dart';

@Riverpod(keepAlive: true)
OnboardingService onboardingService(Ref ref) {
  return OnboardingService();
}

/// 负责 Onboarding 引导状态持久化的核心服务类（独立纯粹布尔存储）
class OnboardingService {
  /// 用户一进入/完成引导时调用：直接存原生 bool 为 true
  Future<bool> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setBool(AppPrefsKeys.hasCompletedOnboarding, true);
    } catch (_) {
      return false;
    }
  }

  /// 检查引导是否完成
  Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(AppPrefsKeys.hasCompletedOnboarding) ?? false;
    } catch (_) {
      return false;
    }
  }
}
