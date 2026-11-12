import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

class ConfigCloudConverter {
  final ConfigRepository _configRepository;

  ConfigCloudConverter(this._configRepository);

  Future<Map<String, dynamic>> convertToCloudFormat({List<String>? configKeys}) async {
    final List<String> keys;
    if (configKeys != null && configKeys.isNotEmpty) {
      keys = configKeys;
    } else {
      final prefs = await SharedPreferences.getInstance();
      keys = prefs.getKeys().toList();
    }
    
    final Map<String, dynamic> configData = {};
    for (final key in keys) {
      final config = await _configRepository.getConfig(key);
      if (config != null) {
        configData[key] = config;
      }
    }

    final cloudData = {
      'type': 'config_backup',
      'version': 1,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': configData,
    };

    return cloudData;
  }

  Future<void> restoreFromCloudFormat(Map<String, dynamic> cloudData, {List<String>? configKeys}) async {
    if (cloudData['type'] != 'config_backup') {
      throw const FormatException('Invalid backup data format');
    }

    final data = cloudData['data'] as Map<String, dynamic>;
    
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
      for (final entry in data.entries) {
        await _configRepository.saveConfig(
          entry.key, 
          entry.value as Map<String, dynamic>
        );
      }
    }
  }

  static void registerWithCloudDataConverter() {}
  
  Future<List<String>> getAllConfigKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys().toList();
    
    final configKeys = <String>[];
    for (final key in allKeys) {
      if (key.startsWith('config_')) {
        configKeys.add(key);
      }
    }
    
    return configKeys;
  }
}
