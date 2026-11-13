import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_interceptor_config.freezed.dart';
part 'time_interceptor_config.g.dart';

/// 时间窗口拦截配置强实体 (TimeInterceptorConfig)
@freezed
abstract class TimeInterceptorConfig with _$TimeInterceptorConfig {
  const TimeInterceptorConfig._();

  const factory TimeInterceptorConfig({
    @Default(30) int durationMinutes,
    @Default(true) bool shouldIntercept,
  }) = _TimeInterceptorConfig;

  factory TimeInterceptorConfig.fromJson(Map<String, dynamic> json) => _$TimeInterceptorConfigFromJson(json);

  factory TimeInterceptorConfig.fromMap(Map<String, dynamic> map) => TimeInterceptorConfig.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
