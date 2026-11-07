import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_country_sync_protocol/pyro_phone_country_sync_protocol.dart';

part 'phone_country_sync_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneCountrySyncControlCenter phoneCountrySyncControlCenter(Ref ref) {
  return PhoneCountrySyncControlCenter.instance;
}

/// 国家代码同步控制中心 (PhoneCountrySyncControlCenter)
class PhoneCountrySyncControlCenter {
  static final PhoneCountrySyncControlCenter instance = PhoneCountrySyncControlCenter._();

  PhoneCountrySyncControlCenter._();

  CountryDataDownloadDriver? _downloadDriver;

  void registerDownloadDriver(CountryDataDownloadDriver driver) {
    _downloadDriver = driver;
    debugPrint('[PhoneCountrySyncHub] 已挂载注册国家数据下载驱动: ${driver.runtimeType}');
  }

  CountryDataDownloadDriver? get downloadDriver => _downloadDriver;

  Future<CountrySyncPayload?> downloadCountryData(String countryIsoCode) async {
    final payload = await _downloadDriver?.downloadCountryData(countryIsoCode);
    debugPrint('[PhoneCountrySyncHub] 下载国家镜像数据完成: $countryIsoCode (${payload?.totalRecords} 条)');
    return payload;
  }
}
