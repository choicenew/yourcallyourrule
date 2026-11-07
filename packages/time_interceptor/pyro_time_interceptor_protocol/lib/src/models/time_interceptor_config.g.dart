// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_interceptor_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeInterceptorConfig _$TimeInterceptorConfigFromJson(
  Map<String, dynamic> json,
) => _TimeInterceptorConfig(
  durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 30,
  shouldIntercept: json['shouldIntercept'] as bool? ?? true,
);

Map<String, dynamic> _$TimeInterceptorConfigToJson(
  _TimeInterceptorConfig instance,
) => <String, dynamic>{
  'durationMinutes': instance.durationMinutes,
  'shouldIntercept': instance.shouldIntercept,
};
