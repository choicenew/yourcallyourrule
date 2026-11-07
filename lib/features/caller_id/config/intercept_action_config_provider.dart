import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 确保您的 import 路径正确
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

import 'intercept_action.dart';

// --- 依赖提供者 (最佳实践优化) ---

/// [新增/优化] 为 ConfigRepository 创建一个独立的 Provider
///
/// 在旧代码中，`SharedPreferencesConfigRepository` 是在 StateNotifierProvider 内部直接创建的。
/// 更好的做法是为这个仓库本身创建一个 Provider。
/// 这样做的好处是：
///   1. 可复用：应用中任何其他需要这个仓库的地方都可以直接 `ref.watch(configRepositoryProvider)`。
///   2. 可覆盖：在测试中，可以轻松地用一个模拟的仓库来覆盖这个 Provider。
final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return SharedPreferencesConfigRepository();
});


// --- 状态管理核心 (重构区域) ---

/// 拦截行为配置提供者 (Provider for the Intercept Action)
///
/// [重大改动]
/// 1. `StateNotifierProvider` 被替换为 `NotifierProvider`。
/// 2. 状态类型 `<String>` 被移到了 `NotifierProvider` 的第二个泛型参数位置。
/// 3. 直接引用 `InterceptActionConfigNotifier` 的构造函数 `InterceptActionConfigNotifier.new`。
final interceptActionConfigProvider = NotifierProvider<InterceptActionConfigNotifier, InterceptAction>(
  InterceptActionConfigNotifier.new,
);

/// 拦截行为配置状态通知器 (State Notifier for Intercept Action)
///
/// [重大改动]
/// 1. `StateNotifier<String>` 被替换为 `Notifier<String>`。
/// 2. 移除了构造函数和 `_configRepository` 成员变量，因为 `ref` 会处理依赖。
class InterceptActionConfigNotifier extends Notifier<InterceptAction> {
  // 这个 key 是业务逻辑的一部分，保持不变。
  static const String _interceptActionKey = 'config_intercept_action';

  /// [新增] `build()` 方法
  ///
  /// 这个方法必须同步地返回初始状态。
  /// 这里的初始状态是 'endCall'，这与旧代码中 `super('endCall')` 的行为一致。
  /// 同时，我们在后台启动 `_loadInterceptAction()` 来获取真实的持久化值。
  @override
  InterceptAction build() {
    // 触发异步加载
    _loadInterceptAction();
    // 同步返回默认的初始状态
    return InterceptAction.endCall;
  }

  /// 加载拦截行为的配置
  Future<void> _loadInterceptAction() async {
    // [改动] 使用 `ref.read` 和我们新创建的 `configRepositoryProvider` 来获取依赖。
    final repository = ref.read(configRepositoryProvider);
    final config = await repository.getConfig(_interceptActionKey);
 debugPrint('config打印: $config');
    // [关键] 在异步操作后，使用 `ref.mounted` 检查 Provider 是否仍然存活。
    if (ref.mounted) {
      // 更新状态为从存储中读取到的值，如果不存在则回退到 'endCall'
      final actionString = config?['value'] as String? ?? 'endCall';
      debugPrint('actionString打印: $actionString');
      state = InterceptAction.values.firstWhere((e) => e.toString().split('.').last == actionString, orElse: () => InterceptAction.endCall);
    }
  }

  /// 设置新的拦截行为
  Future<void> setInterceptAction(InterceptAction newValue) async {
    // 1. 获取依赖并执行副作用（保存配置）
    await ref.read(configRepositoryProvider).saveConfig(
      _interceptActionKey,
      {'value': newValue.toString().split('.').last},
    );
    debugPrint('setInterceptAction打印: $newValue');

    // 2. 检查 Provider 是否存活
    if (ref.mounted) {
      // 3. 更新状态，通知 UI 刷新
      state = newValue;
    }
  }
}