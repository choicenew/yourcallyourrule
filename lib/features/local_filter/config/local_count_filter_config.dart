import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_count_filter_config.freezed.dart';
part 'local_count_filter_config.g.dart';

/// 本地号码计数过滤配置类，用于控制基于计数的过滤规则
@freezed
abstract class LocalCountFilterConfig with _$LocalCountFilterConfig {
  const LocalCountFilterConfig._();

  const factory LocalCountFilterConfig({
    @Default(true) bool enableLocalCountFilter,
    @Default(5) int countThreshold,
    @Default(true) bool rejectExceededNumbers,
    @Default(false) bool allowNonExceededNumbers,
    @Default(true) bool logAllLocalQueries,
  }) = _LocalCountFilterConfig;

  factory LocalCountFilterConfig.fromJson(Map<String, dynamic> json) =>
      _$LocalCountFilterConfigFromJson(json);

  /// 兼容旧的 fromMap 调用
  factory LocalCountFilterConfig.fromMap(Map<String, dynamic> map) =>
      LocalCountFilterConfig.fromJson(map);

  /// 兼容旧的 toMap 调用
  Map<String, dynamic> toMap() => toJson();
}
