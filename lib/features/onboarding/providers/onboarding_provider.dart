import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import '../services/onboarding_service.dart';

/// OnboardingService 单例服务 Provider
final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  final configRepo = ref.watch(configRepositoryProvider);
  return OnboardingService(configRepo);
});
