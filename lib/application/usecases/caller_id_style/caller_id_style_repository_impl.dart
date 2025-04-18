import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'caller_id_style.dart';
import 'caller_id_style_repository.dart';

/// 来电显示样式仓库实现
class CallerIdStyleRepositoryImpl implements CallerIdStyleRepository {
  final SharedPreferences _preferences;
  static const String _styleKey = 'caller_id_style';

  CallerIdStyleRepositoryImpl(this._preferences);

  @override
  Future<CallerIdStyle> getCurrentStyle() async {
    try {
      final styleJson = _preferences.getString(_styleKey);
      if (styleJson != null && styleJson.isNotEmpty) {
        return CallerIdStyle.fromJson(json.decode(styleJson));
      }
    } catch (e) {
      // 日志记录错误，但不抛出异常
    }
    // 如果没有保存的样式或解析出错，返回默认样式
    return CallerIdStyle.defaultStyle();
  }

  @override
  Future<void> saveStyle(CallerIdStyle style) async {
    final styleJson = json.encode(style.toJson());
    await _preferences.setString(_styleKey, styleJson);
  }

  @override
  Future<bool> exportStyleToFile(CallerIdStyle style, String? directoryPath) async {
    try {
      final styleJson = json.encode(style.toJson());
      
      // 如果没有指定目录，则使用文件选择器
      String? selectedDirectory = directoryPath;
      selectedDirectory ??= await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        final file = File('$selectedDirectory/caller_id_style.json');
        await file.writeAsString(styleJson);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<CallerIdStyle?> importStyleFromFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final style = importStyleFromJson(jsonString);
        await saveStyle(style);
        return style;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  CallerIdStyle importStyleFromJson(String jsonString) {
    try {
      final Map<String, dynamic> styleMap = json.decode(jsonString);
      return CallerIdStyle.fromJson(styleMap);
    } catch (e) {
      // 如果解析失败，返回默认样式
      return CallerIdStyle.defaultStyle();
    }
  }

  @override
  Future<CallerIdStyle> resetToDefaultStyle() async {
    final defaultStyle = CallerIdStyle.defaultStyle();
    await saveStyle(defaultStyle);
    return defaultStyle;
  }
}