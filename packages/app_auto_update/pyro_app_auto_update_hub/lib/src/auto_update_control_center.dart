import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_app_auto_update_protocol/pyro_app_auto_update_protocol.dart';

part 'auto_update_control_center.g.dart';

@Riverpod(keepAlive: true)
AutoUpdateControlCenter autoUpdateControlCenter(Ref ref) {
  return AutoUpdateControlCenter.instance;
}

/// 自动更新控制中心 (AutoUpdateControlCenter)
class AutoUpdateControlCenter {
  static final AutoUpdateControlCenter instance = AutoUpdateControlCenter._();

  AutoUpdateControlCenter._();

  AppUpdateCheckerDriver? _checkerDriver;

  void registerCheckerDriver(AppUpdateCheckerDriver driver) {
    _checkerDriver = driver;
    debugPrint('[AutoUpdateHub] 已挂载注册版本检测驱动: ${driver.runtimeType}');
  }

  AppUpdateCheckerDriver? get checkerDriver => _checkerDriver;

  Future<AppVersionInfo?> checkLatestVersion() async {
    final info = await _checkerDriver?.checkLatestVersion();
    debugPrint('[AutoUpdateHub] 检测到最新版本: ${info?.latestVersion}');
    return info;
  }
}
