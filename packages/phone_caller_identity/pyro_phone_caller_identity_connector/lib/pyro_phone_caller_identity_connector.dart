import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:pyro_phone_caller_identity_hub/pyro_phone_caller_identity_hub.dart';
import 'package:pyro_phone_caller_identity_driver/pyro_caller_identity_driver.dart';

/// 身份画像外观装配线 (Facade Assembly)
class PyroCallerIdentityConnector {
  static void registerAll({CallerIdentityFetchDriver? customFetchDriver}) {
    final driver = customFetchDriver ?? MemoryCallerIdentityFetchDriver();
    CallerIdentityService.instance.registerFetchDriver(driver);
  }
}
