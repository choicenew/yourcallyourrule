/// 来电显示/呼叫协调模式枚举
enum DisplayMode {
  /// 悬浮窗弹窗模式
  overlay,

  /// 系统横幅通知模式
  notification,

  /// iOS Live Activity / 灵动岛模式
  liveActivity;

  factory DisplayMode.fromString(dynamic raw) {
    if (raw == null) return DisplayMode.liveActivity;
    final str = raw.toString().trim();
    switch (str) {
      case 'overlay':
        return DisplayMode.overlay;
      case 'notification':
        return DisplayMode.notification;
      case 'liveActivity':
      default:
        return DisplayMode.liveActivity;
    }
  }

  String toRawString() {
    return name;
  }
}
