// 导入 Dart 核心包
import 'dart:async';
// 导入 Flutter 核心包
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入外部库
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:rxdart/rxdart.dart';
// 导入项目中的实体类
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
// 导入平台通道管理器
import 'package:yourcallyourrule/platform/call_channel_switcher.dart';
// 导入所有依赖的 Provider
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/base_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/call_event_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/end_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/incoming_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/outgoing_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/should_accept_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/sim_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/stir_call_handler.dart';

// part 指令是代码生成所必需的，它会链接到由 build_runner 生成的文件
part 'caller_id_monitor_service.g.dart';

/// 来电显示监控服务 Provider
///
/// 使用 Riverpod 3.0 的 AsyncNotifier API。
/// 这是整个来电处理流程的“大脑”和“总指挥”。
/// 它的 `build` 方法负责应用的整个通话处理服务的初始化流程。
///
/// 使用 `keepAlive: true` 确保此服务在应用启动后持续在后台运行，不会被意外销_destroy。
@Riverpod(keepAlive: true)
class CallerIdMonitorService extends _$CallerIdMonitorService {
  
  /// build 方法是 Provider 的初始化入口，它是一个异步方法。
  /// Riverpod 会等待这个方法执行完毕，然后将 Notifier 的状态设置为加载完成。
  /// 所有原先在构造函数和 `initialize()` 方法中的逻辑都被整合到了这里。
  @override
  Future<void> build() async {
    // --- 步骤 1: 获取所有依赖的 Handler 和 Service 实例 ---
    // 通过 ref.watch 从 Riverpod 容器中获取所有共享的、已经 Provider 化的实例。
    // 这取代了之前在 _initializeHandlers 方法中手动创建所有对象的逻辑。
    final callHandler = ref.watch(callHandlerProvider.notifier);
    final incomingCallHandler = await ref.watch(incomingCallHandlerProvider.future);
    final outgoingCallHandler = ref.watch(outgoingCallHandlerProvider);
    final shouldAcceptCallHandler = ref.watch(shouldAcceptCallHandlerProvider);
    final endCallHandler = ref.watch(endCallHandlerProvider);
    final stirCallHandler = ref.watch(stirCallHandlerProvider.notifier);
    final simCallHandler = ref.watch(simCallHandlerProvider.notifier);
    final notificationHandler = await ref.watch(notificationHandlerProvider.future);

    // --- 步骤 2: 设置原生通道回调 ---
    // 将从 Riverpod 获取到的、状态同步的 Handler 注册到原生通道管理器。
    final channelManager = CallChannelSwitcher.getPlatformChannelManager();
    
    // 注册 CallerIdCall 回调, 这是处理所有来去电事件的总入口
    channelManager.onCallerIdCall = (call) async {
      _rawCallEventController.add(call); // 广播原始事件以供调试或其他服务使用
      // CallEventHandler 是一个无状态的逻辑分发器，可以在这里临时创建
      final callEventHandler = CallEventHandler(
        channelManager,
        null,
        incomingCallHandler: incomingCallHandler,
        outgoingCallHandler: outgoingCallHandler,
        onCallerIdDataReceived: (data) => _callerIdSubject.add(data),
      );
      await callEventHandler.handleMethodCall(call);
    };
    // 注册其他专门的通道回调
    channelManager.onShouldAcceptCallCall = shouldAcceptCallHandler.handleMethodCall;
    channelManager.onEndCallCall = endCallHandler.handleMethodCall;
    channelManager.onStirCall = stirCallHandler.handleMethodCall;
    channelManager.onSimCall = simCallHandler.handleMethodCall;
    
    // --- 步骤 3: 初始化原生通道管理器 ---
    // 这一步会设置所有原生端的 MethodCallHandler。
    channelManager.initialize();

    // --- 步骤 4: 注册处理器到工厂 (如果仍然需要 CallHandlerFactory 架构) ---
    // 这个工厂模式在完全的 Riverpod 架构中可以被简化或移除，
    // 但我们暂时保留以兼容您可能存在的其他逻辑。
    final handlerFactory = CallHandlerFactory();
    handlerFactory.registerHandler('shouldAcceptCall', shouldAcceptCallHandler);
    handlerFactory.registerHandler('endCall', endCallHandler);
    // Notifier 实例本身就实现了 BaseCallHandler 接口
    handlerFactory.registerHandler('stir', stirCallHandler); 
    handlerFactory.registerHandler('sim', simCallHandler);
    
    // --- 步骤 5: 执行服务自身的其他初始化逻辑 (原 initialize() 方法的内容) ---
    await loadSettings(notificationHandler);
    await _initializeNotifications();
    await handlerFactory.initializeAll();

    // --- 步骤 6: 设置清理逻辑 ---
    // 使用 ref.onDispose 注册一个回调，当这个 Provider 被销毁时自动执行。
    ref.onDispose(() async {
      _callerIdSubject.close();
      _rawCallEventController.close();
      await handlerFactory.disposeAll();
      if (await FloatingWindowAndroid.isShowing()) {
        FloatingWindowAndroid.closeOverlay();
      }
      debugPrint('CallerIdMonitorService disposed.');
    });

    debugPrint('CallerIdMonitorService build method completed successfully.');
  }

  // --- 成员变量 ---

  /// 用于显示本地通知的插件实例。
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  
  /// 用于广播最终生成的 CallerIdData 的数据流。
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  
  /// 用于广播从原生端接收到的原始 MethodCall 事件的数据流。
  final _rawCallEventController = StreamController<MethodCall>.broadcast();
  
  // --- 公共 Getter 和方法 ---

  /// 外部可以监听此流来获取最终的来电显示数据。
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;
  
  /// 外部可以监听此流来获取原始的原生调用事件。
  Stream<MethodCall> get rawCallEventStream => _rawCallEventController.stream;
  
  /// 代理 CallHandler 的 callDataStream，方便外部统一从此服务访问。
  Stream<CallData> get callDataStream => ref.read(callHandlerProvider.notifier).callDataStream;

  /// 加载通知相关的设置。
  /// 这个方法现在接收一个 NotificationHandler 实例作为参数。
  Future<void> loadSettings(NotificationHandler notificationHandler) async {
    // 设置现在由各自的 Handler 内部加载，这个方法只是触发它。
    await notificationHandler.loadSettings();
  }

  /// 动态设置是否使用本地通知。
  Future<void> setUseLocalNotification(bool useLocal) async {
    // 从 ref 读取最新的 notificationHandler 实例并调用其方法。
    final notificationHandler = await ref.read(notificationHandlerProvider.future);
    await notificationHandler.setUseLocalNotification(useLocal);
  }

  /// 动态设置是否关闭本地通知。
  Future<void> closeLocalNotification(bool cancelLocal) async {
    final notificationHandler = await ref.read(notificationHandlerProvider.future);
    await notificationHandler.closeLocalNotification(cancelLocal);
  }

  /// 动态设置是否使用STIR通知。
  Future<void> setUseStirNotification(bool useStir) async {
    final notificationHandler = await ref.read(notificationHandlerProvider.future);
    await notificationHandler.setUseStirNotification(useStir);
  }

  /// 初始化 FlutterLocalNotificationsPlugin 插件。
  Future<void> _initializeNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(initializationSettings);
  }
}