library pyro_phone_subscription_connector;

import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:pyro_phone_subscription_hub/pyro_phone_subscription_hub.dart';
import 'package:pyro_phone_subscription_driver/pyro_phone_subscription_driver.dart';

/// 电话订阅外观装配线 (Facade Assembly)
class PyroPhoneSubscriptionConnector {
  static void registerAll({PhoneSubscriptionClientDriver? customClientDriver}) {
    final driver = customClientDriver ?? HttpPhoneSubscriptionClientDriver();
    PhoneRulesSubscriptionControlCenter.instance.registerClientDriver(driver);
  }
}
