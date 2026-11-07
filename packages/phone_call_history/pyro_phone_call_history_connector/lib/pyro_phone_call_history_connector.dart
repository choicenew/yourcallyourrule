library pyro_phone_call_history_connector;

import 'package:pyro_phone_call_history_protocol/pyro_phone_call_history_protocol.dart';
import 'package:pyro_phone_call_history_hub/pyro_phone_call_history_hub.dart';
import 'package:pyro_phone_call_history_driver/pyro_phone_call_history_driver.dart';

/// 通话历史外观装配线 (Facade Assembly)
class PyroPhoneCallHistoryConnector {
  static void registerAll({CallLogStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryCallLogStorageDriver();
    CallHistoryControlCenter.instance.registerStorageDriver(driver);
  }
}
