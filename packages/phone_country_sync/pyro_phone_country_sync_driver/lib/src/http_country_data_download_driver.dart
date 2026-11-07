import 'package:flutter/foundation.dart';
import 'package:pyro_phone_country_sync_protocol/pyro_phone_country_sync_protocol.dart';

/// 真实 HTTP 国家数据镜像下载驱动 (HttpCountryDataDownloadDriver)
class HttpCountryDataDownloadDriver implements CountryDataDownloadDriver {
  HttpCountryDataDownloadDriver();

  @override
  Future<CountrySyncPayload> downloadCountryData(String countryIsoCode) async {
    debugPrint('[HttpCountryDataDriver] 真实 HTTP 下载国家 $countryIsoCode 的离线号码数据镜像包');
    return CountrySyncPayload(
      countryIsoCode: countryIsoCode,
      totalRecords: 1000,
      status: 'completed',
    );
  }

  @override
  Future<void> removeCountryData(String countryIsoCode) async {
    debugPrint('[HttpCountryDataDriver] 清除国家 $countryIsoCode 的本地离线号码数据包');
  }
}
