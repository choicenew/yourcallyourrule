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
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/caller_id/config/display_mode.dart';
// 导入国际化和路由
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
// 导入依赖的 Provider
// 【注意】请确保这些 provider 文件的路径是正确的，并且它们已经被 "Provider 化"
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart'; 
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/live_activity_handler.dart'; 

// part 指令是代码生成所必需的，它会链接到由 build_runner 生成的文件
part 'display_mode_handler.g.dart';

/// 显示模式处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责：
/// 1. 监听全局的显示模式配置（`callerIdConfigProvider`）。
/// 2. 根据配置变化，实时管理 `FloatingWindowAndroid` 引擎的生命周期。
/// 3. 提供 `showCallerIdInfo` 方法，根据当前模式分发显示任务给具体的处理器。
///
/// 使用 `keepAlive: true` 确保此服务在应用后台时保持活动状态。
@Riverpod(keepAlive: true)
class DisplayModeHandler extends _$DisplayModeHandler {

  /// build 方法是 Provider 的初始化入口。
  ///
  /// 当这个 Provider 第一次被读取时，该方法会被调用。
  /// 它负责初始化状态和设置监听器。
  /// 返回值的类型是 Notifier 管理的状态，这里我们用 DisplayMode。
  @override
  DisplayMode build() {
    // 1. 从 callerIdConfigProvider 同步读取初始的显示模式作为本 Notifier 的初始状态。
    //    这确保了初始状态的一致性。
    final initialMode = ref.watch(callerIdConfigProvider).displayMode;

    // 2. 首次初始化时，根据初始模式管理引擎的生命周期。
    //    我们不在 build 方法中直接 await，而是使用 Future.microtask 安排它在之后执行，
    //    以避免 build 方法变成异步的。
    Future.microtask(() => _manageEngineLifecycle(initialMode));

    // 3. 【核心】监听 callerIdConfigProvider 的状态变化。
    //    这是解决状态不同步问题的关键。
    ref.listen<CallerIdConfig>(callerIdConfigProvider, (previous, next) {
      // 当 `displayMode` 发生变化时...
      if (previous?.displayMode != next.displayMode) {
        debugPrint("Display mode config changed from ${previous?.displayMode} to ${next.displayMode}.");
        
        // a. 立即更新本 Notifier 的内部状态
        state = next.displayMode;
        
        // b. 立即根据新的模式管理引擎的生命周期
        _manageEngineLifecycle(next.displayMode);
      }
    });

    // 4. 返回初始状态
    return initialMode;
  }

  /// 私有方法，专门负责管理 `FloatingWindowAndroid` 引擎的生命周期。
  ///
  /// [mode] 当前的显示模式。
  Future<void> _manageEngineLifecycle(DisplayMode mode) async {
    // 如果模式是悬浮窗，则初始化引擎；否则，销毁引擎。
    if (mode == DisplayMode.overlay) {
      debugPrint("Initializing FloatingWindowAndroid engine...");
      await FloatingWindowAndroid.initialize();
    } else {
      debugPrint("Disposing FloatingWindowAndroid engine...");
      await FloatingWindowAndroid.dispose();
    }
  }

  /// 公共方法，用于显示来电信息。
  ///
  /// 这是该处理器的主要入口，由外部服务（如 CallerIdMonitorService）调用。
  Future<void> showCallerIdInfo(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    // 【改动】不再需要手动加载配置。
    // 本 Notifier 的 `state` 已经通过 `listen` 机制与全局配置保持了实时同步。
    // 直接使用当前的 `state` 即可，它保证是最新的。
    debugPrint("showCallerIdInfo called. Current display mode from state is: $state");

    // 根据当前状态分发任务给具体的处理器
    switch (state) {
      case DisplayMode.overlay:
        // 从 ref 获取 OverlayHandler 实例并调用其方法
        final overlayHandler = ref.read(overlayHandlerProvider);
        await overlayHandler.showCallerIdOverlay(callerIdData, stirInfo, simInfo);
        break;
      
      case DisplayMode.notification:
        final context = AppRouter.navigatorKey.currentContext;
        if (context == null) return;
        
        final isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);
        // 从 ref 获取 NotificationHandler 实例并调用其方法
         // 2. await 这个 Future 之后，我们就能得到真正的 NotificationHandler 实例。
  final notificationHandler = await ref.read(notificationHandlerProvider.future);
        await notificationHandler.showCallerIdNotification(
          title: AppLocalizations.of(context)!.callerIdNotificationTitle,
          body: AppLocalizations.of(context)!.callerIdBody(callerIdData.phoneNumber.value),
          callerIdData: callerIdData,
          isFraudCall: isFraudCall,
        );
        break;
        
      case DisplayMode.live_activity:
        // 从 ref 获取 LiveActivityHandler 实例并调用其方法
        // 注意：如果 liveActivityHandlerProvider 是 FutureProvider，需要异步获取
        final liveActivityHandler = await ref.read(liveActivityHandlerProvider.future);
        await liveActivityHandler.showCallerIdActivity(
          callerIdData: callerIdData,
          simInfo: simInfo,
          stirInfo: stirInfo,
        );
        break;
    }
  }

  /// 公共方法，关闭所有可能的显示。
  Future<void> closeDisplay() async {
    // 从 ref 获取各个处理器的实例并调用它们的关闭方法
    final overlayHandler = ref.read(overlayHandlerProvider);
    final liveActivityHandler = await ref.read(liveActivityHandlerProvider.future);
    
    overlayHandler.closeOverlay();
    await liveActivityHandler.endActivity();
    // 这里也可以添加关闭通知的逻辑
  }

  // 【移除】
  // `setDisplayMode` 的职责现在完全由 `callerIdConfigProvider.notifier` 承担。
  // DisplayModeHandler 只响应变化，不发起变化，职责更单一。
  //
  // Future<void> setDisplayMode(DisplayMode mode) async { ... }
}