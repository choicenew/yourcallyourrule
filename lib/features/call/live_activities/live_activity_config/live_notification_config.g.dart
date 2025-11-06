// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_notification_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveNotificationConfig _$LiveNotificationConfigFromJson(
  Map<String, dynamic> json,
) => _LiveNotificationConfig(
  globalSettings:
      json['globalSettings'] == null
          ? const LiveGlobalSettings()
          : LiveGlobalSettings.fromJson(
            json['globalSettings'] as Map<String, dynamic>,
          ),
  avatar:
      json['avatar'] == null
          ? const LiveAvatarConfig()
          : LiveAvatarConfig.fromJson(json['avatar'] as Map<String, dynamic>),
  name:
      json['name'] == null
          ? const LiveTextConfig(
            fontSize: 18.0,
            position: LivePositionConfig(x: 52, y: 8),
          )
          : LiveTextConfig.fromJson(json['name'] as Map<String, dynamic>),
  number:
      json['number'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 180, y: 30))
          : LiveTextConfig.fromJson(json['number'] as Map<String, dynamic>),
  location:
      json['location'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 52, y: 50))
          : LiveTextConfig.fromJson(json['location'] as Map<String, dynamic>),
  carrier:
      json['carrier'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 52, y: 70))
          : LiveTextConfig.fromJson(json['carrier'] as Map<String, dynamic>),
  countryName:
      json['countryName'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 52, y: 90))
          : LiveTextConfig.fromJson(
            json['countryName'] as Map<String, dynamic>,
          ),
  labels:
      json['labels'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 52, y: 104))
          : LiveTextConfig.fromJson(json['labels'] as Map<String, dynamic>),
  count:
      json['count'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 200, y: 104))
          : LiveTextConfig.fromJson(json['count'] as Map<String, dynamic>),
  numberType:
      json['numberType'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 160, y: 30))
          : LiveTextConfig.fromJson(json['numberType'] as Map<String, dynamic>),
  stir:
      json['stir'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 220, y: 8))
          : LiveTextConfig.fromJson(json['stir'] as Map<String, dynamic>),
  simCard:
      json['simCard'] == null
          ? const LiveTextConfig(position: LivePositionConfig(x: 260, y: 8))
          : LiveTextConfig.fromJson(json['simCard'] as Map<String, dynamic>),
  callType:
      json['callType'] == null
          ? const LiveIconConfig(position: LivePositionConfig(x: 0, y: 84))
          : LiveIconConfig.fromJson(json['callType'] as Map<String, dynamic>),
  securityMessage:
      json['securityMessage'] == null
          ? const LiveSecurityMessageConfig(
            position: LivePositionConfig(x: 0, y: 96),
          )
          : LiveSecurityMessageConfig.fromJson(
            json['securityMessage'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$LiveNotificationConfigToJson(
  _LiveNotificationConfig instance,
) => <String, dynamic>{
  'globalSettings': instance.globalSettings,
  'avatar': instance.avatar,
  'name': instance.name,
  'number': instance.number,
  'location': instance.location,
  'carrier': instance.carrier,
  'countryName': instance.countryName,
  'labels': instance.labels,
  'count': instance.count,
  'numberType': instance.numberType,
  'stir': instance.stir,
  'simCard': instance.simCard,
  'callType': instance.callType,
  'securityMessage': instance.securityMessage,
};

_LiveGlobalSettings _$LiveGlobalSettingsFromJson(Map<String, dynamic> json) =>
    _LiveGlobalSettings(
      backgroundColor: json['backgroundColor'] as String? ?? '#FFF2F2F2',
      border:
          json['border'] == null
              ? const LiveBorderConfig()
              : LiveBorderConfig.fromJson(
                json['border'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$LiveGlobalSettingsToJson(_LiveGlobalSettings instance) =>
    <String, dynamic>{
      'backgroundColor': instance.backgroundColor,
      'border': instance.border,
    };

_LiveBorderConfig _$LiveBorderConfigFromJson(Map<String, dynamic> json) =>
    _LiveBorderConfig(
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      color: json['color'] as String? ?? '#00000000',
      radius: (json['radius'] as num?)?.toDouble() ?? 16.0,
    );

Map<String, dynamic> _$LiveBorderConfigToJson(_LiveBorderConfig instance) =>
    <String, dynamic>{
      'width': instance.width,
      'color': instance.color,
      'radius': instance.radius,
    };

_LiveAvatarConfig _$LiveAvatarConfigFromJson(Map<String, dynamic> json) =>
    _LiveAvatarConfig(
      visible: json['visible'] as bool? ?? true,
      size: (json['size'] as num?)?.toDouble() ?? 60.0,
      borderWidth: (json['borderWidth'] as num?)?.toDouble() ?? 1.0,
      borderColor: json['borderColor'] as String? ?? '#FFFFFFFF',
      position:
          json['position'] == null
              ? const LivePositionConfig(x: 0, y: 8)
              : LivePositionConfig.fromJson(
                json['position'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$LiveAvatarConfigToJson(_LiveAvatarConfig instance) =>
    <String, dynamic>{
      'visible': instance.visible,
      'size': instance.size,
      'borderWidth': instance.borderWidth,
      'borderColor': instance.borderColor,
      'position': instance.position,
    };

_LiveIconConfig _$LiveIconConfigFromJson(Map<String, dynamic> json) =>
    _LiveIconConfig(
      visible: json['visible'] as bool? ?? true,
      size: (json['size'] as num?)?.toDouble() ?? 20.0,
      color: json['color'] as String? ?? '#FF21F375',
      position:
          json['position'] == null
              ? const LivePositionConfig(x: 0, y: 86)
              : LivePositionConfig.fromJson(
                json['position'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$LiveIconConfigToJson(_LiveIconConfig instance) =>
    <String, dynamic>{
      'visible': instance.visible,
      'size': instance.size,
      'color': instance.color,
      'position': instance.position,
    };

_LiveTextConfig _$LiveTextConfigFromJson(Map<String, dynamic> json) =>
    _LiveTextConfig(
      visible: json['visible'] as bool? ?? true,
      color: json['color'] as String? ?? '#DE000000',
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 14.0,
      position:
          json['position'] == null
              ? const LivePositionConfig()
              : LivePositionConfig.fromJson(
                json['position'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$LiveTextConfigToJson(_LiveTextConfig instance) =>
    <String, dynamic>{
      'visible': instance.visible,
      'color': instance.color,
      'fontSize': instance.fontSize,
      'position': instance.position,
    };

_LiveSecurityMessageConfig _$LiveSecurityMessageConfigFromJson(
  Map<String, dynamic> json,
) => _LiveSecurityMessageConfig(
  visible: json['visible'] as bool? ?? true,
  color: json['color'] as String? ?? '#DE000000',
  fontSize: (json['fontSize'] as num?)?.toDouble() ?? 14.0,
  backgroundColor: json['backgroundColor'] as String? ?? '#FFE9ECEF',
  height: (json['height'] as num?)?.toDouble() ?? 30.0,
  containerWidth: (json['containerWidth'] as num?)?.toDouble() ?? 300.0,
  position:
      json['position'] == null
          ? const LivePositionConfig(x: 0, y: 96)
          : LivePositionConfig.fromJson(
            json['position'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$LiveSecurityMessageConfigToJson(
  _LiveSecurityMessageConfig instance,
) => <String, dynamic>{
  'visible': instance.visible,
  'color': instance.color,
  'fontSize': instance.fontSize,
  'backgroundColor': instance.backgroundColor,
  'height': instance.height,
  'containerWidth': instance.containerWidth,
  'position': instance.position,
};

_LivePositionConfig _$LivePositionConfigFromJson(Map<String, dynamic> json) =>
    _LivePositionConfig(
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$LivePositionConfigToJson(_LivePositionConfig instance) =>
    <String, dynamic>{'x': instance.x, 'y': instance.y};
