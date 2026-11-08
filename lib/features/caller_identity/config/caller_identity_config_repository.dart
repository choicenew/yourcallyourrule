import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/display_mode.dart';

/// CallerID / Caller Identity 配置仓库
class CallerIdConfigRepository {
  final ConfigRepository _configRepository;
  
  static const String configKey = 'config_caller_id_functionality';
  
  static const String useLocalNotificationKey = 'config_use_local_notification';
  static const String cancelLocalNotificationKey = 'config_cancel_local_notification';
  static const String useStirNotificationKey = 'config_use_stir_notification';
  static const String displayModeKey = 'config_display_mode';
  static const String notificationAutoCancelDelayKey = 'config_notification_auto_cancel_delay';

  static const int defaultNotificationAutoCancelDelayInSeconds = 5;

  CallerIdConfigRepository(this._configRepository);
  
  Future<Map<String, dynamic>> getConfig() async {
    final config = await _configRepository.getConfig(configKey);
    return config ?? _getDefaultConfig();
  }
  
  Future<void> saveConfig(Map<String, dynamic> config) async {
    await _configRepository.saveConfig(configKey, config);
  }
  
  Future<bool> getUseLocalNotification() async {
    final config = await getConfig();
    return config[useLocalNotificationKey] as bool? ?? false;
  }
  
  Future<void> setUseLocalNotification(bool value) async {
    final config = await getConfig();
    config[useLocalNotificationKey] = value;
    await saveConfig(config);
  }
  
  Future<bool> getCancelLocalNotification() async {
    final config = await getConfig();
    return config[cancelLocalNotificationKey] as bool? ?? false;
  }
  
  Future<void> setCancelLocalNotification(bool value) async {
    final config = await getConfig();
    config[cancelLocalNotificationKey] = value;
    await saveConfig(config);
  }
  
  Future<bool> getUseStirNotification() async {
    final config = await getConfig();
    return config[useStirNotificationKey] as bool? ?? false;
  }
  
  Future<void> setUseStirNotification(bool value) async {
    final config = await getConfig();
    config[useStirNotificationKey] = value;
    await saveConfig(config);
  }
  
  Future<DisplayMode> getDisplayMode() async {
    final config = await getConfig();
    return DisplayMode.fromString(config[displayModeKey]);
  }

  Future<void> setDisplayMode(DisplayMode value) async {
    final config = await getConfig();
    config[displayModeKey] = value.toRawString();
    await saveConfig(config);
  }

  Future<Duration> getNotificationAutoCancelDelay() async {
    final config = await getConfig();
    final seconds = config[notificationAutoCancelDelayKey] as int? ?? defaultNotificationAutoCancelDelayInSeconds;
    return Duration(seconds: seconds);
  }

  Future<void> setNotificationAutoCancelDelay(Duration value) async {
    final config = await getConfig();
    config[notificationAutoCancelDelayKey] = value.inSeconds;
    await saveConfig(config);
  }

  Map<String, dynamic> _getDefaultConfig() {
    return {
      useLocalNotificationKey: false,
      cancelLocalNotificationKey: false,
      useStirNotificationKey: false,
      displayModeKey: DisplayMode.liveActivity.toRawString(),
      notificationAutoCancelDelayKey: defaultNotificationAutoCancelDelayInSeconds,
    };
  }
}
