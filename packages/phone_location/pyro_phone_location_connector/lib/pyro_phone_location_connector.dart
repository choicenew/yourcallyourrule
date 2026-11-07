library pyro_phone_location_connector;

import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:pyro_phone_location_hub/pyro_phone_location_hub.dart';
import 'package:pyro_phone_location_driver/pyro_phone_location_driver.dart';

/// 归属地外观装配线 (Facade Assembly)
class PyroPhoneLocationConnector {
  static void registerAll({PhoneLocationStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryPhoneLocationStorageDriver();
    PhoneLocationControlCenter.instance.registerStorageDriver(driver);
  }
}
