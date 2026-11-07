import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_call_overlay_config.freezed.dart';
part 'phone_call_overlay_config.g.dart';

/// 纯数据驱动来电悬浮窗配置强实体 (PhoneCallOverlayConfig)
@freezed
abstract class PhoneCallOverlayConfig with _$PhoneCallOverlayConfig {
  const PhoneCallOverlayConfig._();

  const factory PhoneCallOverlayConfig({
    @Default(true) bool enableOverlay,
    @Default('#000000') String backgroundColor,
    @Default(16) int fontSize,
    @Default(0) int positionY,
  }) = _PhoneCallOverlayConfig;

  factory PhoneCallOverlayConfig.fromJson(Map<String, dynamic> json) => _$PhoneCallOverlayConfigFromJson(json);

  factory PhoneCallOverlayConfig.fromMap(Map<String, dynamic> map) => PhoneCallOverlayConfig.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
