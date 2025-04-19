import 'package:flutter/material.dart';

import 'caller_id_style.dart';
import 'caller_id_style_repository.dart';
import 'caller_id_style_service.dart';
import 'position_offset.dart';

/// 来电显示样式服务实现
class CallerIdStyleServiceImpl implements CallerIdStyleService {
  final CallerIdStyleRepository _repository;

  CallerIdStyleServiceImpl(this._repository);

  @override
  Future<CallerIdStyle> getCurrentStyle() async {
    return await _repository.getCurrentStyle();
  }

  @override
  Future<void> saveStyle(CallerIdStyle style) async {
    await _repository.saveStyle(style);
  }

  @override
  Future<CallerIdStyle> updateBackgroundColors(Color start, Color end) async {
    final currentStyle = await getCurrentStyle();
    final updatedStyle = currentStyle.copyWith(
      backgroundColorStart: start,
      backgroundColorEnd: end,
    );
    await saveStyle(updatedStyle);
    return updatedStyle;
  }

  @override
  Future<CallerIdStyle> updateTextColor(String textType, Color color) async {
    final currentStyle = await getCurrentStyle();
    CallerIdStyle updatedStyle;

    switch (textType) {
      case 'name':
        updatedStyle = currentStyle.copyWith(textNameColor: color);
        break;
      case 'number':
        updatedStyle = currentStyle.copyWith(textNumberColor: color);
        break;
      case 'location':
        updatedStyle = currentStyle.copyWith(textLocationColor: color);
        break;
      case 'carrier':
        updatedStyle = currentStyle.copyWith(textCarrierColor: color);
        break;
      case 'countryName':
        updatedStyle = currentStyle.copyWith(textCountryNameColor: color);
        break;
      case 'labels':
        updatedStyle = currentStyle.copyWith(textLabelsColor: color);
        break;
      case 'count':
        updatedStyle = currentStyle.copyWith(textCountColor: color);
        break;
      case 'numberType':
        updatedStyle = currentStyle.copyWith(textNumberTypeColor: color);
        break;
      case 'stir':
        updatedStyle = currentStyle.copyWith(textStirColor: color);
        break;
      case 'simCard':
        updatedStyle = currentStyle.copyWith(textSimCardColor: color);
        break;
      default:
        return currentStyle;
    }

    await saveStyle(updatedStyle);
    return updatedStyle;
  }

  @override
  Future<CallerIdStyle> updateIconColor(String iconType, Color color) async {
    final currentStyle = await getCurrentStyle();
    CallerIdStyle updatedStyle;

    switch (iconType) {
      case 'label':
        updatedStyle = currentStyle.copyWith(textIconLabelColor: color);
        break;
      case 'location':
        updatedStyle = currentStyle.copyWith(textIconLocationColor: color);
        break;
      case 'callType':
        updatedStyle = currentStyle.copyWith(textIconCallTypeColor: color);
        break;
      case 'avatarBorder':
        updatedStyle = currentStyle.copyWith(avatarBorderColor: color);
        break;
      default:
        return currentStyle;
    }

    await saveStyle(updatedStyle);
    return updatedStyle;
  }

  @override
  Future<CallerIdStyle> updateFontSize(String textType, double size) async {
    final currentStyle = await getCurrentStyle();
    CallerIdStyle updatedStyle;

    switch (textType) {
      case 'name':
        updatedStyle = currentStyle.copyWith(nameFontSize: size);
        break;
      case 'number':
        updatedStyle = currentStyle.copyWith(numberFontSize: size);
        break;
      case 'location':
        updatedStyle = currentStyle.copyWith(locationFontSize: size);
        break;
      case 'carrier':
        updatedStyle = currentStyle.copyWith(carrierFontSize: size);
        break;
      case 'countryName':
        updatedStyle = currentStyle.copyWith(countryNameFontSize: size);
        break;
      case 'labels':
        updatedStyle = currentStyle.copyWith(labelsFontSize: size);
        break;
      case 'count':
        updatedStyle = currentStyle.copyWith(countFontSize: size);
        break;
      case 'numberType':
        updatedStyle = currentStyle.copyWith(numberTypeFontSize: size);
        break;
      case 'stir':
        updatedStyle = currentStyle.copyWith(stirFontSize: size);
        break;
      case 'simCard':
        updatedStyle = currentStyle.copyWith(simCardFontSize: size);
        break;
      default:
        return currentStyle;
    }

    await saveStyle(updatedStyle);
    return updatedStyle;
  }

  @override
  Future<CallerIdStyle> updateElementPosition(String elementType, PositionOffset position) async {
    final currentStyle = await getCurrentStyle();
    CallerIdStyle updatedStyle;

    switch (elementType) {
      case 'avatar':
        updatedStyle = currentStyle.copyWith(avatarPosition: position);
        break;
      case 'name':
        updatedStyle = currentStyle.copyWith(namePosition: position);
        break;
      case 'carrier':
        updatedStyle = currentStyle.copyWith(carrierPosition: position);
        break;
      case 'countryName':
        updatedStyle = currentStyle.copyWith(countryNamePosition: position);
        break;
      case 'labels':
        updatedStyle = currentStyle.copyWith(labelsPosition: position);
        break;
      case 'count':
        updatedStyle = currentStyle.copyWith(countPosition: position);
        break;
      case 'numberType':
        updatedStyle = currentStyle.copyWith(numberTypePosition: position);
        break;
      case 'number':
        updatedStyle = currentStyle.copyWith(numberPosition: position);
        break;
      case 'location':
        updatedStyle = currentStyle.copyWith(locationPosition: position);
        break;
      case 'callType':
        updatedStyle = currentStyle.copyWith(callTypePosition: position);
        break;
      case 'simCard':
        updatedStyle = currentStyle.copyWith(simCardPosition: position);
        break;
      case 'stir':
        updatedStyle = currentStyle.copyWith(stirPosition: position);
        break;
      default:
        return currentStyle;
    }

    await saveStyle(updatedStyle);
    return updatedStyle;
  }

  @override
  Future<CallerIdStyle> updateWindowSize(double width, double height) async {
    final currentStyle = await getCurrentStyle();
    final updatedStyle = currentStyle.copyWith(
      windowWidth: width,
      windowHeight: height,
    );
    await saveStyle(updatedStyle);
    return updatedStyle;
  }

  @override
  Future<bool> exportStyleToFile(String? directoryPath) async {
    final currentStyle = await getCurrentStyle();
    return await _repository.exportStyleToFile(currentStyle, directoryPath);
  }

  @override
  Future<CallerIdStyle?> importStyleFromFile(String filePath) async {
    return await _repository.importStyleFromFile(filePath);
  }

  @override
  Future<CallerIdStyle> importStyleFromJson(String jsonString) async {
    final style = _repository.importStyleFromJson(jsonString);
    await saveStyle(style);
    return style;
  }

  @override
  Future<CallerIdStyle> resetToDefaultStyle() async {
    return await _repository.resetToDefaultStyle();
  }
}