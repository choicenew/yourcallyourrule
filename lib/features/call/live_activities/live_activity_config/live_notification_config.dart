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
    @Default(LiveTextConfig(fontSize: 18.0, position: LivePositionConfig(x: 52, y: 8))) LiveTextConfig name,
    @Default(LiveTextConfig(position: LivePositionConfig(x: 180, y: 30))) LiveTextConfig number,
    @Default(LiveTextConfig(position: LivePositionConfig(x: 52, y: 50))) LiveTextConfig location, // 对应你的 region
    @Default(LiveTextConfig(position: LivePositionConfig(x: 52, y: 70))) LiveTextConfig carrier,
    @Default(LiveTextConfig(position: LivePositionConfig(x: 52, y: 90))) LiveTextConfig countryName, // 独立的国家名
    @Default(LiveTextConfig(position: LivePositionConfig(x: 52, y: 104))) LiveTextConfig labels,
    @Default(LiveTextConfig(position: LivePositionConfig(x: 200, y: 104))) LiveTextConfig count,
    @Default(LiveTextConfig(position: LivePositionConfig(x: 160, y: 30))) LiveTextConfig numberType,
    @Default(LiveTextConfig(position: LivePositionConfig(x: 220, y: 8))) LiveTextConfig stir,
    @Default(LiveTextConfig(position: LivePositionConfig(x: 260, y: 8))) LiveTextConfig simCard,
    @Default(LiveIconConfig(position: LivePositionConfig(x: 0, y: 84))) LiveIconConfig callType,
    @Default(LiveSecurityMessageConfig(position: LivePositionConfig(x: 0, y: 96))) LiveSecurityMessageConfig securityMessage,
    
  }) = _LiveNotificationConfig;

  factory LiveNotificationConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveNotificationConfigFromJson(json);
}

// --- 所有子模型都已补全 ---

@freezed
abstract class LiveGlobalSettings with _$LiveGlobalSettings {
  const factory LiveGlobalSettings({
    @Default('#FFF2F2F2') String backgroundColor, // 浅灰色背景，符合标准通知UI
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
    @Default(LivePositionConfig(x: 0, y: 8)) LivePositionConfig position,
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
      @Default(LivePositionConfig(x: 0, y: 86)) LivePositionConfig position,
  }) = _LiveIconConfig;

    factory LiveIconConfig.fromJson(Map<String, dynamic> json) =>
      _$LiveIconConfigFromJson(json);
}

@freezed
abstract class LiveTextConfig with _$LiveTextConfig {
  const factory LiveTextConfig({
    @Default(true) bool visible,
    @Default('#DE000000') String color, // 默认深色文本，符合标准通知UI
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
      @Default('#DE000000') String color, // 安全消息在浅色背景上使用深色文本
      @Default(14.0) double fontSize,
      @Default('#FFE9ECEF') String backgroundColor, // 浅灰背景，展开区域更符合标准UI
      @Default(30.0) double height,
      @Default(300.0) double containerWidth,
      @Default(LivePositionConfig(x: 0, y: 96)) LivePositionConfig position,
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