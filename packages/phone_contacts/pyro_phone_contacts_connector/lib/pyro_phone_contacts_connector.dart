library pyro_phone_contacts_connector;

import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_contacts_hub/pyro_phone_contacts_hub.dart';
import 'package:pyro_phone_contacts_driver/pyro_phone_contacts_driver.dart';

/// 联系人外观装配线 (Facade Assembly)
class PyroPhoneContactsConnector {
  static void registerAll({PhoneContactReaderDriver? customReaderDriver}) {
    final driver = customReaderDriver ?? MemoryPhoneContactReaderDriver();
    PhoneContactsControlCenter.instance.registerReaderDriver(driver);
  }
}
