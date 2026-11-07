/// 零依赖全局配置注册表 (pyro_config_protocol)
/// 允许任意上层微包/插件在静态加载时主动打卡注册前缀或黑名单，实现零横向依赖的配置归集
abstract final class PyroConfigRegistry {
  static final Set<String> _registeredPrefixes = {'config_', 'pyro_'};
  static final Set<String> _blacklistedKeys = {};

  /// 允许第三方微包/插件主动打卡注册自己的 Key 前缀
  static void registerPrefix(String prefix) {
    if (prefix.isNotEmpty) {
      _registeredPrefixes.add(prefix);
    }
  }

  /// 允许第三方微包/插件注册敏感黑名单 Key (如本地 Token/密钥，避免同步到云端)
  static void registerBlacklistKey(String key) {
    if (key.isNotEmpty) {
      _blacklistedKeys.add(key);
    }
  }

  /// 判断一个 Key 是否可以被底层配置引擎归集与云同步
  static bool isSyncableKey(String key) {
    if (_blacklistedKeys.contains(key)) return false;
    return _registeredPrefixes.any((prefix) => key.startsWith(prefix));
  }

  /// 获取当前所有已注册的前缀集合（不可变副本）
  static Set<String> get registeredPrefixes => Set.unmodifiable(_registeredPrefixes);
}
