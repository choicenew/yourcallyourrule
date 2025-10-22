// 导入底层的通用仓库接口
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
// 导入此仓库负责的配置项枚举
import 'display_mode.dart';
// 【已移除】不再导入 InterceptAction，因为它不再是本仓库的职责
// import 'intercept_action.dart';

/// CallerID配置仓库
///
/// 【职责修正】: 这个仓库现在只负责管理与 CallerID **显示**相关的配置，
/// 例如显示模式、通知开关等。所有与**拦截行为**相关的配置已被剥离。
class CallerIdConfigRepository {
  final ConfigRepository _configRepository;
  
  // 配置键名，这是一个大的配置块的键
  static const String configKey = 'config_caller_id_functionality';
  
  // 此仓库负责的配置项键名
  static const String useLocalNotificationKey = 'config_use_local_notification';
  static const String cancelLocalNotificationKey = 'config_cancel_local_notification';
  static const String useStirNotificationKey = 'config_use_stir_notification';
  static const String displayModeKey = 'config_display_mode';
  
  // 【已移除】: interceptActionKey 不再属于这个配置文件
  // static const String interceptActionKey = 'config_intercept_action';
  
  /// 构造函数
  CallerIdConfigRepository(this._configRepository);
  
  /// 获取整个“显示配置”的 Map
  Future<Map<String, dynamic>> getConfig() async {
    final config = await _configRepository.getConfig(configKey);
    return config ?? _getDefaultConfig();
  }
  
  /// 保存整个“显示配置”的 Map
  Future<void> saveConfig(Map<String, dynamic> config) async {
    await _configRepository.saveConfig(configKey, config);
  }
  
  // 【已移除】: getInterceptAction 方法已被彻底移除
  /*
  Future<InterceptAction> getInterceptAction() async { ... }
  */

  // 【已移除】: setInterceptAction 方法已被彻底移除
  /*
  Future<void> setInterceptAction(InterceptAction value) async { ... }
  */
  
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
    final modeString = config[displayModeKey] as String? ?? 'overlay';
    // 使用 .name 属性进行比较，这是更健壮的方式
    return DisplayMode.values.firstWhere((e) => e.name == modeString, orElse: () => DisplayMode.overlay);
  }

  /// 设置来电显示模式
  Future<void> setDisplayMode(DisplayMode value) async {
    final config = await getConfig();
    // 使用 .name 属性进行存储
    config[displayModeKey] = value.name;
    await saveConfig(config);
  }

  /// 获取默认配置
  Map<String, dynamic> _getDefaultConfig() {
    return {
      // 【已移除】: 默认配置中不再包含 interceptActionKey
      useLocalNotificationKey: false,
      cancelLocalNotificationKey: false,
      useStirNotificationKey: false,
      displayModeKey: DisplayMode.overlay.name,
    };
  }
}