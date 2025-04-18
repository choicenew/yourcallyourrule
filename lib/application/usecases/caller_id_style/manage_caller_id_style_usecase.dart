import 'caller_id_style.dart';
import 'caller_id_style_service.dart';
import 'position_offset.dart';
import 'package:flutter/material.dart';

/// 管理来电显示样式用例
/// 封装了对来电显示样式的所有操作
class ManageCallerIdStyleUseCase {
  final CallerIdStyleService _styleService;

  ManageCallerIdStyleUseCase(this._styleService);

  /// 获取当前样式
  Future<CallerIdStyle> getCurrentStyle() {
    return _styleService.getCurrentStyle();
  }

  /// 保存样式
  Future<void> saveStyle(CallerIdStyle style) {
    return _styleService.saveStyle(style);
  }

  /// 更新背景颜色
  Future<CallerIdStyle> updateBackgroundColors(Color start, Color end) {
    return _styleService.updateBackgroundColors(start, end);
  }

  /// 更新文本颜色
  Future<CallerIdStyle> updateTextColor(String textType, Color color) {
    return _styleService.updateTextColor(textType, color);
  }

  /// 更新图标颜色
  Future<CallerIdStyle> updateIconColor(String iconType, Color color) {
    return _styleService.updateIconColor(iconType, color);
  }

  /// 更新字体大小
  Future<CallerIdStyle> updateFontSize(String textType, double size) {
    return _styleService.updateFontSize(textType, size);
  }

  /// 更新元素位置
  Future<CallerIdStyle> updateElementPosition(String elementType, PositionOffset position) {
    return _styleService.updateElementPosition(elementType, position);
  }

  /// 更新窗口大小
  Future<CallerIdStyle> updateWindowSize(double width, double height) {
    return _styleService.updateWindowSize(width, height);
  }

  /// 导出样式到文件
  Future<bool> exportStyleToFile(String? directoryPath) {
    return _styleService.exportStyleToFile(directoryPath);
  }

  /// 从文件导入样式
  Future<CallerIdStyle?> importStyleFromFile(String filePath) {
    return _styleService.importStyleFromFile(filePath);
  }

  /// 从JSON字符串导入样式
  Future<CallerIdStyle> importStyleFromJson(String jsonString) {
    return _styleService.importStyleFromJson(jsonString);
  }

  /// 重置为默认样式
  Future<CallerIdStyle> resetToDefaultStyle() {
    return _styleService.resetToDefaultStyle();
  }
}