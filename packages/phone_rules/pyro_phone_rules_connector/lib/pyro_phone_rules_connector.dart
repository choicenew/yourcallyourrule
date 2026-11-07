library pyro_phone_rules_connector;

import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_hub/pyro_phone_rules_hub.dart';
import 'package:pyro_phone_rules_driver/pyro_phone_rules_driver.dart';

/// 规则外观装配线 (Facade Assembly)
class PyroPhoneRulesConnector {
  static void registerAll({PhoneRuleStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryPhoneRuleStorageDriver();
    PhoneRulesControlCenter.instance.registerStorageDriver(driver);
  }
}
