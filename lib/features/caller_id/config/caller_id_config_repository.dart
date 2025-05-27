import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// CallerID配置仓库
/// 负责管理CallerID和通话处理器相关的配置数据
class CallerIdConfigRepository {
  final ConfigRepository _configRepository;
  
  // 配置键名
  static const String configKey = 'config_caller_id';
  
  // 配置项键名
  static const String useLocalNotificationKey = 'use_local_notification';
  static const String cancelLocalNotificationKey = 'cancel_local_notification';
  static const String useStirNotificationKey = 'use_stir_notification';
  static const String interceptActionKey = 'intercept_action';
  
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
  Future<String> getInterceptAction() async {
    final config = await getConfig();
    return config[interceptActionKey] as String? ?? 'endCall';
  }
  
  /// 设置拦截动作
  Future<void> setInterceptAction(String value) async {
    final config = await getConfig();
    config[interceptActionKey] = value;
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
  
  /// 获取默认配置
  Map<String, dynamic> _getDefaultConfig() {
    return {
      interceptActionKey: 'endCall',
      useLocalNotificationKey: false,
      cancelLocalNotificationKey: false,
      useStirNotificationKey: false,
    };
  }
}