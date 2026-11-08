// lib/features/call/call_overlay/configuration/call_overlay_config.dart

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/features/common/utils/color_converter.dart'; 
import 'package:yourcallyourrule/features/common/utils/offset_converter.dart'; 

// 以下两个旧的 import 不再需要，可以删除
// import 'package:yourcallyourrule/features/call/call_overlay/providers/caller_id_style_provider.dart';
// import 'package:yourcallyourrule/features/call/call_overlay/providers/security_message_provider.dart';

part 'call_overlay_config.freezed.dart';
part 'call_overlay_config.g.dart';

@freezed
abstract class CallOverlayConfig with _$CallOverlayConfig {
  const factory CallOverlayConfig({
    @ColorConverter() required Color backgroundColorStart,
    @ColorConverter() required Color backgroundColorEnd,
    @ColorConverter() required Color textNameColor,
    @ColorConverter() required Color textNumberColor,
    @ColorConverter() required Color textLocationColor,
    @ColorConverter() required Color textCarrierColor,
    @ColorConverter() required Color textCountryNameColor,
    @ColorConverter() required Color textLabelsColor,
    @ColorConverter() required Color textCountColor,
    @ColorConverter() required Color textNumberTypeColor,
    @ColorConverter() required Color textIconLabelColor,
    @ColorConverter() required Color textIconLocationColor,
    @ColorConverter() required Color textIconCallTypeColor,
    @ColorConverter() required Color avatarBorderColor,
    @ColorConverter() required Color textStirColor,
    @ColorConverter() required Color textSimCardColor,
    required double nameFontSize,
    required double numberFontSize,
    required double locationFontSize,
    required double carrierFontSize,
    required double countryNameFontSize,
    required double labelsFontSize,
    required double countFontSize,
    required double numberTypeFontSize,
    required double stirFontSize,
    required double simCardFontSize,
    @OffsetConverter() required Offset avatarPosition,
    @OffsetConverter() required Offset namePosition,
    @OffsetConverter() required Offset carrierPosition,
    @OffsetConverter() required Offset countryNamePosition,
    @OffsetConverter() required Offset labelsPosition,
    @OffsetConverter() required Offset countPosition,
    @OffsetConverter() required Offset numberTypePosition,
    @OffsetConverter() required Offset numberPosition,
    @OffsetConverter() required Offset locationPosition,
    @OffsetConverter() required Offset callTypePosition,
    @OffsetConverter() required Offset simCardPosition,
    @OffsetConverter() required Offset stirPosition,
    @OffsetConverter() required Offset securityMessagePosition,

    // Security Message Fields
    @ColorConverter() required Color securityMessageTextColor,
    required double securityMessageFontSize,
    required double securityMessageContainerWidth,
    required double securityMessageScrollSpeed,
    required bool securityMessageEnabled,
    @ColorConverter() required Color securityMessageBackgroundColor,
    required double securityMessageHeight,
    
    // 注意: 您原有的代码中缺少窗口尺寸和图标尺寸的字段，
    // 为了让UI代码能够编译通过，这里补充添加�?
    // 如果您不希望它们成为持久化配置的一部分，可以不加，但需要相应调整UI代码�?
    required double windowWidth,
    required double windowHeight,
    required double avatarSize,
    required double avatarBorderSize,
    required double iconSize,
  }) = _CallOverlayConfig;

  factory CallOverlayConfig.fromJson(Map<String, dynamic> json) => _$CallOverlayConfigFromJson(json);
  
  /// 从Map创建CallOverlayConfig对象
  /// 这是fromJson方法的别名，用于保持与旧代码的兼容�?
  static CallOverlayConfig fromMap(Map<String, dynamic> map) => CallOverlayConfig.fromJson(map);
}

/// 将CallOverlayConfig对象转换为Map
/// 这是toJson方法的别名，用于保持与旧代码的兼容�?
// 我们�?toMap 方法直接放在 freezed 类内部，或者作为扩展方法，这里作为扩展更清晰�?
extension CallOverlayConfigToJsonX on CallOverlayConfig {
  Map<String, dynamic> toMap() => toJson();
}

// CallOverlayConfigX 扩展被移除，因为它的职责 (从多�?provider 合并/应用到多�?provider) 
// 在新的单一状态架构中已经不存在了�