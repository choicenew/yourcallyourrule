import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 启动门禁配置模型 (Launch Pipeline Configuration)
class LaunchConfig {
  /// 初始化超时最大上限 (默认 2500 ms，卡死自动兜底放行)
  final Duration initTimeout;

  /// 开屏广告拉取/展示超时上限 (默认 2500 ms)
  final Duration adTimeout;

  /// 是否启用开屏广告
  final bool enableAppOpenAd;

  /// 初始开屏广告梯队
  final AdTrafficTier initialAdTier;

  /// 动态判定是否需要进入引导/隐私政策页
  final Future<bool> Function()? shouldShowOnboardingCheck;

  /// 引导页完成后的显式落盘写盘回调 (确保在推进管线前 await 落盘，防进程强杀丢失数据)
  final Future<void> Function()? onOnboardingCompletedSaveCallback;

  const LaunchConfig({
    this.initTimeout = const Duration(milliseconds: 2500),
    this.adTimeout = const Duration(milliseconds: 2500),
    this.enableAppOpenAd = true,
    this.initialAdTier = AdTrafficTier.tier1,
    this.shouldShowOnboardingCheck,
    this.onOnboardingCompletedSaveCallback,
  });

  /// 标准带 `config_` 前缀安全 JSON 字典 Key（对齐 ConfigCloudConverter 规避 ClassCastException）
  static const String configOnboardingCompletedKey = 'config_has_completed_onboarding';
  static const String configFirstLaunchKey = 'config_first_launch';

  /// 将布尔值安全包裹为 Config JSON 字典对象
  static Map<String, dynamic> wrapBoolConfig(bool value) => {'value': value};

  /// 从 Config JSON 字典安全解包布尔值
  static bool unwrapBoolConfig(Map<String, dynamic>? map, {bool defaultValue = false}) {
    if (map == null) return defaultValue;
    final val = map['value'];
    if (val is bool) return val;
    if (val is String) return val.toLowerCase() == 'true';
    return defaultValue;
  }
}
