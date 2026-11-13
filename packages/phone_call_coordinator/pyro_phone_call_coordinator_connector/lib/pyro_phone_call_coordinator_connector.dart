import 'package:pyro_phone_call_coordinator_protocol/pyro_phone_call_coordinator_protocol.dart';
import 'package:pyro_phone_call_coordinator_hub/pyro_phone_call_coordinator_hub.dart';
import 'package:pyro_phone_call_coordinator_driver/pyro_phone_call_coordinator_driver.dart';

/// 编排外观装配线 (Facade Assembly)
class PyroCallCoordinatorConnector {
  static void registerAll({CallCoordinatorDriver? customDriver}) {
    final driver = customDriver ?? LoggingCallCoordinatorDriver();
    CallCoordinatorService.instance.registerCoordinatorDriver(driver);
  }
}
