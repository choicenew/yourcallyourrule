// lib/features/call/live_activities/models/live_notification_config.dart

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_notification_config.freezed.dart';
part 'live_notification_config.g.dart';

@freezed
abstract class LiveNotificationConfig with _$LiveNotificationConfig {
  const factory LiveNotificationConfig({
    // --- 全局 ---
    @Default(LiveGlobalSettings()) LiveGlobalSettings globalSettings,

    // --- 元素配置 (100% 参照你的 CallerIdConfig) ---
    @Default(LiveAvatarConfig()) LiveAvatarConfig avatar,
    @Default(LiveTextConfig(fontSize: 18.0)) LiveTextConfig name,
    @Default(LiveTextConfig()) LiveTextConfig number,
    @Default(LiveTextConfig()) LiveTextConfig location, // 对应你的 region
    @Default(LiveTextConfig()) LiveTextConfig carrier,
    @Default(LiveTextConfig()) LiveTextConfig countryName, // 独立的国家名
    @Default(LiveTextConfig()) LiveTextConfig labels,
    @Default(LiveTextConfig()) LiveTextConfig count,
    @Default(LiveTextConfig()) LiveTextConfig numberType,
    @Default(LiveTextConfig()) LiveTextConfig stir,
    @Default(LiveTextConfig()) LiveTextConfig simCard,
    @Default(LiveIconConfig()) LiveIconConfig callType,
    @Default(LiveSecurityMessageConfig()) LiveSecurityMessageConfig securityMessage,
    
  }) = _LiveNotificationConfig;

  factory LiveNotificationConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveNotificationConfigFromJson(json);
}

// --- 所有子模型都已补全 ---

@freezed
abstract class LiveGlobalSettings with _$LiveGlobalSettings {
  const factory LiveGlobalSettings({
    @Default('#FF2E2E2E') String backgroundColor, // 深灰色背景
    @Default(LiveBorderConfig()) LiveBorderConfig border,
  }) = _LiveGlobalSettings;

  factory LiveGlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$LiveGlobalSettingsFromJson(json);
}

@freezed
abstract class LiveBorderConfig with _$LiveBorderConfig {
  const factory LiveBorderConfig({
    @Default(0.0) double width,
    @Default('#00000000') String color,
    @Default(16.0) double radius,
  }) = _LiveBorderConfig;

  factory LiveBorderConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveBorderConfigFromJson(json);
}

@freezed
abstract class LiveAvatarConfig with _$LiveAvatarConfig {
  const factory LiveAvatarConfig({
    @Default(true) bool visible,
    @Default(60.0) double size,
    @Default(1.0) double borderWidth,
    @Default('#FFFFFFFF') String borderColor,
    @Default(LivePositionConfig(x: 16, y: 16)) LivePositionConfig position,
  }) = _LiveAvatarConfig;

  factory LiveAvatarConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveAvatarConfigFromJson(json);
}

@freezed
abstract class LiveIconConfig with _$LiveIconConfig {
  const factory LiveIconConfig({
      @Default(true) bool visible,
      @Default(20.0) double size,
      @Default('#FF21F375') String color,
      @Default(LivePositionConfig()) LivePositionConfig position,
  }) = _LiveIconConfig;

    factory LiveIconConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveIconConfigFromJson(json);
}

@freezed
abstract class LiveTextConfig with _$LiveTextConfig {
  const factory LiveTextConfig({
    @Default(true) bool visible,
    @Default('#FFFFFFFF') String color,
    @Default(14.0) double fontSize,
    @Default(LivePositionConfig()) LivePositionConfig position,
  }) = _LiveTextConfig;

  factory LiveTextConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveTextConfigFromJson(json);
}

@freezed
abstract class LiveSecurityMessageConfig with _$LiveSecurityMessageConfig {
  const factory LiveSecurityMessageConfig({
      @Default(true) bool visible,
      @Default('#FFFFFFFF') String color,
      @Default(14.0) double fontSize,
      @Default('#B0515151') String backgroundColor,
      @Default(30.0) double height,
      @Default(300.0) double containerWidth,
      @Default(LivePositionConfig()) LivePositionConfig position,
  }) = _LiveSecurityMessageConfig;

    factory LiveSecurityMessageConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveSecurityMessageConfigFromJson(json);
}


@freezed
abstract class LivePositionConfig with _$LivePositionConfig {
  const factory LivePositionConfig({
    @Default(0.0) double x,
    @Default(0.0) double y,
  }) = _LivePositionConfig;

  factory LivePositionConfig.fromJson(Map<String, dynamic> json) =>
      _$LivePositionConfigFromJson(json);
}