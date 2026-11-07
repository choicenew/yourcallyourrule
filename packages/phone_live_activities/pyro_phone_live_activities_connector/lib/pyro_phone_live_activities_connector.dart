library pyro_phone_live_activities_connector;

import 'package:pyro_phone_live_activities_protocol/pyro_phone_live_activities_protocol.dart';
import 'package:pyro_phone_live_activities_hub/pyro_phone_live_activities_hub.dart';
import 'package:pyro_phone_live_activities_driver/pyro_phone_live_activities_driver.dart';

/// 灵动岛外观装配线 (Facade Assembly)
class PyroPhoneLiveActivitiesConnector {
  static void registerAll({PhoneLiveIslandDriver? customIslandDriver}) {
    final driver = customIslandDriver ?? SystemLiveIslandDriver();
    LiveHubControlCenter.instance.registerIslandDriver(driver);
  }
}
