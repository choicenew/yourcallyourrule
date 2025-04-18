import 'dart:async';
import 'caller_id_style.dart';

/// 来电显示样式仓库接口
/// 定义了来电显示样式的存储和检索方法
abstract class CallerIdStyleRepository {
  /// 获取当前样式
  Future<CallerIdStyle> getCurrentStyle();

  /// 保存样式
  Future<void> saveStyle(CallerIdStyle style);

  /// 导出样式到文件
  Future<bool> exportStyleToFile(CallerIdStyle style, String? directoryPath);

  /// 从文件导入样式
  Future<CallerIdStyle?> importStyleFromFile(String filePath);

  /// 从JSON字符串导入样式
  CallerIdStyle importStyleFromJson(String jsonString);

  /// 重置为默认样式
  Future<CallerIdStyle> resetToDefaultStyle();
}