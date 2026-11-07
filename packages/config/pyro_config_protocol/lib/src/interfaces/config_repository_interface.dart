/// 纯抽象配置仓库接口协议 (Zero Concrete Storage Dependency)
abstract class ConfigRepository {
  /// 读取指定配置项 (返回 Map，复杂/简单值均已封装)
  Future<Map<String, dynamic>?> getConfig(String key);

  /// 保存指定配置项
  Future<void> saveConfig(String key, Map<String, dynamic> config);

  /// 删除指定配置项
  Future<void> removeConfig(String key);

  /// 底层配置引擎：获取当前仓库托管的所有配置 Key 列表
  Future<List<String>> getAllKeys();
}
