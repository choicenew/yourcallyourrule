import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

part 'onboarding_service.g.dart';

/// 负责 Onboarding 引导状态持久化的核心服务类（基于原生 ConfigRepository 存储）
class OnboardingService {
  final ConfigRepository _configRepository;

  OnboardingService(this._configRepository);

  /// 标记 Onboarding 流程完成
  Future<bool> completeOnboarding() async {
    try {
      await _configRepository.saveConfig(AppPrefsKeys.firstLaunch, {'completed': true});
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 检查 Onboarding 是否已完成
  Future<bool> isOnboardingCompleted() async {
    try {
      final config = await _configRepository.getConfig(AppPrefsKeys.firstLaunch);
      return config?['completed'] == true;
    } catch (_) {
      return false;
    }
  }

  /// 检查 Initial Setup 是否已完成
  Future<bool> hasCompletedInitialSetup() async {
    try {
      final config = await _configRepository.getConfig(AppPrefsKeys.hasCompletedInitialSetup);
      return config?['completed'] == true;
    } catch (_) {
      return false;
    }
  }
}

/// OnboardingService 的 @riverpod 自动生成 Provider
@riverpod
OnboardingService onboardingService(Ref ref) {
  final configRepo = ref.watch(configRepositoryProvider);
  return OnboardingService(configRepo);
}
