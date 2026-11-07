// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_location_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneLocationEntry _$PhoneLocationEntryFromJson(Map<String, dynamic> json) =>
    _PhoneLocationEntry(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String,
      region: json['region'] as String?,
      countryName: json['countryName'] as String?,
      carrier: json['carrier'] as String?,
      numberType: json['numberType'] as String? ?? 'UNKNOWN',
    );

Map<String, dynamic> _$PhoneLocationEntryToJson(_PhoneLocationEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'region': instance.region,
      'countryName': instance.countryName,
      'carrier': instance.carrier,
      'numberType': instance.numberType,
    };
