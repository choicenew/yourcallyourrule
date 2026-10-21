/// SharedPreferences 偏好配置键名常量表（独立纯粹标志，无 config_ 干扰）
class AppPrefsKeys {
  AppPrefsKeys._();

  /// 仅供 Splash 判定冷启动历史 ('first_launch')
  static const String firstLaunch = 'first_launch';

  /// 仅供 Onboarding 模块判定引导是否完成 ('has_completed_onboarding')
  static const String hasCompletedOnboarding = 'has_completed_onboarding';

  /// 初始底层配置 ('has_completed_initial_setup')
  static const String hasCompletedInitialSetup = 'has_completed_initial_setup';
}
