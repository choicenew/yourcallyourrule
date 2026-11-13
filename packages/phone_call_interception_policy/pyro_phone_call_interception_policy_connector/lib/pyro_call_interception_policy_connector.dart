import 'package:pyro_phone_call_interception_policy_protocol/pyro_call_interception_policy_protocol.dart';
import 'package:pyro_phone_call_interception_policy_hub/pyro_call_interception_policy_hub.dart';
import 'package:pyro_phone_call_interception_policy_driver/pyro_call_interception_policy_driver.dart';

/// 通话防护策略外观装配线 (Facade Assembly)
class PyroCallInterceptionPolicyConnector {
  static void registerAll({CallPolicyStorageDriver? customStorageDriver}) {
    final driver = customStorageDriver ?? MemoryCallPolicyStorageDriver();
    CallPolicyControlCenter.instance.registerStorageDriver(driver);
  }
}
