/// 来电显示模式枚举
enum DisplayMode {
  /// 悬浮窗模式
  overlay,

  /// 系统通知模式
  notification,

  /// 灵动岛/实时活动模式 (Live Activity)
  liveActivity;

  /// 从 SharedPreferences 或 JSON 安全创建枚举（具备旧版本存量用户兼容性）
  factory DisplayMode.fromString(dynamic raw) {
    if (raw == null) return DisplayMode.liveActivity;
    final str = raw.toString().trim();
    switch (str) {
      case 'overlay':
        return DisplayMode.overlay;
      case 'notification':
        return DisplayMode.notification;
      // TODO: 计划在 v5.0 版本彻底移除对历史遗留 'live_activity' 下划线字符串的解析处理
      case 'live_activity':
      case 'liveActivity':
      default:
        return DisplayMode.liveActivity;
    }
  }

  /// 转换回存储字符串 ('overlay', 'notification', 'liveActivity')
  String toRawString() {
    switch (this) {
      case DisplayMode.overlay:
        return 'overlay';
      case DisplayMode.notification:
        return 'notification';
      case DisplayMode.liveActivity:
        return 'liveActivity';
    }
  }
}
