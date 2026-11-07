library pyro_phone_remote_filter_connector;

import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';
import 'package:pyro_phone_remote_filter_hub/pyro_phone_remote_filter_hub.dart';
import 'package:pyro_phone_remote_filter_driver/pyro_phone_remote_filter_driver.dart';
import 'package:pyro_call_filter_protocol/pyro_call_filter_protocol.dart';
import 'package:pyro_call_filter_hub/pyro_call_filter_hub.dart';

/// 自提供的远程高危号码过滤器 Driver
class RemoteRiskFilterDriver implements CallFilterInterface {
  @override
  CallFilterType get filterType => const CallFilterType(id: 'remoteRisk');

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    return await PhoneRemoteFilterControlCenter.instance.evaluateRemoteRisk(phoneNumber);
  }

  @override
  Future<void> initialize() async {}
}

/// 远程高危过滤器外观装配线 (Facade Assembly & Self-Registration)
class PyroPhoneRemoteFilterConnector {
  static void registerAll({RemoteNumberStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryRemoteNumberStorageDriver();
    PhoneRemoteFilterControlCenter.instance.registerStorageDriver(driver);

    // 【核心：自提供 + 向 call_filter 自注册】
    EnhancedCompositeFilterService.instance.registerFilter(RemoteRiskFilterDriver());
  }
}
