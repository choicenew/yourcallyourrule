/// SharedPreferences 全局配置键名常量表（必须以 config_ 前缀开头，以便 ConfigCloudConverter 云端备份能自动识别）
class AppPrefsKeys {
  AppPrefsKeys._();

  /// 是否已完成首次初始化设置 ('config_has_completed_initial_setup')
  static const String hasCompletedInitialSetup = 'config_has_completed_initial_setup';

  /// 是否为首次启动 App ('config_first_launch')
  static const String firstLaunch = 'config_first_launch';
}
