import 'package:hetu_script/hetu_script.dart';

/// 针对 [HTStruct] 的扩展维护工具，简化河图结构体与 Dart 数据的互转
extension PyroHetuStructExtension on HTStruct {
  /// 转换为标准的 Dart Map
  Map<String, dynamic> toDartMap() {
    return toJSON();
  }

  /// 安全获取指定类型的字段值
  T? getField<T>(String key) {
    if (!containsKey(key)) return null;
    final val = this[key];
    if (val is T) return val;
    return null;
  }

  /// 批量合并 Dart 字典字段
  void assignFromMap(Map<String, dynamic> map) {
    for (final entry in map.entries) {
      this[entry.key] = entry.value;
    }
  }
}
