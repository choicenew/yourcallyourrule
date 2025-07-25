import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';

/// CallerID配置仓库提供者
/// 用于在应用中提供CallerIdConfigRepository的实例
final callerIdConfigRepositoryProvider = Provider<CallerIdConfigRepository>((ref) {
  // 获取ConfigRepository实例
  final configRepository = SharedPreferencesConfigRepository();
  
  // 创建CallerIdConfigRepository实例
  return CallerIdConfigRepository(configRepository);
});

/// CallerID配置状态提供者
/// 用于在应用中提供CallerID配置状态
final callerIdConfigProvider = StateNotifierProvider<CallerIdConfigNotifier, CallerIdConfig>((ref) {
  final repository = ref.watch(callerIdConfigRepositoryProvider);
  return CallerIdConfigNotifier(repository);
});

/// CallerID配置状态
/// 包含CallerID的所有配置项
class CallerIdConfig {
  final bool useLocalNotification;
  final bool cancelLocalNotification;
  final bool useStirNotification;
  final String displayMode; // 来电显示模式：'overlay'或'notification'
  
  const CallerIdConfig({
    this.useLocalNotification = false,
    this.cancelLocalNotification = false,
    this.useStirNotification = false,
    this.displayMode = 'overlay', // 默认使用浮窗模式
  });
  
  /// 创建配置副本
  CallerIdConfig copyWith({
    bool? useLocalNotification,
    bool? cancelLocalNotification,
    bool? useStirNotification,
    String? displayMode,
  }) {
    return CallerIdConfig(
      useLocalNotification: useLocalNotification ?? this.useLocalNotification,
      cancelLocalNotification: cancelLocalNotification ?? this.cancelLocalNotification,
      useStirNotification: useStirNotification ?? this.useStirNotification,
      displayMode: displayMode ?? this.displayMode,
    );
  }
  
  /// 从Map创建配置
  factory CallerIdConfig.fromMap(Map<String, dynamic> map) {
    return CallerIdConfig(
      useLocalNotification: map[CallerIdConfigRepository.useLocalNotificationKey] as bool? ?? false,
      cancelLocalNotification: map[CallerIdConfigRepository.cancelLocalNotificationKey] as bool? ?? false,
      useStirNotification: map[CallerIdConfigRepository.useStirNotificationKey] as bool? ?? false,
      displayMode: map[CallerIdConfigRepository.displayModeKey] as String? ?? 'overlay',
    );
  }
  
  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      CallerIdConfigRepository.useLocalNotificationKey: useLocalNotification,
      CallerIdConfigRepository.cancelLocalNotificationKey: cancelLocalNotification,
      CallerIdConfigRepository.useStirNotificationKey: useStirNotification,
      CallerIdConfigRepository.displayModeKey: displayMode,
    };
  }
}

/// CallerID配置状态通知器
/// 负责管理CallerID配置状态的变更
class CallerIdConfigNotifier extends StateNotifier<CallerIdConfig> {
  final CallerIdConfigRepository _repository;
  
  CallerIdConfigNotifier(this._repository) : super(const CallerIdConfig()) {
    _loadConfig();
  }
  
  /// 加载配置
  Future<void> _loadConfig() async {
    final config = await _repository.getConfig();
    state = CallerIdConfig.fromMap(config);
  }
  
  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool value) async {
    await _repository.setUseLocalNotification(value);
    state = state.copyWith(useLocalNotification: value);
  }
  
  /// 设置是否关闭本地通知
  Future<void> setCancelLocalNotification(bool value) async {
    await _repository.setCancelLocalNotification(value);
    state = state.copyWith(cancelLocalNotification: value);
  }
  
  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool value) async {
    await _repository.setUseStirNotification(value);
    state = state.copyWith(useStirNotification: value);
  }
  
  /// 设置来电显示模式
  Future<void> setDisplayMode(String value) async {
    await _repository.setDisplayMode(value);
    state = state.copyWith(displayMode: value);
  }
}