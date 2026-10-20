import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';

part 'onboarding_service.g.dart';

@Riverpod(keepAlive: true)
OnboardingService onboardingService(Ref ref) {
  return OnboardingService();
}

/// 负责 Onboarding 引导状态持久化的核心服务类
class OnboardingService {
  /// 用户真正点击“完成引导”按钮时调用：直接持久化 true
  Future<bool> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final success = await prefs.setBool(AppPrefsKeys.hasCompletedOnboarding, true);
      debugPrint('[OnboardingService] completeOnboarding result: $success');
      return success;
    } catch (e) {
      debugPrint('[OnboardingService] Error completing onboarding: $e');
      return false;
    }
  }

  /// 检查引导是否完成：使用 prefs.get 万能兼容读取
  Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final val = prefs.get(AppPrefsKeys.hasCompletedOnboarding);
      debugPrint('[OnboardingService] isOnboardingCompleted raw value: $val (${val.runtimeType})');
      if (val is bool) return val;
      if (val is String) {
        final lower = val.toLowerCase().trim();
        return lower == 'true' || lower.contains('"value":true') || lower.contains('"value": true');
      }
      if (val is num) return val != 0;
      return false;
    } catch (e) {
      debugPrint('[OnboardingService] Error reading onboarding state: $e');
      return false;
    }
  }
}
