/// SharedPreferences 全局配置键名常量表（必须以 config_ 前缀开头，以便 ConfigCloudConverter 云端备份能自动识别）
class AppPrefsKeys {
  AppPrefsKeys._();

  /// 仅供 Splash 判定冷启动历史 ('config_first_launch')
  static const String firstLaunch = 'config_first_launch';

  /// 仅供 Onboarding 模块判定引导是否完成 ('config_has_completed_onboarding')
  static const String hasCompletedOnboarding = 'config_has_completed_onboarding';

  /// 初始底层配置 ('config_has_completed_initial_setup')
  static const String hasCompletedInitialSetup = 'config_has_completed_initial_setup';
}
