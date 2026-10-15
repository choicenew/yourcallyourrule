// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_filter_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoteNumberFilterConfig _$RemoteNumberFilterConfigFromJson(
  Map<String, dynamic> json,
) => _RemoteNumberFilterConfig(
  enableRemoteNumberFilter: json['enableRemoteNumberFilter'] as bool? ?? true,
  countThreshold: (json['countThreshold'] as num?)?.toInt() ?? 5,
  rejectExceededNumbers: json['rejectExceededNumbers'] as bool? ?? true,
  allowNonExceededNumbers: json['allowNonExceededNumbers'] as bool? ?? false,
  prioritizeRemoteAction: json['prioritizeRemoteAction'] as bool? ?? true,
  logAllRemoteQueries: json['logAllRemoteQueries'] as bool? ?? true,
);

Map<String, dynamic> _$RemoteNumberFilterConfigToJson(
  _RemoteNumberFilterConfig instance,
) => <String, dynamic>{
  'enableRemoteNumberFilter': instance.enableRemoteNumberFilter,
  'countThreshold': instance.countThreshold,
  'rejectExceededNumbers': instance.rejectExceededNumbers,
  'allowNonExceededNumbers': instance.allowNonExceededNumbers,
  'prioritizeRemoteAction': instance.prioritizeRemoteAction,
  'logAllRemoteQueries': instance.logAllRemoteQueries,
};
