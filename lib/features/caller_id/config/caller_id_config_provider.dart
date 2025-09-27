import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';

// --- 依赖提供者 ---

/// CallerID配置仓库提供者 (Provider for the Repository)
///
/// [无变化]
/// 这个 Provider 的定义在 Riverpod 3.0 中保持不变。
/// 它是一个简单的 Provider，负责创建并提供一个不会改变的服务实例 (CallerIdConfigRepository)。
/// 这种类型的 Provider 在新旧版本中语法和功能都是一致的。
final callerIdConfigRepositoryProvider = Provider<CallerIdConfigRepository>((ref) {
  // 依赖另一个（或外部的）仓库/服务
  final configRepository = SharedPreferencesConfigRepository();
  
  // 创建并返回 CallerIdConfigRepository 实例
  return CallerIdConfigRepository(configRepository);
});


// --- 状态管理核心 (重构区域) ---

/// CallerID配置状态提供者 (Provider for the State Notifier)
///
/// [重大改动]
/// 1. `StateNotifierProvider` 被替换为 `NotifierProvider`。
///    这是 Riverpod 3.0 中管理状态的核心推荐方式。
///
/// 2. 不再需要一个回调函数 `(ref) => ...` 来创建 Notifier 实例。
///    `NotifierProvider` 直接接收 Notifier 类的构造函数引用 (`CallerIdConfigNotifier.new`)。
///    Riverpod 会自动处理 `ref` 对象的注入。
final callerIdConfigProvider = NotifierProvider<CallerIdConfigNotifier, CallerIdConfig>(
  CallerIdConfigNotifier.new,
);

/// CallerID配置状态类 (State Class)
///
/// [无变化]
/// 状态类本身只是一个普通的 Dart 数据类 (Data Class)。
/// 它不依赖于 Riverpod 的任何特定 API，因此在版本升级中完全不需要改动。
class CallerIdConfig {
  final bool useLocalNotification;
  final bool cancelLocalNotification;
  final bool useStirNotification;
  final String displayMode;

  const CallerIdConfig({
    this.useLocalNotification = false,
    this.cancelLocalNotification = false,
    this.useStirNotification = false,
    this.displayMode = 'overlay',
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

/// CallerID配置状态通知器 (State Notifier Class)
///
/// [重大改动]
/// 1. `StateNotifier<CallerIdConfig>` 被替换为 `Notifier<CallerIdConfig>`。
///
/// 2. 不再需要构造函数来接收 `ref` 或其他依赖。`Notifier` 类内部自动拥有一个 `ref` 成员。
class CallerIdConfigNotifier extends Notifier<CallerIdConfig> {

  /// [新增] `build()` 方法
  ///
  /// 这是 Notifier 的核心初始化方法，必须被实现。
  /// 它在 Provider 第一次被读取时执行，并且必须 **同步地** 返回初始状态。
  /// 这里的逻辑是：
  ///   a. 立即返回一个默认的、临时的初始状态 (`const CallerIdConfig()`)。
  ///   b. 同时，在后台触发一个异步任务 `_loadConfig()` 来加载真实的持久化状态。
  ///   c. 当 `_loadConfig()` 完成后，它会更新 `state`，从而通知UI刷新。
  @override
  CallerIdConfig build() {
    // 触发异步加载持久化配置
    _loadConfig();
    // 必须同步返回一个初始状态
    return const CallerIdConfig();
  }

  /// 加载配置 (私有方法)
  Future<void> _loadConfig() async {
    // [改动] 使用 `ref.read` 来读取依赖的 Provider。
    // `ref` 是 `Notifier` 内置的属性，无需手动传递。
    final repository = ref.read(callerIdConfigRepositoryProvider);
    final config = await repository.getConfig();

    // [关键] 使用 `ref.mounted` 进行安全检查。
    // 在任何 `await` 异步操作之后，Provider 可能已经被释放（例如用户离开了页面）。
    // 这个检查确保我们只在 Provider 仍然“存活”时才更新状态，避免了运行时错误。
    if (ref.mounted) {
      state = CallerIdConfig.fromMap(config);
    }
  }

  // --- 公开方法 (Public Methods for UI interaction) ---
  // 这些方法暴露给UI，用于触发状态变更。

  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool value) async {
    // 1. 调用仓库方法，执行副作用（例如写入数据库/SharedPreferences）
    await ref.read(callerIdConfigRepositoryProvider).setUseLocalNotification(value);
    
    // 2. 在副作用完成后，检查 Provider 是否仍然存活
    if (ref.mounted) {
      // 3. 更新状态，通知UI刷新。`state` 的用法与 StateNotifier 中完全相同。
      state = state.copyWith(useLocalNotification: value);
    }
  }

  /// 设置是否关闭本地通知
  Future<void> setCancelLocalNotification(bool value) async {
    await ref.read(callerIdConfigRepositoryProvider).setCancelLocalNotification(value);
    if (ref.mounted) {
      state = state.copyWith(cancelLocalNotification: value);
    }
  }

  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool value) async {
    await ref.read(callerIdConfigRepositoryProvider).setUseStirNotification(value);
    if (ref.mounted) {
      state = state.copyWith(useStirNotification: value);
    }
  }

  /// 设置来电显示模式
  Future<void> setDisplayMode(String value) async {
    await ref.read(callerIdConfigRepositoryProvider).setDisplayMode(value);
    if (ref.mounted) {
      state = state.copyWith(displayMode: value);
    }
  }
}