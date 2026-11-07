library pyro_phone_count_filter_connector;

import 'package:pyro_phone_count_filter_protocol/pyro_phone_count_filter_protocol.dart';
import 'package:pyro_phone_count_filter_hub/pyro_phone_count_filter_hub.dart';
import 'package:pyro_phone_count_filter_driver/pyro_phone_count_filter_driver.dart';
import 'package:pyro_call_filter_protocol/pyro_call_filter_protocol.dart';
import 'package:pyro_call_filter_hub/pyro_call_filter_hub.dart';

/// 自提供的本地频次阀值过滤器 Driver
class CountThresholdFilterDriver implements CallFilterInterface {
  final int currentCount;

  CountThresholdFilterDriver({this.currentCount = 0});

  @override
  CallFilterType get filterType => const CallFilterType(id: 'localCountThreshold');

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    return await PhoneCountFilterControlCenter.instance.evaluateCountThreshold(currentCount);
  }

  @override
  Future<void> initialize() async {}
}

/// 本地频次过滤器外观装配线 (Facade Assembly & Self-Registration)
class PyroPhoneCountFilterConnector {
  static void registerAll({PhoneCountStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryPhoneCountStorageDriver();
    PhoneCountFilterControlCenter.instance.registerStorageDriver(driver);

    // 【核心：自提供 + 向 call_filter 自注册】
    EnhancedCompositeFilterService.instance.registerFilter(CountThresholdFilterDriver());
  }
}
