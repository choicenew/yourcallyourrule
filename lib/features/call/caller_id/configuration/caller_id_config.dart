import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/common/utils/color_converter.dart';
import 'package:yourcallyourrule/common/utils/offset_converter.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/security_message_provider.dart';

part 'caller_id_config.freezed.dart';
part 'caller_id_config.g.dart';

@freezed
abstract class CallerIdConfig with _$CallerIdConfig {
  const factory CallerIdConfig({
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
  }) = _CallerIdConfig;

  factory CallerIdConfig.fromJson(Map<String, dynamic> json) => _$CallerIdConfigFromJson(json);
  
  /// 从Map创建CallerIdConfig对象
  /// 这是fromJson方法的别名，用于保持与旧代码的兼容性
  static CallerIdConfig fromMap(Map<String, dynamic> map) => CallerIdConfig.fromJson(map);
}

extension CallerIdConfigX on CallerIdConfig {
  /// 将CallerIdConfig对象转换为Map
  /// 这是toJson方法的别名，用于保持与旧代码的兼容性
  Map<String, dynamic> toMap() => toJson();
  
  static CallerIdConfig fromProviders(CallerIdStyleProvider styleProvider, SecurityMessageProvider securityProvider) {
    return CallerIdConfig(
      backgroundColorStart: styleProvider.backgroundColorStart,
      backgroundColorEnd: styleProvider.backgroundColorEnd,
      textNameColor: styleProvider.textNameColor,
      textNumberColor: styleProvider.textNumberColor,
      textLocationColor: styleProvider.textLocationColor,
      textCarrierColor: styleProvider.textCarrierColor,
      textCountryNameColor: styleProvider.textCountryNameColor,
      textLabelsColor: styleProvider.textLabelsColor,
      textCountColor: styleProvider.textCountColor,
      textNumberTypeColor: styleProvider.textNumberTypeColor,
      textIconLabelColor: styleProvider.textIconLabelColor,
      textIconLocationColor: styleProvider.textIconLocationColor,
      textIconCallTypeColor: styleProvider.textIconCallTypeColor,
      avatarBorderColor: styleProvider.avatarBorderColor,
      textStirColor: styleProvider.textStirColor,
      textSimCardColor: styleProvider.textSimCardColor,
      nameFontSize: styleProvider.nameFontSize,
      numberFontSize: styleProvider.numberFontSize,
      locationFontSize: styleProvider.locationFontSize,
      carrierFontSize: styleProvider.carrierFontSize,
      countryNameFontSize: styleProvider.countryNameFontSize,
      labelsFontSize: styleProvider.labelsFontSize,
      countFontSize: styleProvider.countFontSize,
      numberTypeFontSize: styleProvider.numberTypeFontSize,
      stirFontSize: styleProvider.stirFontSize,
      simCardFontSize: styleProvider.simCardFontSize,
      avatarPosition: styleProvider.avatarPosition,
      namePosition: styleProvider.namePosition,
      carrierPosition: styleProvider.carrierPosition,
      countryNamePosition: styleProvider.countryNamePosition,
      labelsPosition: styleProvider.labelsPosition,
      countPosition: styleProvider.countPosition,
      numberTypePosition: styleProvider.numberTypePosition,
      numberPosition: styleProvider.numberPosition,
      locationPosition: styleProvider.locationPosition,
      callTypePosition: styleProvider.callTypePosition,
      simCardPosition: styleProvider.simCardPosition,
      stirPosition: styleProvider.stirPosition,
      securityMessagePosition: styleProvider.securityMessagePosition,
      // Security Message Fields
      securityMessageTextColor: securityProvider.textColor,
      securityMessageFontSize: securityProvider.fontSize,
      securityMessageContainerWidth: securityProvider.containerWidth,
      securityMessageScrollSpeed: securityProvider.scrollSpeed,
      securityMessageEnabled: securityProvider.isEnabled,
      securityMessageBackgroundColor: securityProvider.backgroundColor,
      securityMessageHeight: securityProvider.height,
    );
  }

  void applyToProviders(CallerIdStyleProvider styleProvider, SecurityMessageProvider securityProvider) {
    styleProvider
      ..setBackgroundColorStart(backgroundColorStart)
      ..setBackgroundColorEnd(backgroundColorEnd)
      ..setTextNameColor(textNameColor)
      ..setTextNumberColor(textNumberColor)
      ..setTextLocationColor(textLocationColor)
      ..setTextCarrierColor(textCarrierColor)
      ..setTextCountryNameColor(textCountryNameColor)
      ..setTextLabelsColor(textLabelsColor)
      ..setTextCountColor(textCountColor)
      ..setTextNumberTypeColor(textNumberTypeColor)
      ..setTextIconLabelColor(textIconLabelColor)
      ..setTextIconLocationColor(textIconLocationColor)
      ..setTextIconCallTypeColor(textIconCallTypeColor)
      ..setAvatarBorderColor(avatarBorderColor)
      ..setTextStirColor(textStirColor)
      ..setTextSimCardColor(textSimCardColor)
      ..setNameFontSize(nameFontSize)
      ..setNumberFontSize(numberFontSize)
      ..setLocationFontSize(locationFontSize)
      ..setCarrierFontSize(carrierFontSize)
      ..setCountryNameFontSize(countryNameFontSize)
      ..setLabelsFontSize(labelsFontSize)
      ..setCountFontSize(countFontSize)
      ..setNumberTypeFontSize(numberTypeFontSize)
      ..setStirFontSize(stirFontSize)
      ..setSimCardFontSize(simCardFontSize)
      ..updateAvatarPosition(avatarPosition)
      ..updateNamePosition(namePosition)
      ..updateCarrierPosition(carrierPosition)
      ..updateCountryNamePosition(countryNamePosition)
      ..updateLabelsPosition(labelsPosition)
      ..updateCountPosition(countPosition)
      ..updateNumberTypePosition(numberTypePosition)
      ..updateNumberPosition(numberPosition)
      ..updateLocationPosition(locationPosition)
      ..updateCallTypePosition(callTypePosition)
      ..updateSimCardPosition(simCardPosition)
      ..updateStirPosition(stirPosition)
      ..updateSecurityMessagePosition(securityMessagePosition);

    securityProvider
      ..setTextColor(securityMessageTextColor)
      ..setFontSize(securityMessageFontSize)
      ..updatePosition(securityMessagePosition) // Note: Security message position is linked to styleProvider's
      ..setContainerWidth(securityMessageContainerWidth)
      ..setScrollSpeed(securityMessageScrollSpeed)
      ..setEnabled(securityMessageEnabled)
      ..setBackgroundColor(securityMessageBackgroundColor)
      ..setHeight(securityMessageHeight);
  }

}
