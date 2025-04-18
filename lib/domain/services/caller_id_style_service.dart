import 'dart:async';

import '../entities/caller/caller_id_style.dart';

/// 来电显示样式服务接口
abstract class ICallerIdStyleService {
  /// 获取当前样式
  CallerIdStyle get currentStyle;
  
  /// 保存样式配置
  Future<void> saveConfiguration(CallerIdStyle style);
  
  /// 加载样式配置
  Future<CallerIdStyle> loadConfiguration();
  
  /// 从文件导入样式配置
  Future<CallerIdStyle> importConfiguration(String filePath);
  
  /// 导出样式配置到文件
  Future<void> exportConfiguration(CallerIdStyle style, String filePath);
  
  /// 重置为默认样式
  Future<CallerIdStyle> resetToDefault();
}