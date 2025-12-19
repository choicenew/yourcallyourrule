// lib/notification_style.dart

import 'package:flutter/material.dart';

class NotificationStyle {
  double avatarWidth, avatarHeight;
  Offset avatarPosition;
  double nameFontSize;
  Color nameColor;
  Offset namePosition;
  double phoneNumFontSize;
  Color phoneNumColor;
  Offset phoneNumPosition;
  double labelFontSize, cityFontSize;
  Color labelColor, cityColor;
  Offset labelPosition, cityPosition;

  // ▼▼▼ 为新文本增加的属性 ▼▼▼
  double alertFontSize;
  Color alertColor;
  Offset alertPosition;

  NotificationStyle({
    this.avatarWidth = 48.0,
    this.avatarHeight = 48.0,
    this.avatarPosition = const Offset(16, 16),
    this.nameFontSize = 18.0,
    this.nameColor = Colors.black,
    this.namePosition = const Offset(80, 20),
    this.phoneNumFontSize = 14.0,
    this.phoneNumColor = Colors.grey,
    this.phoneNumPosition = const Offset(80, 44),
    this.labelFontSize = 12.0,
    this.labelColor = Colors.blue,
    this.labelPosition = const Offset(80, 65),
    this.cityFontSize = 12.0,
    this.cityColor = Colors.blue,
    this.cityPosition = const Offset(130, 65),

    // ▼▼▼ 新属性的默认值 ▼▼▼
    this.alertFontSize = 14.0,
    this.alertColor = Colors.red,
    this.alertPosition = const Offset(16, 95),
  });

  NotificationStyle copyWith({
    double? avatarWidth,
    double? avatarHeight,
    Offset? avatarPosition,
    double? nameFontSize,
    Color? nameColor,
    Offset? namePosition,
    double? phoneNumFontSize,
    Color? phoneNumColor,
    Offset? phoneNumPosition,
    double? labelFontSize,
    Color? labelColor,
    Offset? labelPosition,
    double? cityFontSize,
    Color? cityColor,
    Offset? cityPosition,
    
    // ▼▼▼ 为 copyWith 增加新属性 ▼▼▼
    double? alertFontSize,
    Color? alertColor,
    Offset? alertPosition,
  }) {
    return NotificationStyle(
      avatarWidth: avatarWidth ?? this.avatarWidth,
      avatarHeight: avatarHeight ?? this.avatarHeight,
      avatarPosition: avatarPosition ?? this.avatarPosition,
      nameFontSize: nameFontSize ?? this.nameFontSize,
      nameColor: nameColor ?? this.nameColor,
      namePosition: namePosition ?? this.namePosition,
      phoneNumFontSize: phoneNumFontSize ?? this.phoneNumFontSize,
      phoneNumColor: phoneNumColor ?? this.phoneNumColor,
      phoneNumPosition: phoneNumPosition ?? this.phoneNumPosition,
      labelFontSize: labelFontSize ?? this.labelFontSize,
      labelColor: labelColor ?? this.labelColor,
      labelPosition: labelPosition ?? this.labelPosition,
      cityFontSize: cityFontSize ?? this.cityFontSize,
      cityColor: cityColor ?? this.cityColor,
      cityPosition: cityPosition ?? this.cityPosition,
      
      // ▼▼▼ copyWith 的新属性逻辑 ▼▼▼
      alertFontSize: alertFontSize ?? this.alertFontSize,
      alertColor: alertColor ?? this.alertColor,
      alertPosition: alertPosition ?? this.alertPosition,
    );
  }
}