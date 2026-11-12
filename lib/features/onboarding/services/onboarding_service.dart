import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/features/common/constants/app_prefs_keys.dart';

part 'onboarding_service.g.dart';

@Riverpod(keepAlive: true)
OnboardingService onboardingService(Ref ref) {
  return OnboardingService();
}

class OnboardingService {
  Future<bool> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('first_launch', false);
      final res = await prefs.setBool(AppPrefsKeys.hasCompletedOnboarding, true);
      return res;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(AppPrefsKeys.hasCompletedOnboarding) ?? false;
    } catch (_) {
      return false;
    }
  }
}
