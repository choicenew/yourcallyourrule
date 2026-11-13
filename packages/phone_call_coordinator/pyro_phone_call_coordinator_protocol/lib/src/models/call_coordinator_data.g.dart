// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_coordinator_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CallCoordinatorData _$CallCoordinatorDataFromJson(Map<String, dynamic> json) =>
    _CallCoordinatorData(
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String?,
      region: json['region'] as String?,
      carrier: json['carrier'] as String?,
      labels: (json['labels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      localCount: (json['localCount'] as num?)?.toInt() ?? 0,
      pluginCount: (json['pluginCount'] as num?)?.toInt() ?? 0,
      remoteCount: (json['remoteCount'] as num?)?.toInt() ?? 0,
      actionName: json['actionName'] as String? ?? 'allow',
    );

Map<String, dynamic> _$CallCoordinatorDataToJson(_CallCoordinatorData instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'region': instance.region,
      'carrier': instance.carrier,
      'labels': instance.labels,
      'localCount': instance.localCount,
      'pluginCount': instance.pluginCount,
      'remoteCount': instance.remoteCount,
      'actionName': instance.actionName,
    };
