import 'package:flutter/material.dart';

/// 来电显示样式提供者
/// 管理来电显示界面的所有样式属性，包括颜色、字体大小、位置等
class CallerIdStyleProvider with ChangeNotifier {
  // 背景颜色
  Color _backgroundColorStart = const Color.fromARGB(255, 255, 227, 227);
  Color _backgroundColorEnd = const Color.fromARGB(255, 255, 227, 227);

  // 图标颜色
  Color _textIconLabelColor = const Color.fromARGB(255, 233, 30, 99);
  Color _textIconLocationColor = const Color.fromARGB(255, 76, 175, 80);
  Color _textIconCallTypeColor = const Color.fromARGB(255, 76, 175, 80); // calltype 的icon颜色

  // 头像边框颜色
  Color _avatarBorderColor = const Color.fromARGB(255, 76, 175, 80);

  // 文本颜色
  Color _textLabelsColor = const Color.fromARGB(255, 0, 0, 0);
  Color _textCountryNameColor = const Color.fromARGB(255, 0, 0, 0);
  Color _textCarrierColor = const Color.fromARGB(255, 0, 0, 0);
  Color _textNumberTypeColor = const Color.fromARGB(255, 0, 0, 0);
  Color _textNameColor = const Color.fromARGB(255, 0, 0, 0);
  Color _textNumberColor = const Color.fromARGB(255, 0, 0, 0);
  Color _textCountColor = const Color.fromARGB(255, 0, 0, 0);
  Color _textLocationColor = const Color.fromARGB(255, 0, 0, 0);
  Color _textStirColor = const Color.fromARGB(255, 0, 0, 0); // stir文字颜色
  Color _textSimCardColor = const Color.fromARGB(255, 0, 0, 0); // sim card 文字颜色

  // 尺寸
  double _avatarSize = 60;
  double _avatarBorderSize = 65;
  double _iconSize = 20;
  
  // 字体大小
  double _nameFontSize = 18;
  double _carrierFontSize = 18;
  double _countryNameFontSize = 18;
  double _labelsFontSize = 18;
  double _countFontSize = 18;
  double _numberTypeFontSize = 18;
  double _numberFontSize = 16;
  double _locationFontSize = 14;
  double _stirFontSize = 14; // stir文字size
  double _simCardFontSize = 14; // sim card 文字size

  // 窗口尺寸
  double _windowWidth = 330;
  double _windowHeight = 220;

  // 元素位置
  Offset _avatarPosition = const Offset(10, 10);
  Offset _countryNamePosition = const Offset(100, 10);
  Offset _numberTypePosition = const Offset(100, 30);
  Offset _namePosition = const Offset(80, 50);
  Offset _carrierPosition = const Offset(80, 70);
  Offset _locationPosition = const Offset(10, 100);
  Offset _labelsPosition = const Offset(20, 130);
  Offset _countPosition = const Offset(110, 110);
  Offset _numberPosition = const Offset(80, 150);
  Offset _callTypePosition = const Offset(60, 150); // calltype 位置
  Offset _simCardPosition = const Offset(150, 170);  // simcard 位置
  Offset _stirPosition = const Offset(200, 130);  // stir 位置
  Offset _securityMessagePosition = const Offset(10, 190);  // 安全消息位置

  // Getters
  Color get backgroundColorStart => _backgroundColorStart;
  Color get backgroundColorEnd => _backgroundColorEnd;

  Color get textIconLabelColor => _textIconLabelColor;
  Color get textIconLocationColor => _textIconLocationColor;
  Color get textIconCallTypeColor => _textIconCallTypeColor;  // calltype 的icon颜色

  Color get avatarBorderColor => _avatarBorderColor;

  Color get textLabelsColor => _textLabelsColor;
  Color get textCountryNameColor => _textCountryNameColor;
  Color get textCarrierColor => _textCarrierColor;
  Color get textNumberTypeColor => _textNumberTypeColor;
  Color get textNameColor => _textNameColor;
  Color get textNumberColor => _textNumberColor;
  Color get textCountColor => _textCountColor;
  Color get textLocationColor => _textLocationColor;
  Color get textStirColor => _textStirColor; // stir文字颜色
  Color get textSimCardColor => _textSimCardColor; // sim card 文字颜色   

  double get avatarSize => _avatarSize;
  double get avatarBorderSize => _avatarBorderSize;  
  double get iconSize => _iconSize;
  
  double get nameFontSize => _nameFontSize;
  double get carrierFontSize => _carrierFontSize;
  double get countryNameFontSize => _countryNameFontSize;
  double get labelsFontSize => _labelsFontSize;
  double get countFontSize => _countFontSize;
  double get numberTypeFontSize => _numberTypeFontSize;
  double get numberFontSize => _numberFontSize;
  double get locationFontSize => _locationFontSize;
  double get stirFontSize => _stirFontSize;   // stir文字size
  double get simCardFontSize => _simCardFontSize; // sim card 文字size

  double get windowWidth => _windowWidth;
  double get windowHeight => _windowHeight;

  Offset get avatarPosition => _avatarPosition;
  Offset get namePosition => _namePosition;
  Offset get carrierPosition => _carrierPosition;
  Offset get countryNamePosition => _countryNamePosition;
  Offset get labelsPosition => _labelsPosition;
  Offset get countPosition => _countPosition;
  Offset get numberTypePosition => _numberTypePosition;
  Offset get numberPosition => _numberPosition;
  Offset get locationPosition => _locationPosition;
  Offset get callTypePosition => _callTypePosition;      // calltype 位置
  Offset get simCardPosition => _simCardPosition;  // simcard 位置
  Offset get stirPosition => _stirPosition;  // stir 位置
  Offset get securityMessagePosition => _securityMessagePosition;  // 安全消息位置

  // Setters with notifyListeners
  void setBackgroundColorStart(Color color) {
    _backgroundColorStart = color;
    notifyListeners();
  }

  void setBackgroundColorEnd(Color color) {
    _backgroundColorEnd = color;
    notifyListeners();
  }

  void setTextIconLabelColor(Color color) {
    _textIconLabelColor = color;
    notifyListeners();
  }

  void setTextIconLocationColor(Color color) {
    _textIconLocationColor = color;
    notifyListeners();
  }

  void setTextIconCallTypeColor(Color color) {
    _textIconCallTypeColor = color;
    notifyListeners();
  }

  void setAvatarBorderColor(Color color) {
    _avatarBorderColor = color;
    notifyListeners();
  }

  void setTextLabelsColor(Color color) {
    _textLabelsColor = color;
    notifyListeners();
  }

  void setTextCountryNameColor(Color color) {
    _textCountryNameColor = color;
    notifyListeners();
  }

  void setTextCarrierColor(Color color) {
    _textCarrierColor = color;
    notifyListeners();
  }

  void setTextNumberTypeColor(Color color) {
    _textNumberTypeColor = color;
    notifyListeners();
  }

  void setTextNameColor(Color color) {
    _textNameColor = color;
    notifyListeners();
  }

  void setTextNumberColor(Color color) {
    _textNumberColor = color;
    notifyListeners();
  }

  void setTextCountColor(Color color) {
    _textCountColor = color;
    notifyListeners();
  }

  void setTextLocationColor(Color color) {
    _textLocationColor = color;
    notifyListeners();
  }

  void setTextStirColor(Color color) {
    _textStirColor = color;
    notifyListeners();
  }

  void setTextSimCardColor(Color color) {
    _textSimCardColor = color;
    notifyListeners();
  }

  void setAvatarSize(double size) {
    _avatarSize = size;
    notifyListeners();
  }

  void setAvatarBorderSize(double size) {
    _avatarBorderSize = size;
    notifyListeners();
  }

  void setIconSize(double size) {
    _iconSize = size;
    notifyListeners();
  }

  void setNameFontSize(double size) {
    _nameFontSize = size;
    notifyListeners();
  }

  void setCarrierFontSize(double size) {
    _carrierFontSize = size;
    notifyListeners();
  }

  void setCountryNameFontSize(double size) {
    _countryNameFontSize = size;
    notifyListeners();
  }

  void setLabelsFontSize(double size) {
    _labelsFontSize = size;
    notifyListeners();
  }

  void setCountFontSize(double size) {
    _countFontSize = size;
    notifyListeners();
  }

  void setNumberTypeFontSize(double size) {
    _numberTypeFontSize = size;
    notifyListeners();
  }

  void setNumberFontSize(double size) {
    _numberFontSize = size;
    notifyListeners();
  }

  void setLocationFontSize(double size) {
    _locationFontSize = size;
    notifyListeners();
  }

  void setStirFontSize(double size) {
    _stirFontSize = size;
    notifyListeners();
  }

  void setSimCardFontSize(double size) {
    _simCardFontSize = size;
    notifyListeners();
  }

  void setWindowSize(double width, double height) {
    _windowWidth = width;
    _windowHeight = height;
    notifyListeners();
  }

  // Update position methods
  void updateAvatarPosition(Offset newPosition) {
    _avatarPosition = newPosition;
    notifyListeners();
  }

  void updateNamePosition(Offset newPosition) {
    _namePosition = newPosition;
    notifyListeners();
  }

  void updateCarrierPosition(Offset newPosition) {
    _carrierPosition = newPosition;
    notifyListeners();
  }

  void updateCountryNamePosition(Offset newPosition) {
    _countryNamePosition = newPosition;
    notifyListeners();
  }

  void updateLabelsPosition(Offset newPosition) {
    _labelsPosition = newPosition;
    notifyListeners();
  }

  void updateCountPosition(Offset newPosition) {
    _countPosition = newPosition;
    notifyListeners();
  }

  void updateNumberTypePosition(Offset newPosition) {
    _numberTypePosition = newPosition;
    notifyListeners();
  }

  void updateNumberPosition(Offset newPosition) {
    _numberPosition = newPosition;
    notifyListeners();
  }

  void updateLocationPosition(Offset newPosition) {
    _locationPosition = newPosition;
    notifyListeners();
  }

  void updateCallTypePosition(Offset newPosition) {
    _callTypePosition = newPosition;
    notifyListeners();
  }

  void updateSimCardPosition(Offset newPosition) {
    _simCardPosition = newPosition;
    notifyListeners();
  }

  void updateStirPosition(Offset newPosition) {
    _stirPosition = newPosition;
    notifyListeners();
  }

  void updateSecurityMessagePosition(Offset newPosition) {
    _securityMessagePosition = newPosition;
    notifyListeners();
  }
}