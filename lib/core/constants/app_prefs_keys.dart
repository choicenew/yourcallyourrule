/// SharedPreferences 偏好配置键名常量表（app_ 前缀独立隔离，避免被 ConfigCloudConverter 误扫引发原生强转异常）
class AppPrefsKeys {
  AppPrefsKeys._();

  /// 仅供 Splash 判定冷启动历史 ('app_first_launch')
  static const String firstLaunch = 'app_first_launch';

  /// 仅供 Onboarding 模块判定引导是否完成 ('app_has_completed_onboarding')
  static const String hasCompletedOnboarding = 'app_has_completed_onboarding';

  /// 初始底层配置 ('app_has_completed_initial_setup')
  static const String hasCompletedInitialSetup = 'app_has_completed_initial_setup';
}
