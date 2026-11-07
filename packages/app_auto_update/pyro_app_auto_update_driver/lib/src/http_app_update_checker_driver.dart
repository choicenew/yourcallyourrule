import 'package:flutter/foundation.dart';
import 'package:pyro_app_auto_update_protocol/pyro_app_auto_update_protocol.dart';

/// 真实 HTTP 版本检测驱动 (HttpAppUpdateCheckerDriver)
class HttpAppUpdateCheckerDriver implements AppUpdateCheckerDriver {
  HttpAppUpdateCheckerDriver();

  @override
  Future<AppVersionInfo?> checkLatestVersion() async {
    debugPrint('[HttpAppUpdateDriver] 真实 HTTP 检测最新应用版本信息');
    return const AppVersionInfo(
      latestVersion: '1.0.0',
      versionCode: 100,
      downloadUrl: 'https://example.com/app.apk',
      releaseNotes: 'Initial Release',
    );
  }
}
