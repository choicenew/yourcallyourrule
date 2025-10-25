// 文件路径: lib/features/caller_id/services/overlay_control_handler.dart (或你选择的任何位置)

// 导入 Dart 和 Flutter 核心包
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// 导入 Riverpod 和代码生成相关包
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 导入外部依赖包
import 'package:floating_window_android/floating_window_android.dart';

// 导入项目内部依赖
import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service.dart';

// part 指令，用于代码生成
part 'overlay_control_handler.g.dart';

// --- Step 1: Provider Definition ---
// 我们将 Provider 的定义放在文件的顶部。

/// OverlayControlHandler 的 Riverpod Provider
///
/// 它的职责是创建、初始化并管理 OverlayControlHandler 实例的生命周期。
/// 它遵循与 callEventListenerProvider 完全相同的成功模式，以确保初始化的稳定性和可靠性。
///
/// - `@Riverpod(keepAlive: true)`: 确保这个服务在整个应用生命周期内持续运行，不会被意外销毁。
@Riverpod(keepAlive: true)
OverlayControlHandler overlayControlHandler(Ref ref) {
  
  // 1. 获取依赖。
  //    我们假设 CallerIdMonitorService (生产者) 已经在应用启动时（如 main.dart）
  //    被 `await` 并完全初始化了。因此，这里可以安全地使用 `ref.read` 来获取其实例。
  final monitorService = ref.read(callerIdMonitorServiceProvider.notifier);

  // 2. 创建服务类的实例，并将依赖注入。
  final handler = OverlayControlHandler(monitorService);
  
  // 3. 调用实例的初始化方法，使其立即开始监听事件流。
  handler.initialize();

  // 4. 注册清理逻辑。
  //    当此 Provider 被销毁时（通常是应用关闭时），会自动调用 handler.dispose()
  //    来取消订阅，防止内存泄漏。
  ref.onDispose(() => handler.dispose());

  // 5. 返回完全初始化好的服务实例。
  return handler;
}


// --- Step 2: Service Class Definition ---
// 服务的具体实现类紧随其 Provider 定义之后。

/// 浮窗控制处理器 (纯 Dart 类)
///
/// 这是一个与 Riverpod 完全解耦的、职责单一的服务类。
/// 它的唯一任务就是：监听来自 CallerIdMonitorService 的原始事件流，
/// 并在接收到特定事件（如电话接听或挂断）时，执行关闭浮窗的操作。
class OverlayControlHandler {
  // 持有其依赖项的引用
  final CallerIdMonitorService _monitorService;

  // 用于管理事件流的订阅，以便在销毁时可以取消
  StreamSubscription<MethodCall>? _subscription;

  /// 构造函数，接收其依赖的服务。
  OverlayControlHandler(this._monitorService);

  /// 初始化方法
  /// 由其对应的 Provider 在创建实例后调用。
  void initialize() {
    // 最佳实践：在重新订阅前先取消旧的订阅，确保操作的幂等性。
    _subscription?.cancel(); 
    
    // 订阅来自 Monitor 服务的原始事件流
    _subscription = _monitorService.rawCallEventStream.listen(_handleMethodCall);
    
    // 打印日志以确认初始化成功
    debugPrint("✅ [OverlayControlHandler] Initialized and is now listening to rawCallEventStream.");
  }

  /// 私有的事件处理方法
  /// 这是所有业务逻辑的核心。
  Future<void> _handleMethodCall(MethodCall call) async {
    // 打印接收到的事件，便于调试
    debugPrint('🖼️ [OverlayControlHandler] Received event: ${call.method}');
    
    switch (call.method) {
    
      // 我们只关心这两个表示通话状态结束的事件
      case 'onCallAnswered':
      case 'onCallEnded':
        debugPrint('... Event matched. Preparing to close overlay...');
          await FloatingWindowAndroid.closeOverlay();
/*
        // 确保只在 Android 平台上执行
        if (defaultTargetPlatform == TargetPlatform.android) {
          // 在尝试关闭前，先检查浮窗是否真的在显示，避免不必要的调用和潜在错误。
          if (await FloatingWindowAndroid.isShowing()) {
            await FloatingWindowAndroid.closeOverlay();
            debugPrint('✅ [OverlayControlHandler] Overlay successfully closed.');
          } else {
            debugPrint('ℹ️ [OverlayControlHandler] Overlay was not showing, no action needed.');
          }

        }
        */
        break;
      
      // 忽略所有其他不相关的事件
      default:
        break;
    }
  }

  /// 清理方法
  /// 由 Provider 的 `ref.onDispose` 回调来触发。
  void dispose() {
    // 取消流订阅是防止内存泄漏的关键步骤。
    _subscription?.cancel();
    
    // 打印日志以确认清理成功
    debugPrint("🗑️ [OverlayControlHandler] Disposed and cancelled subscription.");
  }
}