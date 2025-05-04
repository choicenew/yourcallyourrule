
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';

class UniversalConfigManager<T> {
  final ConfigRepository _repository;
  final String _configKey;
  final T Function(Map<String, dynamic>) _fromMap;
  final Map<String, dynamic> Function(T) _toMap;

  UniversalConfigManager(
    this._repository,
    this._configKey,
    this._fromMap,
    this._toMap,
  );

  Future<void> saveConfig(T config) async {
    await _repository.saveConfig(_configKey, _toMap(config));
  }

  Future<T?> loadConfig() async {
    final configMap = await _repository.getConfig(_configKey);
    return configMap != null ? _fromMap(configMap) : null;
  }

  Future<void> resetToDefault(T defaultConfig) async {
    await saveConfig(defaultConfig);
  }
}