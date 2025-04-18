import 'package:flutter/material.dart';

/// 来电显示样式提供者实体类
class CallerIdStyle {
  // 窗口尺寸
  double windowWidth;
  double windowHeight;
  
  // 背景渐变颜色
  Color backgroundColorStart;
  Color backgroundColorEnd;
  
  // 文本颜色
  Color textNameColor;
  Color textPhoneColor;
  Color textCountryColor;
  Color textRegionColor;
  Color textCarrierColor;
  Color textLabelColor;
  Color textCountColor;
  Color textNumberTypeColor;
  
  // 字体大小
  double nameFontSize;
  double phoneFontSize;
  double countryFontSize;
  double regionFontSize;
  double carrierFontSize;
  double labelFontSize;
  double countFontSize;
  double numberTypeFontSize;
  
  // 头像和图标尺寸
  double avatarSize;
  double avatarBorderSize;
  Color avatarBorderColor;
  
  // 元素位置
  Offset avatarPosition;
  Offset namePosition;
  Offset phonePosition;
  Offset countryPosition;
  Offset regionPosition;
  Offset carrierPosition;
  Offset labelPosition;
  Offset countPosition;
  Offset numberTypePosition;
  
  CallerIdStyle({
    this.windowWidth = 300,
    this.windowHeight = 400,
    this.backgroundColorStart = const Color(0xFF2196F3),
    this.backgroundColorEnd = const Color(0xFF4CAF50),
    this.textNameColor = Colors.white,
    this.textPhoneColor = Colors.white,
    this.textCountryColor = Colors.white,
    this.textRegionColor = Colors.white,
    this.textCarrierColor = Colors.white,
    this.textLabelColor = Colors.white,
    this.textCountColor = Colors.white,
    this.textNumberTypeColor = Colors.white,
    this.nameFontSize = 18,
    this.phoneFontSize = 16,
    this.countryFontSize = 14,
    this.regionFontSize = 14,
    this.carrierFontSize = 14,
    this.labelFontSize = 14,
    this.countFontSize = 14,
    this.numberTypeFontSize = 14,
    this.avatarSize = 80,
    this.avatarBorderSize = 90,
    this.avatarBorderColor = Colors.white,
    this.avatarPosition = const Offset(50, 50),
    this.namePosition = const Offset(150, 50),
    this.phonePosition = const Offset(150, 80),
    this.countryPosition = const Offset(150, 110),
    this.regionPosition = const Offset(150, 140),
    this.carrierPosition = const Offset(150, 170),
    this.labelPosition = const Offset(150, 200),
    this.countPosition = const Offset(150, 230),
    this.numberTypePosition = const Offset(150, 260),
  });
  
  /// 将 CallerIdStyle 对象转换为 Map
  Map<String, dynamic> toJson() {
    return {
      'windowWidth': windowWidth,
      'windowHeight': windowHeight,
      'backgroundColorStart': backgroundColorStart.value,
      'backgroundColorEnd': backgroundColorEnd.value,
      'textNameColor': textNameColor.value,
      'textPhoneColor': textPhoneColor.value,
      'textCountryColor': textCountryColor.value,
      'textRegionColor': textRegionColor.value,
      'textCarrierColor': textCarrierColor.value,
      'textLabelColor': textLabelColor.value,
      'textCountColor': textCountColor.value,
      'textNumberTypeColor': textNumberTypeColor.value,
      'nameFontSize': nameFontSize,
      'phoneFontSize': phoneFontSize,
      'countryFontSize': countryFontSize,
      'regionFontSize': regionFontSize,
      'carrierFontSize': carrierFontSize,
      'labelFontSize': labelFontSize,
      'countFontSize': countFontSize,
      'numberTypeFontSize': numberTypeFontSize,
      'avatarSize': avatarSize,
      'avatarBorderSize': avatarBorderSize,
      'avatarBorderColor': avatarBorderColor.value,
      'avatarPositionDx': avatarPosition.dx,
      'avatarPositionDy': avatarPosition.dy,
      'namePositionDx': namePosition.dx,
      'namePositionDy': namePosition.dy,
      'phonePositionDx': phonePosition.dx,
      'phonePositionDy': phonePosition.dy,
      'countryPositionDx': countryPosition.dx,
      'countryPositionDy': countryPosition.dy,
      'regionPositionDx': regionPosition.dx,
      'regionPositionDy': regionPosition.dy,
      'carrierPositionDx': carrierPosition.dx,
      'carrierPositionDy': carrierPosition.dy,
      'labelPositionDx': labelPosition.dx,
      'labelPositionDy': labelPosition.dy,
      'countPositionDx': countPosition.dx,
      'countPositionDy': countPosition.dy,
      'numberTypePositionDx': numberTypePosition.dx,
      'numberTypePositionDy': numberTypePosition.dy,
    };
  }
  
  /// 从 Map 创建 CallerIdStyle 对象
  factory CallerIdStyle.fromJson(Map<String, dynamic> json) {
    return CallerIdStyle(
      windowWidth: json['windowWidth'] as double,
      windowHeight: json['windowHeight'] as double,
      backgroundColorStart: Color(json['backgroundColorStart'] as int),
      backgroundColorEnd: Color(json['backgroundColorEnd'] as int),
      textNameColor: Color(json['textNameColor'] as int),
      textPhoneColor: Color(json['textPhoneColor'] as int),
      textCountryColor: Color(json['textCountryColor'] as int),
      textRegionColor: Color(json['textRegionColor'] as int),
      textCarrierColor: Color(json['textCarrierColor'] as int),
      textLabelColor: Color(json['textLabelColor'] as int),
      textCountColor: Color(json['textCountColor'] as int),
      textNumberTypeColor: Color(json['textNumberTypeColor'] as int),
      nameFontSize: json['nameFontSize'] as double,
      phoneFontSize: json['phoneFontSize'] as double,
      countryFontSize: json['countryFontSize'] as double,
      regionFontSize: json['regionFontSize'] as double,
      carrierFontSize: json['carrierFontSize'] as double,
      labelFontSize: json['labelFontSize'] as double,
      countFontSize: json['countFontSize'] as double,
      numberTypeFontSize: json['numberTypeFontSize'] as double,
      avatarSize: json['avatarSize'] as double,
      avatarBorderSize: json['avatarBorderSize'] as double,
      avatarBorderColor: Color(json['avatarBorderColor'] as int),
      avatarPosition: Offset(
        json['avatarPositionDx'] as double,
        json['avatarPositionDy'] as double,
      ),
      namePosition: Offset(
        json['namePositionDx'] as double,
        json['namePositionDy'] as double,
      ),
      phonePosition: Offset(
        json['phonePositionDx'] as double,
        json['phonePositionDy'] as double,
      ),
      countryPosition: Offset(
        json['countryPositionDx'] as double,
        json['countryPositionDy'] as double,
      ),
      regionPosition: Offset(
        json['regionPositionDx'] as double,
        json['regionPositionDy'] as double,
      ),
      carrierPosition: Offset(
        json['carrierPositionDx'] as double,
        json['carrierPositionDy'] as double,
      ),
      labelPosition: Offset(
        json['labelPositionDx'] as double,
        json['labelPositionDy'] as double,
      ),
      countPosition: Offset(
        json['countPositionDx'] as double,
        json['countPositionDy'] as double,
      ),
      numberTypePosition: Offset(
        json['numberTypePositionDx'] as double,
        json['numberTypePositionDy'] as double,
      ),
    );
  }
  
  // 更新位置方法
  void updateAvatarPosition(Offset position) {
    avatarPosition = position;
  }
  
  void updateNamePosition(Offset position) {
    namePosition = position;
  }
  
  void updatePhonePosition(Offset position) {
    phonePosition = position;
  }
  
  void updateCountryPosition(Offset position) {
    countryPosition = position;
  }
  
  void updateRegionPosition(Offset position) {
    regionPosition = position;
  }
  
  void updateCarrierPosition(Offset position) {
    carrierPosition = position;
  }
  
  void updateLabelPosition(Offset position) {
    labelPosition = position;
  }
  
  void updateCountPosition(Offset position) {
    countPosition = position;
  }
  
  void updateNumberTypePosition(Offset position) {
    numberTypePosition = position;
  }
}