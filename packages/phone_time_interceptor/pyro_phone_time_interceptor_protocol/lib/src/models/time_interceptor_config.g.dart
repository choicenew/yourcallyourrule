// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_interceptor_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeInterceptorConfigImpl _$$TimeInterceptorConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$TimeInterceptorConfigImpl(
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 30,
      shouldIntercept: json['shouldIntercept'] as bool? ?? true,
    );

Map<String, dynamic> _$$TimeInterceptorConfigImplToJson(
        _$TimeInterceptorConfigImpl instance) =>
    <String, dynamic>{
      'durationMinutes': instance.durationMinutes,
      'shouldIntercept': instance.shouldIntercept,
    };
