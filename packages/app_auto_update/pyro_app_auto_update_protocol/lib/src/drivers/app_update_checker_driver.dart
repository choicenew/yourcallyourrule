import 'package:pyro_app_auto_update_protocol/src/models/app_version_info.dart';

/// 版本检测 Driver 抽象接口契约 (AppUpdateCheckerDriver)
abstract class AppUpdateCheckerDriver {
  Future<AppVersionInfo?> checkLatestVersion();
}
