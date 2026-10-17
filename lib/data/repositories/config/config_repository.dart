import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ConfigRepository {
  Future<Map<String, dynamic>?> getConfig(String key);
  Future<void> saveConfig(String key, Map<String, dynamic> config);
  Future<void> removeConfig(String key);
}

/// 使用 SharedPreferences 实现的配置仓库（带原生 PlatformException 安全容错）
class SharedPreferencesConfigRepository implements ConfigRepository {
  /// 获取配置
  @override
  Future<Map<String, dynamic>?> getConfig(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      try {
        await prefs.reload();
      } catch (_) {}
      
      final String? jsonString = prefs.getString(key);
      if (jsonString != null) {
        try {
          return jsonDecode(jsonString) as Map<String, dynamic>;
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      debugPrint('[SharedPreferencesConfigRepository] PlatformException ignored for $key: $e');
    }
    return null;
  }
    
  @override
  Future<void> saveConfig(String key, Map<String, dynamic> config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(config);
      await prefs.setString(key, jsonString);
    } catch (e) {
      debugPrint('[SharedPreferencesConfigRepository] Error saving config for $key: $e');
    }
  }
  
  @override
  Future<void> removeConfig(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } catch (e) {
      debugPrint('[SharedPreferencesConfigRepository] Error removing config for $key: $e');
    }
  }
}
