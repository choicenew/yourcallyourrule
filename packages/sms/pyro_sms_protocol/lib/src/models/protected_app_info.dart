/// Information on a protected messaging application whose notifications are monitored
class ProtectedAppInfo {
  final String packageName;
  final String appName;
  final bool isDefaultSmsApp;
  final bool isEnabled;

  const ProtectedAppInfo({
    required this.packageName,
    required this.appName,
    this.isDefaultSmsApp = false,
    this.isEnabled = true,
  });

  static const List<ProtectedAppInfo> defaults = [
    ProtectedAppInfo(
      packageName: 'com.google.android.apps.messaging',
      appName: 'Google Messages',
      isDefaultSmsApp: true,
    ),
    ProtectedAppInfo(
      packageName: 'com.samsung.android.messaging',
      appName: 'Samsung Messages',
      isDefaultSmsApp: true,
    ),
    ProtectedAppInfo(
      packageName: 'com.whatsapp',
      appName: 'WhatsApp',
    ),
    ProtectedAppInfo(
      packageName: 'org.telegram.messenger',
      appName: 'Telegram',
    ),
  ];
}
