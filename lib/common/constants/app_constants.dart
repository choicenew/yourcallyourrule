/// 应用常量类
class AppConstants {
  const AppConstants._();

  // 应用信息
  static const String appName = 'Your Call Your Rule';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appPackageName = 'com.yourcallyourrule.app';
  
  // 数据库信息
  static const String databaseName = 'your_call_your_rule.db';
  static const int databaseVersion = 1;
  
  // 共享偏好设置键
  static const String prefsKeyTheme = 'theme_mode';
  static const String prefsKeyLanguage = 'language_code';
  static const String prefsKeyFirstRun = 'first_run';
  static const String prefsKeyLastSync = 'last_sync';
  
  // 文件路径
  static const String rulesExportFileName = 'rules_export.json';
  static const String rulesBackupFileName = 'rules_backup.json';
  
  // 网络请求
  static const int connectionTimeout = 30000; // 毫秒
  static const int receiveTimeout = 30000; // 毫秒
  
  // 分页
  static const int defaultPageSize = 20;
  
  // 通知
  static const int notificationIdCall = 1001;
  static const int notificationIdSms = 2001;
  static const String notificationChannelCall = 'call_channel';
  static const String notificationChannelSms = 'sms_channel';
  
  // 规则相关
  static const int maxRuleNameLength = 50;
  static const int maxRuleDescriptionLength = 200;
  static const int maxRegexPatternLength = 100;
  
  // 其他
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const int maxRecentCallsToShow = 50;
  static const int maxRecentSmsToShow = 50;
}