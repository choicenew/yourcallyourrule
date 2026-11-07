import 'package:pyro_media_models/pyro_media_models.dart';

/// 轻量级内存与临时缓存工具 (100% 编译期强类型 MediaEntity 实体与对象缓存)
class TemporaryCache {
  static final Map<String, MediaEntity> _entityCache = {};
  static final Map<String, String> _textCache = {};

  /// 专职存储强类型 MediaEntity 实体对象 (0 dynamic, 0 toMap)
  static void setEntity(String key, MediaEntity entity) {
    if (key.isNotEmpty) {
      _entityCache[key] = entity;
    }
  }

  /// 专职获取强类型 MediaEntity 实体对象
  static MediaEntity? getEntity(String key) {
    return _entityCache[key];
  }

  /// 存储纯文本缓存（如翻译结果文本）
  static void setText(String key, String text) {
    if (key.isNotEmpty && text.isNotEmpty) {
      _textCache[key] = text;
    }
  }

  /// 获取纯文本缓存
  static String? getText(String key) {
    return _textCache[key];
  }

  /// 兼容接口：通用存方法
  static void set(String key, dynamic value) {
    if (value is MediaEntity) {
      setEntity(key, value);
    } else if (value != null) {
      setText(key, value.toString());
    }
  }

  /// 兼容接口：通用取方法
  static dynamic get(String key) {
    return _entityCache[key] ?? _textCache[key];
  }

  static void remove(String key) {
    _entityCache.remove(key);
    _textCache.remove(key);
  }

  static void clear() {
    _entityCache.clear();
    _textCache.clear();
  }
}
