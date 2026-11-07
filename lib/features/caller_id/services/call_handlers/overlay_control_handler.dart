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
// 【核心新增】导入拦截事件 Provider，以便我们能监听到拦截决策
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/intercept_event_provider.dart';

// part 指令，用于代码生成
part 'overlay_control_handler.g.dart';

// --- Step 1: Provider Definition ---
// 我们将 Provider 的定义放在文件的顶部。

/// OverlayControlHandler 的 Riverpod Provider
///
/// 它的职责是创建、初始化并管理 OverlayControlHandler 实例的生命周期。
/// 它是一个独立的、自启动的服务，负责响应通话状态变化来控制浮窗的关闭。
///
/// - `@Riverpod(keepAlive: true)`: 确保这个服务在整个应用生命周期内持续运行。
@Riverpod(keepAlive: true)
OverlayControlHandler overlayControlHandler(Ref ref) {
  
  // 1. 获取依赖。
  final monitorService = ref.read(callerIdMonitorServiceProvider.notifier);
  // 【核心新增】获取拦截事件流的控制器，以便订阅其 stream
  final interceptEventController = ref.read(interceptEventStreamControllerProvider);

  // 2. 创建服务类的实例，并将所有依赖注入。
  final handler = OverlayControlHandler(monitorService, interceptEventController.stream);
  
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
/// 职责单一的服务类，负责在适当的时候关闭来电浮窗。
/// 它监听两个事件源：
/// 1. **原始通话事件**: 如电话被接听(`onCallAnswered`)或正常挂断(`onCallEnded`)。
/// 2. **应用内拦截事件**: 当我们的应用决定自动拦截一个电话时。
class OverlayControlHandler {
  final CallerIdMonitorService _monitorService;
  // 【核心新增】持有对拦截事件流的引用
  final Stream<InterceptEvent> _interceptEventStream;

  // 用于管理事件流的订阅
  StreamSubscription<MethodCall>? _rawCallSubscription;
  StreamSubscription<InterceptEvent>? _interceptEventSubscription;

  /// 构造函数，接收其依赖的服务和事件流。
  OverlayControlHandler(this._monitorService, this._interceptEventStream);

  /// 初始化方法，由其 Provider 调用。
  void initialize() {
    // 清理旧的订阅
    _rawCallSubscription?.cancel(); 
    _interceptEventSubscription?.cancel();
    
    // 订阅来自 Monitor 服务的原始事件流
    _rawCallSubscription = _monitorService.rawCallEventStream.listen(_handleRawCallEvent);
    // 【核心新增】订阅拦截事件流
    _interceptEventSubscription = _interceptEventStream.listen(_handleInterceptEvent);
    
    debugPrint("✅ [OverlayControlHandler] Initialized and listening to rawCallEventStream and interceptEventStream.");
  }

  /// 处理原始通话事件
  void _handleRawCallEvent(MethodCall call) {
    debugPrint('🖼️ [OverlayControlHandler] Received raw call event: ${call.method}');
    
    switch (call.method) {
      // 电话被接听或正常挂断时，关闭浮窗
      case 'onCallAnswered':
      case 'onCallEnded':
  
  
  
  
        debugPrint('... Raw call event matched. Closing overlay...');
        _closeOverlay();
        break;
      
      default:
        // 忽略其他事件
        break;
    }
  }

  /// 【核心新增】处理应用内拦截事件
  void _handleInterceptEvent(InterceptEvent event) {
    
    debugPrint('🖼️ [OverlayControlHandler] Received intercept event for ${event.phoneNumber}, action: ${event.actionName}');
         switch (event.actionName) {
       case   'endCall':
      case 'answerThenHangup':
      case 'silenceNoAnswer':
         debugPrint('... Intercept event matched. Closing overlay...');
         _closeOverlay();
         break;
       default:
    // 只要收到任何拦截事件，就意味着电话即将被系统处理掉，我们应该立即关闭浮窗。
    debugPrint('... Intercept event matched. Closing overlay...');
    _closeOverlay();
  }
}

  /// 统一的、安全的关闭浮窗方法
  Future<void> _closeOverlay() async {
    // 确保只在 Android 平台上执行
    if (defaultTargetPlatform == TargetPlatform.android) {
await FloatingWindowAndroid.closeOverlay();
/*
      try {
        // 在尝试关闭前，先检查浮窗是否真的在显示。
        if (await FloatingWindowAndroid.isShowing()) {
          await FloatingWindowAndroid.closeOverlay();
          debugPrint('✅ [OverlayControlHandler] Overlay successfully closed.');
        } else {
          debugPrint('ℹ️ [OverlayControlHandler] Overlay was not showing, no action needed.');
        }
      } catch (e) {
        debugPrint('❌ [OverlayControlHandler] Error closing overlay: $e');
      }
*/

    }
  }

  /// 清理方法，由 Provider 的 `ref.onDispose` 触发。
  void dispose() {
    // 取消所有订阅，防止内存泄漏。
    _rawCallSubscription?.cancel();
    _interceptEventSubscription?.cancel();
    
    debugPrint("🗑️ [OverlayControlHandler] Disposed and cancelled all subscriptions.");
  }
}