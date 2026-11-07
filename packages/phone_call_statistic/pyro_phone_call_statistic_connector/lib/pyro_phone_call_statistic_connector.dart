library pyro_phone_call_statistic_connector;

import 'package:pyro_phone_call_statistic_protocol/pyro_phone_call_statistic_protocol.dart';
import 'package:pyro_phone_call_statistic_hub/pyro_phone_call_statistic_hub.dart';
import 'package:pyro_phone_call_statistic_driver/pyro_phone_call_statistic_driver.dart';

/// 统计外观装配线 (Facade Assembly)
class PyroPhoneCallStatisticConnector {
  static void registerAll({PhoneCallStatisticDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryPhoneCallStatisticDriver();
    PhoneCallStatisticControlCenter.instance.registerStorageDriver(driver);
  }
}
