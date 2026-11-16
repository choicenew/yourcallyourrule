import '../models/phone_location_entry.dart';

/// 电话号码归属地解析驱动契约 (PhoneLocationResolverDriver)
/// 负责基于离线数据库/libphonenumber/运营商码表解析电话号码的地理归属与运营主体
abstract class PhoneLocationResolverDriver {
  Future<PhoneLocationEntry?> resolveLocation(
    String phoneNumber, {
    String? localeLanguage,
    String? localeCountry,
  });
}
