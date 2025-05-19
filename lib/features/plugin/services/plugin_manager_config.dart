import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';

/// 插件管理服务的配置管理类
/// 负责存储和获取插件管理相关的配置信息
class PluginManagerConfig {
  final ConfigRepository _configRepository;
  
  /// 构造函数
  PluginManagerConfig({required ConfigRepository configRepository})
      : _configRepository = configRepository;
  
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