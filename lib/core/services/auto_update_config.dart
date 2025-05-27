import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// 自动更新服务的配置管理类
/// 负责存储和获取自动更新相关的配置信息
class AutoUpdateConfig {
  final ConfigRepository _configRepository;
  
  /// 构造函数
  AutoUpdateConfig({required ConfigRepository configRepository})
      : _configRepository = configRepository;
  
  /// 获取最后更新时间
  Future<DateTime?> getLastUpdateTime(String serviceType) async {
    final key = 'lastUpdated_$serviceType';
    final config = await _configRepository.getConfig(key);
    final timestamp = config?['value'] as String?;
    
    if (timestamp == null) return null;
    
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      return null;
    }
  }
  
  /// 保存最后更新时间
  Future<void> saveLastUpdateTime(String serviceType, DateTime time) async {
    final key = 'lastUpdated_$serviceType';
    await _configRepository.saveConfig(key, {'value': time.toIso8601String()});
  }
  
  /// 获取用户自定义更新间隔（天数）
  Future<int?> getUserUpdateIntervalDays(String serviceType) async {
    final key = 'userInterval_$serviceType';
    final config = await _configRepository.getConfig(key);
    return config?['value'] as int?;
  }
  
  /// 设置用户自定义更新间隔（天数）
  Future<void> setUserUpdateIntervalDays(String serviceType, int days) async {
    final key = 'userInterval_$serviceType';
    await _configRepository.saveConfig(key, {'value': days});
  }
  
  /// 保存默认存储目录
  Future<void> saveDefaultStorageDirectory(String path) async {
    await _configRepository.saveConfig('defaultExternalStorageDirectory', {'value': path});
  }
  
  /// 获取默认存储目录
  Future<String?> getDefaultStorageDirectory() async {
    final config = await _configRepository.getConfig('defaultExternalStorageDirectory');
    return config?['value'] as String?;
  }
}