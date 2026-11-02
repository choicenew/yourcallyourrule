import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'config_repository.g.dart';

@Riverpod(keepAlive: true)
ConfigRepository configRepository(Ref ref) {
  return SharedPreferencesConfigRepository();
}

abstract class ConfigRepository {
  Future<Map<String, dynamic>?> getConfig(String key);
  Future<void> saveConfig(String key, Map<String, dynamic> config);
  Future<void> removeConfig(String key);
}

class SharedPreferencesConfigRepository implements ConfigRepository {
  @override
  Future<Map<String, dynamic>?> getConfig(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final String? jsonString = prefs.getString(key);
    
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
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
