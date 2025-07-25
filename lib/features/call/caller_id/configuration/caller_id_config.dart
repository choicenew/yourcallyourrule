import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/common/utils/color_converter.dart';
import 'package:yourcallyourrule/common/utils/offset_converter.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';

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
  
  static CallerIdConfig fromStyleProvider(CallerIdStyleProvider provider) {
    return CallerIdConfig(
      backgroundColorStart: provider.backgroundColorStart,
      backgroundColorEnd: provider.backgroundColorEnd,
      textNameColor: provider.textNameColor,
      textNumberColor: provider.textNumberColor,
      textLocationColor: provider.textLocationColor,
      textCarrierColor: provider.textCarrierColor,
      textCountryNameColor: provider.textCountryNameColor,
      textLabelsColor: provider.textLabelsColor,
      textCountColor: provider.textCountColor,
      textNumberTypeColor: provider.textNumberTypeColor,
      textIconLabelColor: provider.textIconLabelColor,
      textIconLocationColor: provider.textIconLocationColor,
      textIconCallTypeColor: provider.textIconCallTypeColor,
      avatarBorderColor: provider.avatarBorderColor,
      textStirColor: provider.textStirColor,
      textSimCardColor: provider.textSimCardColor,
      nameFontSize: provider.nameFontSize,
      numberFontSize: provider.numberFontSize,
      locationFontSize: provider.locationFontSize,
      carrierFontSize: provider.carrierFontSize,
      countryNameFontSize: provider.countryNameFontSize,
      labelsFontSize: provider.labelsFontSize,
      countFontSize: provider.countFontSize,
      numberTypeFontSize: provider.numberTypeFontSize,
      stirFontSize: provider.stirFontSize,
      simCardFontSize: provider.simCardFontSize,
      avatarPosition: provider.avatarPosition,
      namePosition: provider.namePosition,
      carrierPosition: provider.carrierPosition,
      countryNamePosition: provider.countryNamePosition,
      labelsPosition: provider.labelsPosition,
      countPosition: provider.countPosition,
      numberTypePosition: provider.numberTypePosition,
      numberPosition: provider.numberPosition,
      locationPosition: provider.locationPosition,
      callTypePosition: provider.callTypePosition,
      simCardPosition: provider.simCardPosition,
      stirPosition: provider.stirPosition,
      securityMessagePosition: provider.securityMessagePosition,
    );
  }

  void applyToProvider(CallerIdStyleProvider provider) {
    provider
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
  }
}
