import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

class SharedPreferencesAsync {
  final ConfigRepository _configRepository;
  
  SharedPreferencesAsync({ConfigRepository? configRepository})
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  Future<bool?> getBool(String key) async {
    final config = await _configRepository.getConfig(key);
    return config?['value'] as bool?;
  }

  Future<void> setBool(String key, bool value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  Future<String?> getString(String key) async {
    final config = await _configRepository.getConfig(key);
    return config?['value'] as String?;
  }

  Future<void> setString(String key, String value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  Future<int?> getInt(String key) async {
    final config = await _configRepository.getConfig(key);
    return config?['value'] as int?;
  }

  Future<void> setInt(String key, int value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  Future<double?> getDouble(String key) async {
    final config = await _configRepository.getConfig(key);
    return config?['value'] as double?;
  }

  Future<void> setDouble(String key, double value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  Future<List<String>?> getStringList(String key) async {
    final config = await _configRepository.getConfig(key);
    final list = config?['value'] as List?;
    return list?.cast<String>();
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _configRepository.saveConfig(key, {'value': value});
  }

  Future<void> remove(String key) async {
    await _configRepository.removeConfig(key);
  }

  Future<bool> containsKey(String key) async {
    final config = await _configRepository.getConfig(key);
    return config != null;
  }
}
