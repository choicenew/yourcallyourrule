// 导入 Dart 核心包
import 'dart:async';
// 导入 Flutter 核心包
import 'package:flutter/foundation.dart';


import 'package:flutter/services.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入外部库
import 'package:floating_window_android/floating_window_android.dart';
import 'package:rxdart/rxdart.dart';
// 导入项目中的实体类
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
// 导入平台通道管理器
import 'package:yourcallyourrule/platform/call_channel_switcher.dart';
// 导入所有依赖的 Provider 和 Handler
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/call_event_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/end_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/incoming_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/outgoing_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/should_accept_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/sim_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/stir_call_handler.dart';

// part 指令是代码生成所必需的
part 'caller_id_monitor_service.g.dart';

/// 全局的、唯一的 CallerIdData 数据流控制器 Provider
/// 使用 `@Riverpod(keepAlive: true)` 确保它是一个真正的全局单例，
/// 不会被意外销毁，可以被后台服务安全地、持续地监听。
@Riverpod(keepAlive: true)
BehaviorSubject<CallerIdData> callerIdDataSubject(Ref ref) {
  final subject = BehaviorSubject<CallerIdData>();
  ref.onDispose(() => subject.close());
  return subject;
}





/// 全局的、唯一的原始事件流控制器 Provider
/// 使用 `keepAlive: true` 确保它的生命周期独立于任何 Notifier，不会被热重载影响。
@Riverpod(keepAlive: true)
StreamController<MethodCall> rawCallEventStreamController(Ref ref) {
  final controller = StreamController<MethodCall>.broadcast();
  // `ref.onDispose` 会在容器被销毁时（即应用完全关闭时）关闭 controller
  ref.onDispose(() => controller.close());
  return controller;
}



/// 来电显示监控服务 Provider
///
/// 使用 Riverpod 3.0 的 AsyncNotifier API。
/// 这是整个来电处理流程的“大脑”和“总指挥”。
/// 它的 `build` 方法只在服务第一次启动时执行一次，负责设置好与原生代码的通信桥梁。
@Riverpod(keepAlive: true)
class CallerIdMonitorService extends _$CallerIdMonitorService {

  /// build 方法是 Provider 的初始化入口。
  /// 【最终修正】: 它只负责一次性的设置，不缓存任何会被热重载影响的 Handler 实例。
  @override
  Future<void> build() async {
    // --- 步骤 1: 预热所有依赖的 Provider ---
    // `ref.watch` 会确保这些 Provider 被创建并保持活动状态，以便在需要时能被 `ref.read` 立即访问。
    // 我们 `await` 异步的 provider，以确保它们在设置回调前已完全就绪。
    await ref.watch(incomingCallHandlerProvider.future);
    ref.watch(outgoingCallHandlerProvider);
    ref.watch(shouldAcceptCallHandlerProvider);
    ref.watch(endCallHandlerProvider);
    ref.watch(stirCallHandlerProvider);
    ref.watch(simCallHandlerProvider);
    await ref.watch(notificationHandlerProvider.future);
    
    // --- 步骤 2: 设置原生通道回调 ---
    // 将 channelManager 的回调全部指向本类的 _handle... 方法，保持中央路由的角色。
    final channelManager = CallChannelSwitcher.getPlatformChannelManager();
    channelManager.onCallerIdCall = _handleCallerIdCall;
    channelManager.onShouldAcceptCallCall = _handleShouldAcceptCallCall;
    channelManager.onEndCallCall = _handleEndCallCall;
    channelManager.onStirCall = _handleStirCall;
    channelManager.onSimCall = _handleSimCall;
    
    // --- 步骤 3: 初始化原生通道管理器 ---
    // 这一步会设置好所有原生端的 MethodCallHandler，让它们开始监听。
    channelManager.initialize();

    // --- 步骤 4: 设置清理逻辑 ---
    // 使用 ref.onDispose 注册回调，当 Provider 被销毁时执行。
    ref.onDispose(() async {
      // 在这里可以放置清理逻辑，例如关闭浮窗
      if (await FloatingWindowAndroid.isShowing()) {
        FloatingWindowAndroid.closeOverlay();
      }
      debugPrint('>>> 【MONITOR】: CallerIdMonitorService disposed.');
    });

    debugPrint('>>> 【MONITOR】: CallerIdMonitorService build method completed successfully.');
  }

  // --- 公共 Getter ---

  /// 外部可以监听此流来获取最终的来电显示数据。
  Stream<CallerIdData> get callerIdStream => ref.read(callerIdDataSubjectProvider).stream;

  /// 外部可以监听此流来获取原始的原生调用事件。
  Stream<MethodCall> get rawCallEventStream => ref.read(rawCallEventStreamControllerProvider).stream;

  /// 代理 CallHandler 的 callDataStream，方便外部统一从此服务访问。
  Stream<CallData> get callDataStream => ref.read(callHandlerProvider.notifier).callDataStream;

  // --- 【最终修正】: 所有 _handle...Call 方法都在被调用时，通过 `ref.read` 动态地读取最新的 Handler 实例 ---
  
  /// 处理来电显示总调用 (总入口)
  void _handleCallerIdCall(MethodCall call) async {
    // 广播原始事件
    ref.read(rawCallEventStreamControllerProvider).add(call);
    
    // 动态地创建 CallEventHandler，并注入最新的依赖实例。
    // CallEventHandler 是一个无状态的分发器，所以每次都创建新的实例是安全的。
    final callEventHandler = CallEventHandler(
      CallChannelSwitcher.getPlatformChannelManager(),
      null,
      incomingCallHandler: await ref.read(incomingCallHandlerProvider.future),
      outgoingCallHandler: ref.read(outgoingCallHandlerProvider),
      // 回调直接 add 到全局的 Subject
      onCallerIdDataReceived: (data) => ref.read(callerIdDataSubjectProvider).add(data),
    );
    await callEventHandler.handleMethodCall(call);
  }

  /// 处理是否接受来电调用
  Future<bool> _handleShouldAcceptCallCall(MethodCall call) async {
    // 每次调用时，都从容器中读取当前最新的实例
    final handler = ref.read(shouldAcceptCallHandlerProvider);
    debugPrint(">>> 【MONITOR】: Routing to ShouldAcceptCallHandler with hashCode: ${handler.hashCode}");
    return await handler.handleMethodCall(call);
  }

  /// 处理结束通话调用
  Future<String?> _handleEndCallCall(MethodCall call) async {
    // 每次调用时，都从容器中读取当前最新的实例
    final handler = ref.read(endCallHandlerProvider);
    debugPrint(">>> 【MONITOR】: Routing to EndCallHandler with hashCode: ${handler.hashCode}");
    return await handler.handleMethodCall(call);
  }

  /// 处理STIR验证调用
  void _handleStirCall(MethodCall call) {
    // 每次调用时，都从容器中读取当前最新的实例
    final handler = ref.read(stirCallHandlerProvider.notifier);
    debugPrint(">>> 【MONITOR】: Routing to StirCallHandler with hashCode: ${handler.hashCode}");
    handler.handleMethodCall(call);
  }

  /// 处理SIM卡信息调用
  void _handleSimCall(MethodCall call) {
    // 每次调用时，都从容器中读取当前最新的实例
    final handler = ref.read(simCallHandlerProvider.notifier);
    debugPrint(">>> 【MONITOR】: Routing to SimCallHandler with hashCode: ${handler.hashCode}");
    handler.handleMethodCall(call);
  }
}