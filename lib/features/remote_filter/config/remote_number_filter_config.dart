import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_number_filter_config.freezed.dart';
part 'remote_number_filter_config.g.dart';

/// 远程号码过滤配置类，用于控制基于计数的过滤规则
@freezed
abstract class RemoteNumberFilterConfig with _$RemoteNumberFilterConfig {
  const RemoteNumberFilterConfig._();

  const factory RemoteNumberFilterConfig({
    @Default(true) bool enableRemoteNumberFilter,
    @Default(5) int countThreshold,
    @Default(true) bool rejectExceededNumbers,
    @Default(false) bool allowNonExceededNumbers,
    @Default(true) bool prioritizeRemoteAction,
    @Default(true) bool logAllRemoteQueries,
  }) = _RemoteNumberFilterConfig;

  factory RemoteNumberFilterConfig.fromJson(Map<String, dynamic> json) =>
      _$RemoteNumberFilterConfigFromJson(json);

  /// 兼容旧的 fromMap 调用
  factory RemoteNumberFilterConfig.fromMap(Map<String, dynamic> map) =>
      RemoteNumberFilterConfig.fromJson(map);

  /// 兼容旧的 toMap 调用
  Map<String, dynamic> toMap() => toJson();
}
