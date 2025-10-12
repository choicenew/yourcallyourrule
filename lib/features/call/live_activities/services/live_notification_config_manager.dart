// lib/features/call/live_activities/configuration/live_notification_config_manager.dart

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';

import '../services/live_notification_config_service.dart';

/// Live Notification 配置管理器
/// 负责协调 Live Notification 样式的保存、加载、重置等。
class LiveNotificationConfigManager {
  final LiveNotificationConfigService _configService;
  final ConfigRepository _configRepository;

  LiveNotificationConfigManager(this._configRepository)
      : _configService = LiveNotificationConfigService(_configRepository);

  /// 保存配置
  Future<void> saveConfig(LiveNotificationConfig config) async {
    await _configService.saveConfig(config);
  }

  /// 加载配置，如果不存在则返回默认配置
  Future<LiveNotificationConfig> loadConfig() async {
    final config = await _configService.loadConfig();
    if (config != null) {
      return config;
    } else {
      return await _configService.initializeDefault();
    }
  }

  /// 重置为默认配置
  Future<LiveNotificationConfig> resetToDefault() async {
    return await _configService.initializeDefault();
  }
}