
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

/// 配置云数据转换器
/// 负责将配置数据转换为云同步兼容的格式
class ConfigCloudConverter {
  final ConfigRepository _configRepository;

  ConfigCloudConverter(this._configRepository);

  /// 将配置数据转换为云同步格�?
  /// [configKeys] 要转换的配置键列表，如果为空则转换所有配�?
  Future<Map<String, dynamic>> convertToCloudFormat({List<String>? configKeys}) async {
    // 获取所有配置键或使用指定的�?
    final List<String> keys;
    if (configKeys != null && configKeys.isNotEmpty) {
      keys = configKeys;
    } else {
      // 从SharedPreferences获取所有键
      final prefs = await SharedPreferences.getInstance();
      keys = prefs.getKeys().toList();
    }
    
    // 收集配置数据
    final Map<String, dynamic> configData = {};
    for (final key in keys) {
      final config = await _configRepository.getConfig(key);
      if (config != null) {
        configData[key] = config;
      }
    }

    // 创建云同步格式数�?
    final cloudData = {
      'type': 'config_backup',
      'version': 1,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': configData,
    };

    return cloudData;
  }

  /// 从云同步格式恢复配置数据
  /// [cloudData] 云同步格式的配置数据
  /// [configKeys] 要恢复的配置键列表，如果为空则恢复所有配�?
  Future<void> restoreFromCloudFormat(Map<String, dynamic> cloudData, {List<String>? configKeys}) async {
    // 验证数据格式
    if (cloudData['type'] != 'config_backup') {
      throw FormatException('无效的配置备份数据格�?);
    }

    final data = cloudData['data'] as Map<String, dynamic>;
    
    // 如果指定了键，只恢复这些�?
    if (configKeys != null && configKeys.isNotEmpty) {
      for (final key in configKeys) {
        if (data.containsKey(key)) {
          await _configRepository.saveConfig(
            key, 
            data[key] as Map<String, dynamic>
          );
        }
      }
    } else {
      // 否则恢复所有配�?
      for (final entry in data.entries) {
        await _configRepository.saveConfig(
          entry.key, 
          entry.value as Map<String, dynamic>
        );
      }
    }
  }

  /// 将配置数据集成到CloudDataConverter�?
  /// 这允许配置数据与其他实体一起备份和还原
  static void registerWithCloudDataConverter() {
    // 扩展CloudDataConverter以支持配置数�?
    // 注意：这是一个概念性的实现，实际上CloudDataConverter可能需要修改以支持这种扩展
    
    // 示例：如果CloudDataConverter支持注册自定义转换器
    // CloudDataConverter.registerConverter(
    //   'config',
    //   serialize: (data) => data,
    //   deserialize: (data) => data
    // );
  }
  
  /// 获取所有配置键，包括特定模块的配置�?
  Future<List<String>> getAllConfigKeys() async {
    // 从SharedPreferences获取所有键
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys().toList();
    
    // 过滤出配置键
    final configKeys = <String>[];
    
    // 添加通用配置�?
    for (final key in allKeys) {
      if (key.startsWith('config_')) {
        configKeys.add(key);
      }
    }
    
    return configKeys;
  }
}