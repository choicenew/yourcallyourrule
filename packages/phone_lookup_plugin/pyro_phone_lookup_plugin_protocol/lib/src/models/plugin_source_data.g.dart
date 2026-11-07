// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_source_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PluginSourceData _$PluginSourceDataFromJson(Map<String, dynamic> json) =>
    _PluginSourceData(
      predefinedLabel: json['predefinedLabel'] as String?,
      sourceLabel: json['sourceLabel'] as String?,
      avatar: json['avatar'] as String?,
      count: (json['count'] as num?)?.toInt(),
      province: json['province'] as String?,
      city: json['city'] as String?,
      carrier: json['carrier'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      actionName: json['actionName'] as String? ?? 'none',
    );

Map<String, dynamic> _$PluginSourceDataToJson(_PluginSourceData instance) =>
    <String, dynamic>{
      'predefinedLabel': instance.predefinedLabel,
      'sourceLabel': instance.sourceLabel,
      'avatar': instance.avatar,
      'count': instance.count,
      'province': instance.province,
      'city': instance.city,
      'carrier': instance.carrier,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'actionName': instance.actionName,
    };
