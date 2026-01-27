import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ConfigRepository {
  Future<Map<String, dynamic>?> getConfig(String key);
  Future<void> saveConfig(String key, Map<String, dynamic> config);
  Future<void> removeConfig(String key);
}

/// 使用SharedPreferences实现的配置仓库
class SharedPreferencesConfigRepository implements ConfigRepository {
  /// 获取配置
  @override
  Future<Map<String, dynamic>?> getConfig(String key) async {
    // 1. 获取 SharedPreferences 实例
    final prefs = await SharedPreferences.getInstance();
    
    // 2. 【核心修正】:
    //    在读取任何数据之前，调用 `reload()` 方法。
    //    这个方法会强制 SharedPreferences 实例放弃其内存中的缓存，
    //    并从硬盘上的物理文件中重新加载所有最新的键值对。
    //    这就保证了无论哪个进程（UI 或后台）刚刚调用了 `setString`，
    //    我们在这里都能读到已经被持久化到硬盘上的最新值。
    await prefs.reload();
    
    // 3. 使用 getString 读取之前保存的 JSON 字符串
    final String? jsonString = prefs.getString(key);
    
    // 4. 如果字符串存在，则解码为 Map 并返回
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        // 如果 JSON 解码失败，返回 null
        return null;
      }
    }
    
    // 5. 如果不存在，则返回 null
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
