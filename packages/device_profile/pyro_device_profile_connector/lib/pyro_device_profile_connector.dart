library pyro_device_profile_connector;

import 'package:pyro_device_profile_protocol/pyro_device_profile_protocol.dart';
import 'package:pyro_device_profile_hub/pyro_device_profile_hub.dart';
import 'package:pyro_device_profile_driver/pyro_device_profile_driver.dart';

/// 设备环境外观装配线 (Facade Assembly)
class PyroDeviceProfileConnector {
  static void registerAll({DeviceHardwareInfoDriver? customHardwareDriver}) {
    final driver = customHardwareDriver ?? MemoryDeviceHardwareInfoDriver();
    DeviceProfileControlCenter.instance.registerHardwareDriver(driver);
  }
}
