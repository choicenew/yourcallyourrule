// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_call_overlay_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneCallOverlayConfig _$PhoneCallOverlayConfigFromJson(
  Map<String, dynamic> json,
) => _PhoneCallOverlayConfig(
  enableOverlay: json['enableOverlay'] as bool? ?? true,
  backgroundColor: json['backgroundColor'] as String? ?? '#000000',
  fontSize: (json['fontSize'] as num?)?.toInt() ?? 16,
  positionY: (json['positionY'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PhoneCallOverlayConfigToJson(
  _PhoneCallOverlayConfig instance,
) => <String, dynamic>{
  'enableOverlay': instance.enableOverlay,
  'backgroundColor': instance.backgroundColor,
  'fontSize': instance.fontSize,
  'positionY': instance.positionY,
};
