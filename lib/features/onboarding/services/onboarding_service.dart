import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';

part 'onboarding_service.g.dart';

/// 负责 Onboarding 引导状态持久化的核心服务类（直接使用原生 SharedPreferences 强类型读写）
class OnboardingService {
  /// 用户真正点击“完成引导”按钮时调用：直接存 true
  Future<bool> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final success = await prefs.setBool(AppPrefsKeys.hasCompletedOnboarding, true);
      try {
        await prefs.reload();
      } catch (_) {}
      return success;
    } catch (_) {
      return false;
    }
  }

  /// 检查引导是否完成：直接读取，默认为 false
  Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      try {
        await prefs.reload();
      } catch (_) {}
      return prefs.getBool(AppPrefsKeys.hasCompletedOnboarding) ?? false;
    } catch (_) {
      return false;
    }
  }

  /// 检查 Initial Setup 是否已完成（hasCompletedInitialSetup 为 true 即代表完成）
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

/// OnboardingService 的 @riverpod 自动生成 Provider
@riverpod
OnboardingService onboardingService(Ref ref) {
  return OnboardingService();
}
