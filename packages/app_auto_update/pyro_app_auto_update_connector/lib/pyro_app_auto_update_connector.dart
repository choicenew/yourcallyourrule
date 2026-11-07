library pyro_app_auto_update_connector;

import 'package:pyro_app_auto_update_protocol/pyro_app_auto_update_protocol.dart';
import 'package:pyro_app_auto_update_hub/pyro_app_auto_update_hub.dart';
import 'package:pyro_app_auto_update_driver/pyro_app_auto_update_driver.dart';

/// 自动更新外观装配线 (Facade Assembly)
class PyroAppAutoUpdateConnector {
  static void registerAll({AppUpdateCheckerDriver? customCheckerDriver}) {
    final driver = customCheckerDriver ?? HttpAppUpdateCheckerDriver();
    AutoUpdateControlCenter.instance.registerCheckerDriver(driver);
  }
}
