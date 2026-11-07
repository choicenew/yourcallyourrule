library pyro_phone_marking_connector;

import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_marking_hub/pyro_phone_marking_hub.dart';
import 'package:pyro_phone_marking_driver/pyro_phone_marking_driver.dart';

/// 号码打标外观装配线 (Facade Assembly)
class PyroPhoneMarkingConnector {
  static void registerAll({PhoneMarkingStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryPhoneMarkingStorageDriver();
    MarkPhoneControlCenter.instance.registerStorageDriver(driver);
  }
}
