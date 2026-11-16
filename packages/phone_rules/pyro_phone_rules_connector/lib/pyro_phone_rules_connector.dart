library pyro_phone_rules_connector;

import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_hub/pyro_phone_rules_hub.dart';
import 'package:pyro_phone_rules_driver/pyro_phone_rules_driver.dart';
import 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';
import 'package:pyro_phone_call_filter_hub/pyro_phone_call_filter_hub.dart';

/// 基础规则过滤器驱动 (BasicRuleFilterDriver)
class BasicRuleFilterDriver implements CallFilterInterface {
  @override
  CallFilterType get filterType => CallFilterType.basicRule;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    return await PhoneRulesControlCenter.instance.shouldAcceptCall(phoneNumber);
  }

  @override
  Future<void> initialize() async {}
}

/// 规则外观装配线 (Facade Assembly)
class PyroPhoneRulesConnector {
  static void registerAll({PhoneRuleStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryPhoneRuleStorageDriver();
    PhoneRulesControlCenter.instance.registerStorageDriver(driver);

    // 【核心：向 call_filter 控制中枢自注册 BasicRuleFilterDriver 驱动】
    EnhancedCompositeFilterService.instance.registerFilter(BasicRuleFilterDriver());
  }
}
