// lib/features/call/live_activities/services/live_notification_config_service.dart

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart'; 


/// Service for managing Live Notification configurations.
class LiveNotificationConfigService {
  final String _configKey = 'config_live_notification_style';
  final ConfigRepository _configRepository;

  LiveNotificationConfigService(this._configRepository);

  /// Saves the configuration to the repository.
  Future<void> saveConfig(LiveNotificationConfig config) async {
    await _configRepository.saveConfig(_configKey, config.toJson());
  }

  /// Loads the configuration from the repository.
  Future<LiveNotificationConfig?> loadConfig() async {
    final configMap = await _configRepository.getConfig(_configKey);
    return configMap != null ? LiveNotificationConfig.fromJson(configMap) : null;
  }
  
  /// Loads configuration, or initializes and returns the default if none is found.
  Future<LiveNotificationConfig> loadConfigOrDefault() async {
    final config = await loadConfig();
    if (config != null) {
      return config;
    } else {
      return await initializeDefault();
    }
  }

  /// Initializes and saves the default configuration.
  Future<LiveNotificationConfig> initializeDefault() async {
    const defaultConfig = LiveNotificationConfig();
    await saveConfig(defaultConfig);
    return defaultConfig;
  }

  /// Resets the configuration to its default state.
  Future<LiveNotificationConfig> resetToDefault() async {
    return await initializeDefault();
  }
}