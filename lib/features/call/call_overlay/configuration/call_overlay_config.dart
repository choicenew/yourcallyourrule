import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/features/common/utils/color_converter.dart';
import 'package:yourcallyourrule/features/common/utils/offset_converter.dart';

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

    @ColorConverter() required Color securityMessageTextColor,
    required double securityMessageFontSize,
    required double securityMessageContainerWidth,
    required double securityMessageScrollSpeed,
    required bool securityMessageEnabled,
    @ColorConverter() required Color securityMessageBackgroundColor,
    required double securityMessageHeight,

    required double windowWidth,
    required double windowHeight,
    required double avatarSize,
    required double avatarBorderSize,
    required double iconSize,
  }) = _CallOverlayConfig;

  factory CallOverlayConfig.fromJson(Map<String, dynamic> json) => _$CallOverlayConfigFromJson(json);

  static CallOverlayConfig fromMap(Map<String, dynamic> map) => CallOverlayConfig.fromJson(map);
}

extension CallOverlayConfigToJsonX on CallOverlayConfig {
  Map<String, dynamic> toMap() => toJson();
}
