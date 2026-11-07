// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_sync_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CountrySyncPayload _$CountrySyncPayloadFromJson(Map<String, dynamic> json) =>
    _CountrySyncPayload(
      countryIsoCode: json['countryIsoCode'] as String,
      totalRecords: (json['totalRecords'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'completed',
      timestamp: (json['timestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CountrySyncPayloadToJson(_CountrySyncPayload instance) =>
    <String, dynamic>{
      'countryIsoCode': instance.countryIsoCode,
      'totalRecords': instance.totalRecords,
      'status': instance.status,
      'timestamp': instance.timestamp,
    };
