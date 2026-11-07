// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_raw_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceRawProfile _$DeviceRawProfileFromJson(Map<String, dynamic> json) =>
    _DeviceRawProfile(
      deviceId: json['deviceId'] as String?,
      hashedDeviceId: json['hashedDeviceId'] as String?,
      simState: json['simState'] as String?,
      ipAddress: json['ipAddress'] as String?,
      countryCode: json['countryCode'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$DeviceRawProfileToJson(_DeviceRawProfile instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'hashedDeviceId': instance.hashedDeviceId,
      'simState': instance.simState,
      'ipAddress': instance.ipAddress,
      'countryCode': instance.countryCode,
      'city': instance.city,
    };
