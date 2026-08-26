// 导入 Flutter 核心包
import 'package:flutter/foundation.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入外部插件
import 'package:floating_window_android/floating_window_android.dart';
// 导入项目中的实体类
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
// 导入项目中的服务和配置

import 'package:yourcallyourrule/features/caller_id/config/display_mode.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
// 导入国际化和路由
// 导入依赖的 Provider
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/kit_live_activity_handler.dart';

// part 指令
part 'display_mode_handler.g.dart';

/// 显示模式处理器 Provider
///
/// 【最终方案】: 这是一个异步 Provider，因为它需要在初始化时执行异步操作（管理引擎）。
/// 它负责创建并提供一个 DisplayModeHandler 的单例。
@Riverpod(keepAlive: true)
Future<DisplayModeHandler> displayModeHandler(Ref ref) async {
  // 1. 获取它所依赖的 repository 实例
  final configRepository = ref.watch(callerIdConfigRepositoryProvider);

  // 2. 创建 handler 实例
  final handler = DisplayModeHandler(
    ref: ref,
    configRepository: configRepository,
  );

  // 3. 执行一次性的异步初始化
  await handler.initialize();

  // 4. 返回就绪的 handler
  return handler;
}

/// 显示模式处理器
///
/// 【最终方案】: 它不再是 Notifier，而是一个纯粹的服务类。
/// 它不持有自己的状态，在需要时直接从 Repository 读取最新的配置。
class DisplayModeHandler {
  final Ref _ref;
  final CallerIdConfigRepository _configRepository;

  /// 构造函数
  DisplayModeHandler({
    required Ref ref,
    required CallerIdConfigRepository configRepository,
  }) : _ref = ref,
       _configRepository = configRepository;

  /// 【新增】: 一个一次性的初始化方法
  /// 在 Provider 创建时调用，负责根据初始配置设置引擎状态。
  Future<void> initialize() async {
    // 读取初始模式并管理引擎
    final initialMode = await _configRepository.getDisplayMode();
    await _manageEngineLifecycle(initialMode);
  }

  /// 私有方法，专门负责管理 `FloatingWindowAndroid` 引擎的生命周期。
  Future<void> _manageEngineLifecycle(DisplayMode mode) async {
    if (mode == DisplayMode.overlay) {
      debugPrint("Initializing FloatingWindowAndroid engine...");
      await FloatingWindowAndroid.initialize();
    } else {
      debugPrint("Disposing FloatingWindowAndroid engine...");
      await FloatingWindowAndroid.dispose();
    }
  }

  /// 公共方法，用于显示来电信息。
  Future<void> showCallerIdInfo(
    CallerIdData callerIdData,
    StirInfo? stirInfo,
    SimInfo? simInfo,
  ) async {
    // 【核心修正】:
    // 1. 在执行的这一刻，直接从 Repository 读取最新的配置。
    //    由于 Repository 内部已经实现了 `reload()`，这里获取到的永远是最新值。
    final currentDisplayMode = await _configRepository.getDisplayMode();
    debugPrint(
      "showCallerIdInfo called. Current display mode from storage is: $currentDisplayMode",
    );

    // 2. 在需要显示之前，立即根据最新配置管理引擎的生命周期。
    //    这确保了如果用户刚刚关闭了悬浮窗模式，引擎会被及时 dispose。
    await _manageEngineLifecycle(currentDisplayMode);

    // 3. 根据最新的配置执行相应的显示逻辑
    switch (currentDisplayMode) {
      case DisplayMode.overlay:
        final overlayHandler = _ref.read(overlayHandlerProvider);
        await overlayHandler.showCallerIdOverlay(
          callerIdData,
          stirInfo,
          simInfo,
        );
        break;

      case DisplayMode.notification:
        final notificationHandler = await _ref.read(
          notificationHandlerProvider.future,
        );
        await notificationHandler.showCallerIdNotification(
          callerIdData: callerIdData,
          simInfo: simInfo,
          stirInfo: stirInfo,
        );
        break;

      case DisplayMode.live_activity:
        final kitHandler = await _ref.read(
          kitLiveActivityHandlerProvider.future,
        );
        await kitHandler.showCallerIdActivity(
          callerIdData: callerIdData,
          simInfo: simInfo,
          stirInfo: stirInfo,
        );
        break;
    }
  }

  /// 公共方法，关闭所有可能的显示。
  Future<void> closeDisplay() async {
    final overlayHandler = _ref.read(overlayHandlerProvider);
    final kitHandler = await _ref.read(
      kitLiveActivityHandlerProvider.future,
    );

    overlayHandler.closeOverlay();
    await kitHandler.endActivity();
  }
}
