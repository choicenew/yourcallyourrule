// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_count_filter_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneCountFilterConfig _$PhoneCountFilterConfigFromJson(
  Map<String, dynamic> json,
) => _PhoneCountFilterConfig(
  enableLocalCountFilter: json['enableLocalCountFilter'] as bool? ?? true,
  countThreshold: (json['countThreshold'] as num?)?.toInt() ?? 5,
  rejectExceededNumbers: json['rejectExceededNumbers'] as bool? ?? true,
  allowNonExceededNumbers: json['allowNonExceededNumbers'] as bool? ?? false,
);

Map<String, dynamic> _$PhoneCountFilterConfigToJson(
  _PhoneCountFilterConfig instance,
) => <String, dynamic>{
  'enableLocalCountFilter': instance.enableLocalCountFilter,
  'countThreshold': instance.countThreshold,
  'rejectExceededNumbers': instance.rejectExceededNumbers,
  'allowNonExceededNumbers': instance.allowNonExceededNumbers,
};
