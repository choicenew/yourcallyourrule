library pyro_phone_country_sync_connector;

import 'package:pyro_phone_country_sync_protocol/pyro_phone_country_sync_protocol.dart';
import 'package:pyro_phone_country_sync_hub/pyro_phone_country_sync_hub.dart';
import 'package:pyro_phone_country_sync_driver/pyro_phone_country_sync_driver.dart';

/// 国家代码同步外观装配线 (Facade Assembly)
class PyroPhoneCountrySyncConnector {
  static void registerAll({CountryDataDownloadDriver? customDownloadDriver}) {
    final driver = customDownloadDriver ?? HttpCountryDataDownloadDriver();
    PhoneCountrySyncControlCenter.instance.registerDownloadDriver(driver);
  }
}
