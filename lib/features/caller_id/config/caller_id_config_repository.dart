import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

import 'display_mode.dart';
import 'intercept_action.dart';

/// CallerID配置仓库
/// 负责管理CallerID和通话处理器相关的配置数据
class CallerIdConfigRepository {
  final ConfigRepository _configRepository;
  
  // 配置键名
  static const String configKey = 'config_caller_id';
  
  // 配置项键名
  static const String useLocalNotificationKey = 'config_use_local_notification';
  static const String cancelLocalNotificationKey = 'config_cancel_local_notification';
  static const String useStirNotificationKey = 'config_use_stir_notification';
  static const String interceptActionKey = 'config_intercept_action';
  static const String displayModeKey = 'config_display_mode'; // 来电显示模式：overlay或notification或者live activity
  
  /// 构造函数
  CallerIdConfigRepository(this._configRepository);
  
  /// 获取配置
  Future<Map<String, dynamic>> getConfig() async {
    final config = await _configRepository.getConfig(configKey);
    return config ?? _getDefaultConfig();
  }
  
  /// 保存配置
  Future<void> saveConfig(Map<String, dynamic> config) async {
    await _configRepository.saveConfig(configKey, config);
  }
  
  /// 获取拦截动作
  Future<InterceptAction> getInterceptAction() async {
    final config = await getConfig();
    final actionString = config[interceptActionKey] as String? ?? 'endCall';
    return InterceptAction.values.firstWhere((e) => e.toString().split('.').last == actionString, orElse: () => InterceptAction.endCall);
  }

  /// 设置拦截动作
  Future<void> setInterceptAction(InterceptAction value) async {
    final config = await getConfig();
    config[interceptActionKey] = value.toString().split('.').last;
    await saveConfig(config);
  }
  
  /// 获取是否使用本地通知
  Future<bool> getUseLocalNotification() async {
    final config = await getConfig();
    return config[useLocalNotificationKey] as bool? ?? false;
  }
  
  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool value) async {
    final config = await getConfig();
    config[useLocalNotificationKey] = value;
    await saveConfig(config);
  }
  
  /// 获取是否关闭本地通知
  Future<bool> getCancelLocalNotification() async {
    final config = await getConfig();
    return config[cancelLocalNotificationKey] as bool? ?? false;
  }
  
  /// 设置是否关闭本地通知
  Future<void> setCancelLocalNotification(bool value) async {
    final config = await getConfig();
    config[cancelLocalNotificationKey] = value;
    await saveConfig(config);
  }
  
  /// 获取是否使用STIR通知
  Future<bool> getUseStirNotification() async {
    final config = await getConfig();
    return config[useStirNotificationKey] as bool? ?? false;
  }
  
  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool value) async {
    final config = await getConfig();
    config[useStirNotificationKey] = value;
    await saveConfig(config);
  }
  
  /// 获取来电显示模式
  Future<DisplayMode> getDisplayMode() async {
    final config = await getConfig();
    final modeString = config[displayModeKey] as String? ?? 'overlay'; // 默认使用浮窗模式
    return DisplayMode.values.firstWhere((e) => e.toString().split('.').last == modeString, orElse: () => DisplayMode.overlay);
  }

  /// 设置来电显示模式
  Future<void> setDisplayMode(DisplayMode value) async {
    final config = await getConfig();
    config[displayModeKey] = value.toString().split('.').last;
    await saveConfig(config);
  }

  /// 获取默认配置
  Map<String, dynamic> _getDefaultConfig() {
    return {
      interceptActionKey: InterceptAction.endCall.toString().split('.').last,
      useLocalNotificationKey: false,
      cancelLocalNotificationKey: false,
      useStirNotificationKey: false,
      displayModeKey: DisplayMode.overlay.toString().split('.').last,
    };
  }
}