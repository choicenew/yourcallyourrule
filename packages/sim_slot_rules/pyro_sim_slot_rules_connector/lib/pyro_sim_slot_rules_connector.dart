library pyro_sim_slot_rules_connector;

import 'package:pyro_sim_slot_rules_protocol/pyro_sim_slot_rules_protocol.dart';
import 'package:pyro_sim_slot_rules_hub/pyro_sim_slot_rules_hub.dart';
import 'package:pyro_sim_slot_rules_driver/pyro_sim_slot_rules_driver.dart';

/// 卡槽规则外观装配线 (Facade Assembly)
class SimSlotRuleConnector {
  static void registerAll({SimSlotRuleStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemorySimSlotRuleStorageDriver();
    SimSlotRuleControlCenter.instance.registerStorageDriver(driver);
  }
}
