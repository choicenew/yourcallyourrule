import 'dart:convert';
import 'package:pyro_config_protocol/pyro_config_protocol.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:pyro_config_protocol/pyro_config_protocol.dart';

/// 基于 SharedPreferences 实现的底层配置仓库 (实现 pyro_config_protocol 纯抽象契约)
/// 结合 PyroConfigRegistry 自动感知全量已注册微包的 Key 索引
class SharedPreferencesConfigRepository implements ConfigRepository {
  static const String _allConfigKeysRegistryKey = 'pyro_internal_config_index_keys';

  static const List<String> _systemKeyPrefixes = [
    'flutter.',
    'lib_flutter_',
    'dev.flutter.',
    'plugin_internal_',
    _allConfigKeysRegistryKey,
  ];

  @override
  Future<Map<String, dynamic>?> getConfig(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    final String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      try {
        final decoded = jsonDecode(jsonString);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        } else {
          return {'value': decoded};
        }
      } catch (e) {
        return {'value': jsonString};
      }
    }
    return null;
  }

  @override
  Future<void> saveConfig(String key, Map<String, dynamic> config) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(config);
    await prefs.setString(key, jsonString);

    await _registerKeyInIndex(prefs, key);
  }

  @override
  Future<void> removeConfig(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await _unregisterKeyFromIndex(prefs, key);
  }

  @override
  Future<List<String>> getAllKeys() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    final registryKeys = prefs.getStringList(_allConfigKeysRegistryKey) ?? [];
    final allKeysInDisk = prefs.getKeys();
    final discoveredKeys = <String>{...registryKeys};

    for (final diskKey in allKeysInDisk) {
      if (_isUserConfigKey(diskKey)) {
        discoveredKeys.add(diskKey);
      }
    }

    return discoveredKeys.toList();
  }

  Future<void> _registerKeyInIndex(SharedPreferences prefs, String key) async {
    if (!_isUserConfigKey(key)) return;

    final List<String> registry = prefs.getStringList(_allConfigKeysRegistryKey) ?? [];
    if (!registry.contains(key)) {
      registry.add(key);
      await prefs.setStringList(_allConfigKeysRegistryKey, registry);
    }
  }

  Future<void> _unregisterKeyFromIndex(SharedPreferences prefs, String key) async {
    final List<String> registry = prefs.getStringList(_allConfigKeysRegistryKey) ?? [];
    if (registry.contains(key)) {
      registry.remove(key);
      await prefs.setStringList(_allConfigKeysRegistryKey, registry);
    }
  }

  bool _isUserConfigKey(String key) {
    for (final sysPrefix in _systemKeyPrefixes) {
      if (key == sysPrefix || key.startsWith(sysPrefix)) {
        return false;
      }
    }
    // 优先校验是否符合 PyroConfigRegistry 注册中心协议
    return PyroConfigRegistry.isSyncableKey(key);
  }
}
