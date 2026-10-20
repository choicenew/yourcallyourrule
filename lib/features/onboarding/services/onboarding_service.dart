import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

part 'onboarding_service.g.dart';

@Riverpod(keepAlive: true)
OnboardingService onboardingService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return OnboardingService(configRepository: configRepository);
}

/// 负责 Onboarding 引导状态持久化的核心服务类（对齐 PurchaseState JSON 持久化协议）
class OnboardingService {
  final ConfigRepository _configRepository;

  OnboardingService({ConfigRepository? configRepository})
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  /// 用户真正点击“完成引导”按钮时调用：通过 ConfigRepository 存储 JSON Map，同步写入原生 bool 保障兼容性
  Future<bool> completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      await _configRepository.saveConfig(AppPrefsKeys.hasCompletedOnboarding, {'value': true});
      await prefs.setBool(AppPrefsKeys.hasCompletedOnboarding, true);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 检查引导是否完成：优先读取 ConfigRepository JSON 配置，降级兼容原生存储
  Future<bool> isOnboardingCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();

      // 1. 优先读取 ConfigRepository 标准 JSON 结构（对齐 purchase_state）
      final config = await _configRepository.getConfig(AppPrefsKeys.hasCompletedOnboarding);
      if (config != null && config.containsKey('value')) {
        return config['value'] as bool? ?? false;
      }

      // 2. 兜底兼容原生 SharedPreferences 存储
      final val = prefs.get(AppPrefsKeys.hasCompletedOnboarding);
      if (val is bool) return val;
      if (val is String) return val.toLowerCase().trim() == 'true';
      if (val is num) return val != 0;
      return false;
    } catch (_) {
      return false;
    }
  }
}
