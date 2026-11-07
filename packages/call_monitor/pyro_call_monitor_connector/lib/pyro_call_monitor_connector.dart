library pyro_call_monitor_connector;

import 'package:pyro_call_monitor_protocol/pyro_call_monitor_protocol.dart';
import 'package:pyro_call_monitor_hub/pyro_call_monitor_hub.dart';
import 'package:pyro_call_monitor_driver/pyro_call_monitor_driver.dart';

/// 传感器外观装配线 (Facade Assembly)
class PyroCallMonitorConnector {
  static void registerAll({TelephonySensorDriver? customSensorDriver}) {
    final driver = customSensorDriver ?? MemoryTelephonySensorDriver();
    CallMonitorService.instance.registerSensorDriver(driver);
  }
}
