import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/onboarding_service.dart';

/// OnboardingService 单例服务 Provider
final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  return OnboardingService();
});
