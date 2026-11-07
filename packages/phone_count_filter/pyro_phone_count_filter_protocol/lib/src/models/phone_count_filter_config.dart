import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_count_filter_config.freezed.dart';
part 'phone_count_filter_config.g.dart';

/// 纯数据驱动本地频次过滤配置强实体 (PhoneCountFilterConfig)
@freezed
abstract class PhoneCountFilterConfig with _$PhoneCountFilterConfig {
  const PhoneCountFilterConfig._();

  const factory PhoneCountFilterConfig({
    @Default(true) bool enableLocalCountFilter,
    @Default(5) int countThreshold,
    @Default(true) bool rejectExceededNumbers,
    @Default(false) bool allowNonExceededNumbers,
  }) = _PhoneCountFilterConfig;

  factory PhoneCountFilterConfig.fromJson(Map<String, dynamic> json) => _$PhoneCountFilterConfigFromJson(json);

  factory PhoneCountFilterConfig.fromMap(Map<String, dynamic> map) => PhoneCountFilterConfig.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
