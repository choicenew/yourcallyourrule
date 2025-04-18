import 'package:flutter/material.dart';
import 'position_offset.dart';

/// 来电显示样式实体类
/// 包含来电显示界面的所有样式配置
class CallerIdStyle {
  // 背景颜色
  final Color backgroundColorStart;
  final Color backgroundColorEnd;

  // 文本颜色
  final Color textNameColor;
  final Color textNumberColor;
  final Color textLocationColor;
  final Color textCarrierColor;
  final Color textCountryNameColor;
  final Color textLabelsColor;
  final Color textCountColor;
  final Color textNumberTypeColor;
  final Color textStirColor;
  final Color textSimCardColor;

  // 图标颜色
  final Color textIconLabelColor;
  final Color textIconLocationColor;
  final Color textIconCallTypeColor;
  final Color avatarBorderColor;

  // 尺寸
  final double avatarSize;
  final double avatarBorderSize;
  final double iconSize;
  final double windowWidth;
  final double windowHeight;

  // 字体大小
  final double nameFontSize;
  final double numberFontSize;
  final double locationFontSize;
  final double carrierFontSize;
  final double countryNameFontSize;
  final double labelsFontSize;
  final double countFontSize;
  final double numberTypeFontSize;
  final double stirFontSize;
  final double simCardFontSize;

  // 位置
  final PositionOffset avatarPosition;
  final PositionOffset namePosition;
  final PositionOffset carrierPosition;
  final PositionOffset countryNamePosition;
  final PositionOffset labelsPosition;
  final PositionOffset countPosition;
  final PositionOffset numberTypePosition;
  final PositionOffset numberPosition;
  final PositionOffset locationPosition;
  final PositionOffset callTypePosition;
  final PositionOffset simCardPosition;
  final PositionOffset stirPosition;

  /// 构造函数
  const CallerIdStyle({
    required this.backgroundColorStart,
    required this.backgroundColorEnd,
    required this.textNameColor,
    required this.textNumberColor,
    required this.textLocationColor,
    required this.textCarrierColor,
    required this.textCountryNameColor,
    required this.textLabelsColor,
    required this.textCountColor,
    required this.textNumberTypeColor,
    required this.textStirColor,
    required this.textSimCardColor,
    required this.textIconLabelColor,
    required this.textIconLocationColor,
    required this.textIconCallTypeColor,
    required this.avatarBorderColor,
    required this.avatarSize,
    required this.avatarBorderSize,
    required this.iconSize,
    required this.windowWidth,
    required this.windowHeight,
    required this.nameFontSize,
    required this.numberFontSize,
    required this.locationFontSize,
    required this.carrierFontSize,
    required this.countryNameFontSize,
    required this.labelsFontSize,
    required this.countFontSize,
    required this.numberTypeFontSize,
    required this.stirFontSize,
    required this.simCardFontSize,
    required this.avatarPosition,
    required this.namePosition,
    required this.carrierPosition,
    required this.countryNamePosition,
    required this.labelsPosition,
    required this.countPosition,
    required this.numberTypePosition,
    required this.numberPosition,
    required this.locationPosition,
    required this.callTypePosition,
    required this.simCardPosition,
    required this.stirPosition,
  });

  /// 创建默认样式
  factory CallerIdStyle.defaultStyle() {
    return CallerIdStyle(
      backgroundColorStart: const Color.fromARGB(255, 255, 227, 227),
      backgroundColorEnd: const Color.fromARGB(255, 255, 227, 227),
      textNameColor: const Color.fromARGB(255, 0, 0, 0),
      textNumberColor: const Color.fromARGB(255, 0, 0, 0),
      textLocationColor: const Color.fromARGB(255, 0, 0, 0),
      textCarrierColor: const Color.fromARGB(255, 0, 0, 0),
      textCountryNameColor: const Color.fromARGB(255, 0, 0, 0),
      textLabelsColor: const Color.fromARGB(255, 0, 0, 0),
      textCountColor: const Color.fromARGB(255, 0, 0, 0),
      textNumberTypeColor: const Color.fromARGB(255, 0, 0, 0),
      textStirColor: const Color.fromARGB(255, 0, 0, 0),
      textSimCardColor: const Color.fromARGB(255, 0, 0, 0),
      textIconLabelColor: const Color.fromARGB(255, 233, 30, 99),
      textIconLocationColor: const Color.fromARGB(255, 76, 175, 80),
      textIconCallTypeColor: const Color.fromARGB(255, 76, 175, 80),
      avatarBorderColor: const Color.fromARGB(255, 76, 175, 80),
      avatarSize: 60,
      avatarBorderSize: 65,
      iconSize: 20,
      windowWidth: 330,
      windowHeight: 220,
      nameFontSize: 18,
      numberFontSize: 16,
      locationFontSize: 14,
      carrierFontSize: 18,
      countryNameFontSize: 18,
      labelsFontSize: 18,
      countFontSize: 18,
      numberTypeFontSize: 18,
      stirFontSize: 14,
      simCardFontSize: 14,
      avatarPosition: const PositionOffset(dx: 10, dy: 10),
      namePosition: const PositionOffset(dx: 80, dy: 50),
      carrierPosition: const PositionOffset(dx: 80, dy: 70),
      countryNamePosition: const PositionOffset(dx: 100, dy: 10),
      labelsPosition: const PositionOffset(dx: 20, dy: 130),
      countPosition: const PositionOffset(dx: 110, dy: 110),
      numberTypePosition: const PositionOffset(dx: 100, dy: 30),
      numberPosition: const PositionOffset(dx: 80, dy: 150),
      locationPosition: const PositionOffset(dx: 10, dy: 100),
      callTypePosition: const PositionOffset(dx: 60, dy: 150),
      simCardPosition: const PositionOffset(dx: 150, dy: 170),
      stirPosition: const PositionOffset(dx: 200, dy: 130),
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'backgroundColorStart': backgroundColorStart.value,
      'backgroundColorEnd': backgroundColorEnd.value,
      'textNameColor': textNameColor.value,
      'textNumberColor': textNumberColor.value,
      'textLocationColor': textLocationColor.value,
      'textCarrierColor': textCarrierColor.value,
      'textCountryNameColor': textCountryNameColor.value,
      'textLabelsColor': textLabelsColor.value,
      'textCountColor': textCountColor.value,
      'textNumberTypeColor': textNumberTypeColor.value,
      'textStirColor': textStirColor.value,
      'textSimCardColor': textSimCardColor.value,
      'textIconLabelColor': textIconLabelColor.value,
      'textIconLocationColor': textIconLocationColor.value,
      'textIconCallTypeColor': textIconCallTypeColor.value,
      'avatarBorderColor': avatarBorderColor.value,
      'nameFontSize': nameFontSize,
      'numberFontSize': numberFontSize,
      'locationFontSize': locationFontSize,
      'carrierFontSize': carrierFontSize,
      'countryNameFontSize': countryNameFontSize,
      'labelsFontSize': labelsFontSize,
      'countFontSize': countFontSize,
      'numberTypeFontSize': numberTypeFontSize,
      'stirFontSize': stirFontSize,
      'simCardFontSize': simCardFontSize,
      'avatarSize': avatarSize,
      'avatarBorderSize': avatarBorderSize,
      'iconSize': iconSize,
      'windowWidth': windowWidth,
      'windowHeight': windowHeight,
      'avatarPosition': avatarPosition.toJson(),
      'namePosition': namePosition.toJson(),
      'carrierPosition': carrierPosition.toJson(),
      'countryNamePosition': countryNamePosition.toJson(),
      'labelsPosition': labelsPosition.toJson(),
      'countPosition': countPosition.toJson(),
      'numberTypePosition': numberTypePosition.toJson(),
      'numberPosition': numberPosition.toJson(),
      'locationPosition': locationPosition.toJson(),
      'callTypePosition': callTypePosition.toJson(),
      'simCardPosition': simCardPosition.toJson(),
      'stirPosition': stirPosition.toJson(),
    };
  }

  /// 从JSON创建实例
  factory CallerIdStyle.fromJson(Map<String, dynamic> json) {
    return CallerIdStyle(
      backgroundColorStart: Color(json['backgroundColorStart']),
      backgroundColorEnd: Color(json['backgroundColorEnd']),
      textNameColor: Color(json['textNameColor']),
      textNumberColor: Color(json['textNumberColor']),
      textLocationColor: Color(json['textLocationColor']),
      textCarrierColor: Color(json['textCarrierColor']),
      textCountryNameColor: Color(json['textCountryNameColor']),
      textLabelsColor: Color(json['textLabelsColor']),
      textCountColor: Color(json['textCountColor']),
      textNumberTypeColor: Color(json['textNumberTypeColor']),
      textStirColor: Color(json['textStirColor'] ?? 0xFF000000),
      textSimCardColor: Color(json['textSimCardColor'] ?? 0xFF000000),
      textIconLabelColor: Color(json['textIconLabelColor'] ?? 0xFFE91E63),
      textIconLocationColor: Color(json['textIconLocationColor'] ?? 0xFF4CAF50),
      textIconCallTypeColor: Color(json['textIconCallTypeColor'] ?? 0xFF4CAF50),
      avatarBorderColor: Color(json['avatarBorderColor'] ?? 0xFF4CAF50),
      nameFontSize: (json['nameFontSize'] as num).toDouble(),
      numberFontSize: (json['numberFontSize'] as num).toDouble(),
      locationFontSize: (json['locationFontSize'] as num).toDouble(),
      carrierFontSize: (json['carrierFontSize'] as num).toDouble(),
      countryNameFontSize: (json['countryNameFontSize'] as num).toDouble(),
      labelsFontSize: (json['labelsFontSize'] as num).toDouble(),
      countFontSize: (json['countFontSize'] as num).toDouble(),
      numberTypeFontSize: (json['numberTypeFontSize'] as num).toDouble(),
      stirFontSize: (json['stirFontSize'] as num?)?.toDouble() ?? 14.0,
      simCardFontSize: (json['simCardFontSize'] as num?)?.toDouble() ?? 14.0,
      avatarSize: (json['avatarSize'] as num).toDouble(),
      avatarBorderSize: (json['avatarBorderSize'] as num?)?.toDouble() ?? 65.0,
      iconSize: (json['iconSize'] as num).toDouble(),
      windowWidth: (json['windowWidth'] as num).toDouble(),
      windowHeight: (json['windowHeight'] as num).toDouble(),
      avatarPosition: PositionOffset.fromJson(json['avatarPosition']),
      namePosition: PositionOffset.fromJson(json['namePosition']),
      carrierPosition: PositionOffset.fromJson(json['carrierPosition']),
      countryNamePosition: PositionOffset.fromJson(json['countryNamePosition']),
      labelsPosition: PositionOffset.fromJson(json['labelsPosition']),
      countPosition: PositionOffset.fromJson(json['countPosition']),
      numberTypePosition: PositionOffset.fromJson(json['numberTypePosition']),
      numberPosition: PositionOffset.fromJson(json['numberPosition']),
      locationPosition: PositionOffset.fromJson(json['locationPosition']),
      callTypePosition: PositionOffset.fromJson(json['callTypePosition']),
      simCardPosition: PositionOffset.fromJson(json['simCardPosition']),
      stirPosition: PositionOffset.fromJson(json['stirPosition']),
    );
  }

  /// 复制并修改部分属性
  CallerIdStyle copyWith({
    Color? backgroundColorStart,
    Color? backgroundColorEnd,
    Color? textNameColor,
    Color? textNumberColor,
    Color? textLocationColor,
    Color? textCarrierColor,
    Color? textCountryNameColor,
    Color? textLabelsColor,
    Color? textCountColor,
    Color? textNumberTypeColor,
    Color? textStirColor,
    Color? textSimCardColor,
    Color? textIconLabelColor,
    Color? textIconLocationColor,
    Color? textIconCallTypeColor,
    Color? avatarBorderColor,
    double? avatarSize,
    double? avatarBorderSize,
    double? iconSize,
    double? windowWidth,
    double? windowHeight,
    double? nameFontSize,
    double? numberFontSize,
    double? locationFontSize,
    double? carrierFontSize,
    double? countryNameFontSize,
    double? labelsFontSize,
    double? countFontSize,
    double? numberTypeFontSize,
    double? stirFontSize,
    double? simCardFontSize,
    PositionOffset? avatarPosition,
    PositionOffset? namePosition,
    PositionOffset? carrierPosition,
    PositionOffset? countryNamePosition,
    PositionOffset? labelsPosition,
    PositionOffset? countPosition,
    PositionOffset? numberTypePosition,
    PositionOffset? numberPosition,
    PositionOffset? locationPosition,
    PositionOffset? callTypePosition,
    PositionOffset? simCardPosition,
    PositionOffset? stirPosition,
  }) {
    return CallerIdStyle(
      backgroundColorStart: backgroundColorStart ?? this.backgroundColorStart,
      backgroundColorEnd: backgroundColorEnd ?? this.backgroundColorEnd,
      textNameColor: textNameColor ?? this.textNameColor,
      textNumberColor: textNumberColor ?? this.textNumberColor,
      textLocationColor: textLocationColor ?? this.textLocationColor,
      textCarrierColor: textCarrierColor ?? this.textCarrierColor,
      textCountryNameColor: textCountryNameColor ?? this.textCountryNameColor,
      textLabelsColor: textLabelsColor ?? this.textLabelsColor,
      textCountColor: textCountColor ?? this.textCountColor,
      textNumberTypeColor: textNumberTypeColor ?? this.textNumberTypeColor,
      textStirColor: textStirColor ?? this.textStirColor,
      textSimCardColor: textSimCardColor ?? this.textSimCardColor,
      textIconLabelColor: textIconLabelColor ?? this.textIconLabelColor,
      textIconLocationColor: textIconLocationColor ?? this.textIconLocationColor,
      textIconCallTypeColor: textIconCallTypeColor ?? this.textIconCallTypeColor,
      avatarBorderColor: avatarBorderColor ?? this.avatarBorderColor,
      avatarSize: avatarSize ?? this.avatarSize,
      avatarBorderSize: avatarBorderSize ?? this.avatarBorderSize,
      iconSize: iconSize ?? this.iconSize,
      windowWidth: windowWidth ?? this.windowWidth,
      windowHeight: windowHeight ?? this.windowHeight,
      nameFontSize: nameFontSize ?? this.nameFontSize,
      numberFontSize: numberFontSize ?? this.numberFontSize,
      locationFontSize: locationFontSize ?? this.locationFontSize,
      carrierFontSize: carrierFontSize ?? this.carrierFontSize,
      countryNameFontSize: countryNameFontSize ?? this.countryNameFontSize,
      labelsFontSize: labelsFontSize ?? this.labelsFontSize,
      countFontSize: countFontSize ?? this.countFontSize,
      numberTypeFontSize: numberTypeFontSize ?? this.numberTypeFontSize,
      stirFontSize: stirFontSize ?? this.stirFontSize,
      simCardFontSize: simCardFontSize ?? this.simCardFontSize,
      avatarPosition: avatarPosition ?? this.avatarPosition,
      namePosition: namePosition ?? this.namePosition,
      carrierPosition: carrierPosition ?? this.carrierPosition,
      countryNamePosition: countryNamePosition ?? this.countryNamePosition,
      labelsPosition: labelsPosition ?? this.labelsPosition,
      countPosition: countPosition ?? this.countPosition,
      numberTypePosition: numberTypePosition ?? this.numberTypePosition,
      numberPosition: numberPosition ?? this.numberPosition,
      locationPosition: locationPosition ?? this.locationPosition,
      callTypePosition: callTypePosition ?? this.callTypePosition,
      simCardPosition: simCardPosition ?? this.simCardPosition,
      stirPosition: stirPosition ?? this.stirPosition,
    );
  }
}