import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:pyro_phone_call_interception_policy_hub/pyro_phone_call_interception_policy_hub.dart';
import 'package:pyro_phone_call_interception_policy_driver/pyro_phone_call_interception_policy_driver.dart';

/// 通话防护策略外观装配线 (Facade Assembly)
class PyroCallInterceptionPolicyConnector {
  static void registerAll({
    CallPolicyControlCenter? hub,
    CallPolicyStorageDriver? customStorageDriver,
  }) {
    final driver = customStorageDriver ?? MemoryCallPolicyStorageDriver();
    hub?.registerStorageDriver(driver);
  }
}
