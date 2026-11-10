// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caller_id_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallerIdData _$CallerIdDataFromJson(Map<String, dynamic> json) =>
    _CallerIdData(
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String?,
      region: json['region'] as String?,
      countryName: json['countryName'] as String?,
      carrier: json['carrier'] as String?,
      labels:
          (json['labels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      localCount: (json['localCount'] as num?)?.toInt() ?? 0,
      pluginCount: (json['pluginCount'] as num?)?.toInt() ?? 0,
      remoteCount: (json['remoteCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CallerIdDataToJson(_CallerIdData instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'region': instance.region,
      'countryName': instance.countryName,
      'carrier': instance.carrier,
      'labels': instance.labels,
      'localCount': instance.localCount,
      'pluginCount': instance.pluginCount,
      'remoteCount': instance.remoteCount,
    };
