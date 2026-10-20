import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

part 'onboarding_service.g.dart';

@Riverpod(keepAlive: true)
OnboardingService onboardingService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return OnboardingService(configRepository: configRepository);
}

/// 负责 Onboarding 引导状态持久化的核心服务类（100% 对齐 PurchaseState 架构，零垫底兼容层）
class OnboardingService {
  final ConfigRepository _configRepository;

  OnboardingService({ConfigRepository? configRepository})
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  /// 用户真正点击“完成引导”按钮时调用：100% 对齐 PurchaseState 存储 {'value': true} JSON 对象
  Future<bool> completeOnboarding() async {
    try {
      await _configRepository.saveConfig(AppPrefsKeys.hasCompletedOnboarding, {'value': true});
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 检查引导是否完成：100% 对齐 PurchaseState 读取 JSON 对象
  Future<bool> isOnboardingCompleted() async {
    try {
      final config = await _configRepository.getConfig(AppPrefsKeys.hasCompletedOnboarding);
      return config?['value'] as bool? ?? false;
    } catch (_) {
      return false;
    }
  }
}
