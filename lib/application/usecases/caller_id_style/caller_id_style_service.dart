import 'dart:async';
import 'package:flutter/material.dart';
import 'caller_id_style.dart';
import 'position_offset.dart';

/// 来电显示样式服务接口
/// 定义了来电显示样式的业务逻辑
abstract class CallerIdStyleService {
  /// 获取当前样式
  Future<CallerIdStyle> getCurrentStyle();

  /// 保存样式
  Future<void> saveStyle(CallerIdStyle style);

  /// 更新背景颜色
  Future<CallerIdStyle> updateBackgroundColors(Color start, Color end);

  /// 更新文本颜色
  Future<CallerIdStyle> updateTextColor(String textType, Color color);

  /// 更新图标颜色
  Future<CallerIdStyle> updateIconColor(String iconType, Color color);

  /// 更新字体大小
  Future<CallerIdStyle> updateFontSize(String textType, double size);

  /// 更新元素位置
  Future<CallerIdStyle> updateElementPosition(String elementType, PositionOffset position);

  /// 更新窗口大小
  Future<CallerIdStyle> updateWindowSize(double width, double height);

  /// 导出样式到文件
  Future<bool> exportStyleToFile(String? directoryPath);

  /// 从文件导入样式
  Future<CallerIdStyle?> importStyleFromFile(String filePath);

  /// 从JSON字符串导入样式
  Future<CallerIdStyle> importStyleFromJson(String jsonString);

  /// 重置为默认样式
  Future<CallerIdStyle> resetToDefaultStyle();
}