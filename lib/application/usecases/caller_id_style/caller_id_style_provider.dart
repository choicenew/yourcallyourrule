import 'package:flutter/material.dart';

import 'caller_id_style.dart';
import 'caller_id_style_service.dart';
import 'position_offset.dart';

/// 来电显示样式Provider
/// 适配原有的CallerIdStyleProvider到新的干净架构
class CallerIdStyleProvider with ChangeNotifier {
  final CallerIdStyleService _styleService;
  CallerIdStyle _currentStyle;

  CallerIdStyleProvider(this._styleService)
      : _currentStyle = CallerIdStyle.defaultStyle();

  // 初始化方法
  Future<void> initialize() async {
    _currentStyle = await _styleService.getCurrentStyle();
    notifyListeners();
  }

  // Getters
  Color get backgroundColorStart => _currentStyle.backgroundColorStart;
  Color get backgroundColorEnd => _currentStyle.backgroundColorEnd;

  Color get textIconLabelColor => _currentStyle.textIconLabelColor;
  Color get textIconLocationColor => _currentStyle.textIconLocationColor;
  Color get textIconCallTypeColor => _currentStyle.textIconCallTypeColor;

  Color get avatarBorderColor => _currentStyle.avatarBorderColor;

  Color get textLabelsColor => _currentStyle.textLabelsColor;
  Color get textCountryNameColor => _currentStyle.textCountryNameColor;
  Color get textCarrierColor => _currentStyle.textCarrierColor;
  Color get textNumberTypeColor => _currentStyle.textNumberTypeColor;
  Color get textNameColor => _currentStyle.textNameColor;
  Color get textNumberColor => _currentStyle.textNumberColor;
  Color get textCountColor => _currentStyle.textCountColor;
  Color get textLocationColor => _currentStyle.textLocationColor;
  Color get textStirColor => _currentStyle.textStirColor;
  Color get textSimCardColor => _currentStyle.textSimCardColor;

  double get avatarSize => _currentStyle.avatarSize;
  double get avatarBorderSize => _currentStyle.avatarBorderSize;
  double get iconSize => _currentStyle.iconSize;
  
  double get nameFontSize => _currentStyle.nameFontSize;
  double get carrierFontSize => _currentStyle.carrierFontSize;
  double get countryNameFontSize => _currentStyle.countryNameFontSize;
  double get labelsFontSize => _currentStyle.labelsFontSize;
  double get countFontSize => _currentStyle.countFontSize;
  double get numberTypeFontSize => _currentStyle.numberTypeFontSize;
  double get numberFontSize => _currentStyle.numberFontSize;
  double get locationFontSize => _currentStyle.locationFontSize;
  double get stirFontSize => _currentStyle.stirFontSize;
  double get simCardFontSize => _currentStyle.simCardFontSize;

  double get windowWidth => _currentStyle.windowWidth;
  double get windowHeight => _currentStyle.windowHeight;

  Offset get avatarPosition => Offset(_currentStyle.avatarPosition.dx, _currentStyle.avatarPosition.dy);
  Offset get namePosition => Offset(_currentStyle.namePosition.dx, _currentStyle.namePosition.dy);
  Offset get carrierPosition => Offset(_currentStyle.carrierPosition.dx, _currentStyle.carrierPosition.dy);
  Offset get countryNamePosition => Offset(_currentStyle.countryNamePosition.dx, _currentStyle.countryNamePosition.dy);
  Offset get labelsPosition => Offset(_currentStyle.labelsPosition.dx, _currentStyle.labelsPosition.dy);
  Offset get countPosition => Offset(_currentStyle.countPosition.dx, _currentStyle.countPosition.dy);
  Offset get numberTypePosition => Offset(_currentStyle.numberTypePosition.dx, _currentStyle.numberTypePosition.dy);
  Offset get numberPosition => Offset(_currentStyle.numberPosition.dx, _currentStyle.numberPosition.dy);
  Offset get locationPosition => Offset(_currentStyle.locationPosition.dx, _currentStyle.locationPosition.dy);
  Offset get callTypePosition => Offset(_currentStyle.callTypePosition.dx, _currentStyle.callTypePosition.dy);
  Offset get simCardPosition => Offset(_currentStyle.simCardPosition.dx, _currentStyle.simCardPosition.dy);
  Offset get stirPosition => Offset(_currentStyle.stirPosition.dx, _currentStyle.stirPosition.dy);

  // Setters with notifyListeners
  void setBackgroundColorStart(Color color) async {
    _currentStyle = await _styleService.updateBackgroundColors(color, _currentStyle.backgroundColorEnd);
    notifyListeners();
  }

  void setBackgroundColorEnd(Color color) async {
    _currentStyle = await _styleService.updateBackgroundColors(_currentStyle.backgroundColorStart, color);
    notifyListeners();
  }

  void setTextIconLabelColor(Color color) async {
    _currentStyle = await _styleService.updateIconColor('label', color);
    notifyListeners();
  }

  void setTextIconLocationColor(Color color) async {
    _currentStyle = await _styleService.updateIconColor('location', color);
    notifyListeners();
  }

  void setTextIconCallTypeColor(Color color) async {
    _currentStyle = await _styleService.updateIconColor('callType', color);
    notifyListeners();
  }

  void setAvatarBorderColor(Color color) async {
    _currentStyle = await _styleService.updateIconColor('avatarBorder', color);
    notifyListeners();
  }

  void setTextLabelsColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('labels', color);
    notifyListeners();
  }

  void setTextCountryNameColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('countryName', color);
    notifyListeners();
  }

  void setTextCarrierColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('carrier', color);
    notifyListeners();
  }

  void setTextNumberTypeColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('numberType', color);
    notifyListeners();
  }

  void setTextNameColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('name', color);
    notifyListeners();
  }

  void setTextNumberColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('number', color);
    notifyListeners();
  }

  void setTextCountColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('count', color);
    notifyListeners();
  }

  void setTextLocationColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('location', color);
    notifyListeners();
  }

  void setTextStirColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('stir', color);
    notifyListeners();
  }

  void setTextSimCardColor(Color color) async {
    _currentStyle = await _styleService.updateTextColor('simCard', color);
    notifyListeners();
  }

  void setNameFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('name', size);
    notifyListeners();
  }

  void setNumberFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('number', size);
    notifyListeners();
  }

  void setLocationFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('location', size);
    notifyListeners();
  }

  void setCarrierFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('carrier', size);
    notifyListeners();
  }

  void setCountryNameFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('countryName', size);
    notifyListeners();
  }

  void setLabelsFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('labels', size);
    notifyListeners();
  }

  void setCountFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('count', size);
    notifyListeners();
  }

  void setNumberTypeFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('numberType', size);
    notifyListeners();
  }

  void setStirFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('stir', size);
    notifyListeners();
  }

  void setSimCardFontSize(double size) async {
    _currentStyle = await _styleService.updateFontSize('simCard', size);
    notifyListeners();
  }

  void setAvatarSize(double size) async {
    _currentStyle = _currentStyle.copyWith(avatarSize: size);
    await _styleService.saveStyle(_currentStyle);
    notifyListeners();
  }

  void setAvatarBorderSize(double size) async {
    _currentStyle = _currentStyle.copyWith(avatarBorderSize: size);
    await _styleService.saveStyle(_currentStyle);
    notifyListeners();
  }

  void setIconSize(double size) async {
    _currentStyle = _currentStyle.copyWith(iconSize: size);
    await _styleService.saveStyle(_currentStyle);
    notifyListeners();
  }

  void setWindowSize(double width, double height) async {
    _currentStyle = await _styleService.updateWindowSize(width, height);
    notifyListeners();
  }

  void updateAvatarPosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'avatar', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateNamePosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'name', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateCarrierPosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'carrier', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateCountryNamePosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'countryName', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateLabelsPosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'labels', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateCountPosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'count', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateNumberTypePosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'numberType', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateNumberPosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'number', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateLocationPosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'location', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateCallTypePosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'callType', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateSimCardPosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'simCard', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  void updateStirPosition(Offset position) async {
    _currentStyle = await _styleService.updateElementPosition(
        'stir', PositionOffset(dx: position.dx, dy: position.dy));
    notifyListeners();
  }

  // 导出配置
  Future<bool> exportConfiguration([String? directoryPath]) async {
    return await _styleService.exportStyleToFile(directoryPath);
  }

  // 导入配置
  Future<void> importConfiguration(String filePath) async {
    final style = await _styleService.importStyleFromFile(filePath);
    if (style != null) {
      _currentStyle = style;
      notifyListeners();
    }
  }

  // 从JSON导入配置
  Future<void> importConfigurationFromJson(String jsonString) async {
    _currentStyle = await _styleService.importStyleFromJson(jsonString);
    notifyListeners();
  }

  // 重置为默认配置
  Future<void> resetToDefaultConfiguration() async {
    _currentStyle = await _styleService.resetToDefaultStyle();
    notifyListeners();
  }
}