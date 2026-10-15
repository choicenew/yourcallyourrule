// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_count_filter_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalCountFilterConfig _$LocalCountFilterConfigFromJson(
  Map<String, dynamic> json,
) => _LocalCountFilterConfig(
  enableLocalCountFilter: json['enableLocalCountFilter'] as bool? ?? true,
  countThreshold: (json['countThreshold'] as num?)?.toInt() ?? 5,
  rejectExceededNumbers: json['rejectExceededNumbers'] as bool? ?? true,
  allowNonExceededNumbers: json['allowNonExceededNumbers'] as bool? ?? false,
  logAllLocalQueries: json['logAllLocalQueries'] as bool? ?? true,
);

Map<String, dynamic> _$LocalCountFilterConfigToJson(
  _LocalCountFilterConfig instance,
) => <String, dynamic>{
  'enableLocalCountFilter': instance.enableLocalCountFilter,
  'countThreshold': instance.countThreshold,
  'rejectExceededNumbers': instance.rejectExceededNumbers,
  'allowNonExceededNumbers': instance.allowNonExceededNumbers,
  'logAllLocalQueries': instance.logAllLocalQueries,
};
