import 'package:plugindemo/data/repositories/config/config_repository.dart';

class PluginManagerConfig {
  final ConfigRepository _configRepository;

  PluginManagerConfig({required ConfigRepository configRepository})
    : _configRepository = configRepository;

  Future<void> saveDefaultStorageDirectory(String path) async {
    await _configRepository.saveConfig(
      'config_defaultExternalStorageDirectory',
      {'value': path},
    );
  }

  Future<String?> getDefaultStorageDirectory() async {
    final config = await _configRepository.getConfig(
      'config_defaultExternalStorageDirectory',
    );
    return config?['value'] as String?;
  }
}
