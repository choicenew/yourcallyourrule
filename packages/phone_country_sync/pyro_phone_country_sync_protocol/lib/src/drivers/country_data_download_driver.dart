import 'package:pyro_phone_country_sync_protocol/src/models/country_sync_payload.dart';

/// 国家代码数据下载 Driver 抽象接口契约 (CountryDataDownloadDriver)
abstract class CountryDataDownloadDriver {
  Future<CountrySyncPayload> downloadCountryData(String countryIsoCode);
  Future<void> removeCountryData(String countryIsoCode);
}
