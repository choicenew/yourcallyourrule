import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_raw_profile.freezed.dart';
part 'device_raw_profile.g.dart';

/// 纯数据驱动设备环境与网络感知强实体 (DeviceRawProfile)
@freezed
abstract class DeviceRawProfile with _$DeviceRawProfile {
  const DeviceRawProfile._();

  const factory DeviceRawProfile({
    String? deviceId,
    String? hashedDeviceId,
    String? simState,
    String? ipAddress,
    String? countryCode,
    String? city,
  }) = _DeviceRawProfile;

  factory DeviceRawProfile.fromJson(Map<String, dynamic> json) => _$DeviceRawProfileFromJson(json);

  factory DeviceRawProfile.fromMap(Map<String, dynamic> map) => DeviceRawProfile.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
