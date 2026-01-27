import 'package:plugindemo/data/repositories/config/config_repository.dart';

/// 使用ConfigRepository实现的SharedPreferencesAsync
/// 用于替代直接使用SharedPreferences的方式
class SharedPreferencesAsync {
  final ConfigRepository _configRepository;
  
  /// 构造函数
  SharedPreferencesAsync({ConfigRepository? configRepository})
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  /// 获取布尔值
  Future<bool?> getBool(String key) async {
    final config = await _configRepository.getConfig(key);
    return config?['value'] as bool?;
  }

  /// 设置布尔值
  Future<void> setBool(String key, bool value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  /// 获取字符串
  Future<String?> getString(String key) async {
    final config = await _configRepository.getConfig(key);
    return config?['value'] as String?;
  }

  /// 设置字符串
  Future<void> setString(String key, String value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  /// 获取整数
  Future<int?> getInt(String key) async {
    final config = await _configRepository.getConfig(key);
    return config?['value'] as int?;
  }

  /// 设置整数
  Future<void> setInt(String key, int value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  /// 获取双精度浮点数
  Future<double?> getDouble(String key) async {
    final config = await _configRepository.getConfig(key);
    return config?['value'] as double?;
  }

  /// 设置双精度浮点数
  Future<void> setDouble(String key, double value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  /// 获取字符串列表
  Future<List<String>?> getStringList(String key) async {
    final config = await _configRepository.getConfig(key);
    final list = config?['value'] as List?;
    return list?.cast<String>();
  }

  /// 设置字符串列表
  Future<void> setStringList(String key, List<String> value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  /// 移除指定键的配置
  Future<void> remove(String key) async {
    await _configRepository.removeConfig(key);
  }

  /// 检查是否包含指定键
  Future<bool> containsKey(String key) async {
    final config = await _configRepository.getConfig(key);
    return config != null;
  }
}