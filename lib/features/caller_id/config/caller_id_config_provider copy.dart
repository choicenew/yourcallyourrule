import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';

// [无需修改] - Provider 的定义方式在 Riverpod 3.0 中保持不变。
/// CallerID配置仓库提供者
/// 用于在应用中提供CallerIdConfigRepository的实例
final callerIdConfigRepositoryProvider = Provider<CallerIdConfigRepository>((ref) {
  // 获取ConfigRepository实例
  final configRepository = SharedPreferencesConfigRepository();
  
  // 创建CallerIdConfigRepository实例
  return CallerIdConfigRepository(configRepository);
});

// [修改点 1] - 将 StateNotifierProvider 替换为 NotifierProvider。
// 它的构造函数更简单，直接返回 Notifier 实例即可。
/// CallerID配置状态提供者
/// 用于在应用中提供CallerID配置状态
final callerIdConfigProvider = NotifierProvider<CallerIdConfigNotifier, CallerIdConfig>(
  CallerIdConfigNotifier.new,
);

// [无需修改] - 数据类 (Data Class) 与 Riverpod 无关，保持原样。
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

// [修改点 2] - 将 StateNotifier 迁移为 Notifier。
/// CallerID配置状态通知器
/// 负责管理CallerID配置状态的变更
class CallerIdConfigNotifier extends Notifier<CallerIdConfig> {
  // `ref` 现在是 Notifier 的一个内置属性，可以直接使用，无需通过构造函数传入。

  @override
  CallerIdConfig build() {
    // `build` 方法必须同步返回初始状态。
    // 我们在这里立即触发异步加载，加载完成后会更新状态并通知UI。
    _loadConfig();
    
    // 同步返回一个默认的初始状态。
    return const CallerIdConfig();
  }
  
  /// 加载配置
  Future<void> _loadConfig() async {
    // [核心变化] - 不再使用构造函数传入的 _repository，而是直接用 ref 读取。
    final repository = ref.read(callerIdConfigRepositoryProvider);
    final config = await repository.getConfig();
    // 状态的更新方式不变，直接给 state 赋值。
    state = CallerIdConfig.fromMap(config);
  }
  
  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool value) async {
    final repository = ref.read(callerIdConfigRepositoryProvider);
    await repository.setUseLocalNotification(value);
    state = state.copyWith(useLocalNotification: value);
  }
  
  /// 设置是否关闭本地通知
  Future<void> setCancelLocalNotification(bool value) async {
    final repository = ref.read(callerIdConfigRepositoryProvider);
    await repository.setCancelLocalNotification(value);
    state = state.copyWith(cancelLocalNotification: value);
  }
  
  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool value) async {
    final repository = ref.read(callerIdConfigRepositoryProvider);
    await repository.setUseStirNotification(value);
    state = state.copyWith(useStirNotification: value);
  }
  
  /// 设置来电显示模式
  Future<void> setDisplayMode(String value) async {
    final repository = ref.read(callerIdConfigRepositoryProvider);
    await repository.setDisplayMode(value);
    state = state.copyWith(displayMode: value);
  }
}