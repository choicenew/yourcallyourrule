// caller_id_monitor_service.dart
// caller_id_monitor_service.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/services/notification_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/live_activities/services/live_notification_config_service.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/live_activity_handler.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

import '../../../core/entities/caller_id_data.dart';
import '../../../features/call/call_filter/call_filter_service.dart';
import '../../../features/call/time_interceptor/time_interceptor_service.dart';
import '../../call_statistic/domain/repositories/blocked_call_repository.dart';
import '../../../platform/call_channel_switcher.dart';
import 'call_handlers/base_call_handler.dart';
import 'call_handlers/caller_id_handler.dart';
import 'call_handlers/call_event_handler.dart';
import 'call_handlers/end_call_handler.dart';
import 'call_handlers/incoming_call_handler.dart';
import 'call_handlers/notification_handler.dart';
import 'call_handlers/outgoing_call_handler.dart';
import 'call_handlers/display_mode_handler.dart';
import 'call_handlers/overlay_handler.dart';
import 'call_handlers/should_accept_call_handler.dart';
import 'call_handlers/sim_call_handler.dart';
import 'call_handlers/stir_call_handler.dart';
import 'caller_id_service.dart';

/// 来电显示监控服务
/// 负责监控和处理来电显示相关的事件
class CallerIdMonitorService {
  // 平台通道管理器
  final CallChannelInterface _channelManager;

  // 服务依赖
  final CallerIdService _callerIdService;
  final CallFilterService _callFilterService;
  final TimeInterceptorService _timeInterceptorService;
  final BlockedCallRepository _blockedCallRepository;
  
  // 通知插件
  final FlutterLocalNotificationsPlugin notificationsPlugin;
  
  // 来电显示数据流
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  // 原始通话事件流
  final _rawCallEventController = StreamController<MethodCall>.broadcast();
  
  // 通知设置
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  bool useStirNotification = false;
  
  // 设置键名
  static const String callLocalNotificationKey = 'config_call_local_notification';
  static const String callCancelLocalNotificationKey = 'config_call_cancel_local_notification';
  static const String stirLocalNotificationKey = 'config_stir_local_notification';
  
  // 浮窗相关
  OverlayEntry? _currentOverlay;
  
  // 调用处理器工厂
  final CallHandlerFactory _handlerFactory = CallHandlerFactory();
  
  // 调用处理器
  late final CallEventHandler _callerIdCallHandler;
  late final ShouldAcceptCallHandler _shouldAcceptCallHandler;
  late final EndCallHandler _endCallHandler;
  late final StirCallHandler _stirCallHandler;
  late final SimCallHandler _simCallHandler;
  
  // 功能处理器
  late final CallHandler _callHandler;
  late final IncomingCallHandler _incomingCallHandler;
  late final OutgoingCallHandler _outgoingCallHandler;
  late final NotificationHandler _notificationHandler;
  late final DisplayModeHandler _displayModeHandler;
    // --- 新增：持有 LiveActivityHandler 实例 ---
  late final LiveActivityHandler _liveActivityHandler;

  // 来电显示数据流
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;
  Stream<MethodCall> get rawCallEventStream => _rawCallEventController.stream;
  Stream<CallData> get callDataStream => _callHandler.callDataStream;



  // MODIFICATION 2: 将成员变量的类型从 LocaleProvider 改为 Locale
  final Locale _locale;
  
  /// Updated constructor
  CallerIdMonitorService(
    this._callerIdService,
    this._callFilterService,
    this._timeInterceptorService,
     // MODIFICATION 3: 将构造函数参数的类型从 LocaleProvider 改为 Locale
    this._locale,
    {BlockedCallRepository? blockedCallRepository,
    FlutterLocalNotificationsPlugin? notificationsPlugin}
  ) : 
    _channelManager = CallChannelSwitcher.getPlatformChannelManager(),
    _blockedCallRepository = blockedCallRepository ?? BlockedCallRepository(),
    notificationsPlugin = notificationsPlugin ?? FlutterLocalNotificationsPlugin() {
    _initializeHandlers();
    _setupChannelCallbacks();
  }

  /// 初始化处理器
  void _initializeHandlers() {
    debugPrint('Initializing handlers 成功');
    // 创建配置仓库
    final configRepository = CallerIdConfigRepository(SharedPreferencesConfigRepository());

        // 2. 创建 NotificationService 的一个实例
    final notificationService = NotificationService();
    
    // 创建调用处理器
    _shouldAcceptCallHandler = ShouldAcceptCallHandler();
    _endCallHandler = EndCallHandler(configRepository);
    _stirCallHandler = StirCallHandler(_onStirInfoUpdated);
    _simCallHandler = SimCallHandler(_onSimInfoUpdated);
    
    // 创建通知处理器
      // 3. 修改 NotificationHandler 的创建方式
    //    不再传递 notificationsPlugin，而是传递我们刚创建的 notificationService
    _notificationHandler = NotificationHandler(
     notificationService: notificationService,
      configRepository: configRepository,
    );
    
        // --- 1. 创建 LiveNotificationConfigService ---
    final liveNotificationConfigService = LiveNotificationConfigService(SharedPreferencesConfigRepository());
    
    // --- 2. 创建并初始化 LiveActivityHandler ---
    _liveActivityHandler = LiveActivityHandler(
      configService: liveNotificationConfigService,
    );
    _liveActivityHandler.initialize(); // 确保在这里调用初始化

    // 创建显示模式处理器
     // 4. 修改 DisplayModeHandler 的创建方式
    //    添加必需的 notificationService 参数
    _displayModeHandler = DisplayModeHandler(
      configRepository: configRepository,
      notificationService: notificationService, // <-- 添加这一行
      notificationHandler: _notificationHandler,
            // --- 4. 将 liveActivityHandler 注入 ---
      liveActivityHandler: _liveActivityHandler, 
    );
    
    // 创建通话处理器
    _callHandler = CallHandler(
      callerIdService: _callerIdService,
      // 注意：你可能需要将 CallHandler 中的参数名从 localeProvider 改为 locale。
      locale: _locale, 
      displayModeHandler: _displayModeHandler,
    );
    
    // 创建来电处理器
    _incomingCallHandler = IncomingCallHandler(
      callHandler: _callHandler,
      callFilterService: _callFilterService,
      timeInterceptorService: _timeInterceptorService,
      shouldAcceptCallHandler: _shouldAcceptCallHandler,
      notificationHandler: _notificationHandler,
      configRepository: configRepository,
      blockedCallRepository: _blockedCallRepository,
    );
    
    // 创建去电处理器
    _outgoingCallHandler = OutgoingCallHandler(
      callHandler: _callHandler,
    );
    
    // 创建来电显示调用处理器
    _callerIdCallHandler = CallEventHandler(
      _channelManager, 
      null, // 不再使用旧的处理器
      incomingCallHandler: _incomingCallHandler,
      outgoingCallHandler: _outgoingCallHandler,
      onCallerIdDataReceived: (data) => _callerIdSubject.add(data),
    );
    
    // 注册处理器
    _handlerFactory.registerHandler('callerId', _callerIdCallHandler);
    _handlerFactory.registerHandler('shouldAcceptCall', _shouldAcceptCallHandler);
    _handlerFactory.registerHandler('endCall', _endCallHandler);
    _handlerFactory.registerHandler('stir', _stirCallHandler);
    _handlerFactory.registerHandler('sim', _simCallHandler);
  }
  


  /// 设置通道回调
  void _setupChannelCallbacks() {
    _channelManager.onCallerIdCall = _handleCallerIdCall;
    _channelManager.onShouldAcceptCallCall = _handleShouldAcceptCallCall;
    _channelManager.onEndCallCall = _handleEndCallCall;
    _channelManager.onStirCall = _handleStirCall;
    _channelManager.onSimCall = _handleSimCall;
  }

  /// 初始化服务
  Future<void> initialize() async {
    _channelManager.initialize();
    // 初始化来电显示通道
 
 
 
    await loadSettings();
    await _initializeNotifications();
    await _handlerFactory.initializeAll();
  }

  /// 加载设置
  Future<void> loadSettings() async {
    // 从通知处理器加载设置
    await _notificationHandler.loadSettings();
    
    // 更新本地变量
    useLocalNotification = _notificationHandler.useLocalNotification;
    cancelLocalNotification = _notificationHandler.cancelLocalNotification;
    useStirNotification = _notificationHandler.useStirNotification;
  }

  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;

    useLocalNotification = useLocal;
    await _notificationHandler.setUseLocalNotification(useLocal);
  }

  /// 设置是否关闭本地通知
  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;

    cancelLocalNotification = cancelLocal;
    await _notificationHandler.closeLocalNotification(cancelLocal);
  }

  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool useStir) async {
    if (useStirNotification == useStir) return;

    useStirNotification = useStir;
    await _notificationHandler.setUseStirNotification(useStir);
  }

  /// 初始化通知
  Future<void> _initializeNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(initializationSettings);
  }

  /// 处理来电显示调用
  void _handleCallerIdCall(MethodCall call) async {
    _rawCallEventController.add(call); // 广播原始事件
    await _callerIdCallHandler.handleMethodCall(call);
  }

  /// 处理是否接受来电调用
  Future<bool> _handleShouldAcceptCallCall(MethodCall call) async {
    return await _shouldAcceptCallHandler.handleMethodCall(call) as bool;
  }

  /// 处理结束通话调用
  Future<String?> _handleEndCallCall(MethodCall call) async {
    return await _endCallHandler.handleMethodCall(call) as String?;
  }

  /// 处理STIR验证调用
  void _handleStirCall(MethodCall call) {
    _stirCallHandler.handleMethodCall(call);
  }

  /// 处理SIM卡信息调用
  void _handleSimCall(MethodCall call) {
    _simCallHandler.handleMethodCall(call);
  }

  /// STIR信息更新回调
  void _onStirInfoUpdated(StirInfo stirInfo) {
    _callHandler.setStirInfo(stirInfo);
    _notificationHandler.processStirInfo(stirInfo);
  }

  /// SIM卡信息更新回调
  void _onSimInfoUpdated(SimInfo simInfo) {
    _callHandler.setSimInfo(simInfo);
  }

  /// 释放资源
  Future<void> dispose() async {
    _callerIdSubject.close();
    await _handlerFactory.disposeAll();
    
    // 关闭浮窗
    if (await FloatingWindowAndroid.isShowing()) {
      FloatingWindowAndroid.closeOverlay();
    }
  }
}
/*
//废弃的逻辑现在不再使用了
/// SharedPreferences异步包装类
/// 提供异步访问SharedPreferences的方法
class SharedPreferencesAsync {
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
*/