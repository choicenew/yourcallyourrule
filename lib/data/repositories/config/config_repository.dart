import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ConfigRepository {
  Future<Map<String, dynamic>?> getConfig(String key);
  Future<void> saveConfig(String key, Map<String, dynamic> config);
  Future<void> removeConfig(String key);
}

/// 使用SharedPreferences实现的配置仓库
class SharedPreferencesConfigRepository implements ConfigRepository {
  @override
  Future<Map<String, dynamic>?> getConfig(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) {
      return null;
    }
    
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<void> saveConfig(String key, Map<String, dynamic> config) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(config);
    await prefs.setString(key, jsonString);
  }
  
  @override
  Future<void> removeConfig(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}






















