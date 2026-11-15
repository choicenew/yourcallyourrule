import 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';
import 'package:pyro_phone_sim_slot_rules_hub/pyro_phone_sim_slot_rules_hub.dart';
import 'package:pyro_phone_sim_slot_rules_driver/pyro_phone_sim_slot_rules_driver.dart';

/// 双卡槽规则过滤器驱动 (SimSlotRuleFilterDriver)
class SimSlotRuleFilterDriver implements CallFilterInterface {
  @override
  CallFilterType get filterType => CallFilterType.simSlot;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async => true;

  @override
  Future<void> initialize() async {}
}

/// 卡槽规则外观装配线 (Facade Assembly)
class SimSlotRuleConnector {
  static void registerAll({SimSlotRuleStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemorySimSlotRuleStorageDriver();
    SimSlotRuleControlCenter.instance.registerStorageDriver(driver);

    // 【向 call_filter 控制中枢自注册 SimSlotRuleFilterDriver 驱动】
    EnhancedCompositeFilterService.instance.registerFilter(SimSlotRuleFilterDriver());
  }
}
