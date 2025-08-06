import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../router/app_router.dart';

/// 通知配置类
/// 用于配置通知的各种参数
class NotificationConfig {
  final String channelId;
  final String channelName;
  final String channelDescription;
  final Importance importance;
  final Priority priority;
  final Duration autoCancelDelay;
  final bool playSound;
  final String? soundSource;
  final bool enableVibration;
  final bool showBadge;
  final Color? color;

  const NotificationConfig({
    required this.channelId,
    required this.channelName,
    this.channelDescription = '',
    this.importance = Importance.defaultImportance,
    this.priority = Priority.defaultPriority,
    this.autoCancelDelay = const Duration(seconds: 5),
    this.playSound = true,
    this.soundSource,
    this.enableVibration = true,
    this.showBadge = true,
    this.color,
  });

  /// 创建AndroidNotificationDetails
  AndroidNotificationDetails createAndroidDetails() {
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
      playSound: playSound,
      sound: soundSource != null ? RawResourceAndroidNotificationSound(soundSource!) : null,
      enableVibration: enableVibration,
      channelShowBadge: showBadge,
      color: color,
    );
  }
}

/// 通知服务类
/// 负责处理应用内所有通知相关的功能
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  
  factory NotificationService({NotificationConfig? defaultConfig, FlutterLocalNotificationsPlugin? notificationsPlugin}) {
    if (defaultConfig != null) {
      _instance._defaultConfig = defaultConfig;
    }
    if (notificationsPlugin != null) {
      _instance._plugin = notificationsPlugin;
    }
    return _instance;
  }
  
  NotificationService._internal() {
    _plugin = FlutterLocalNotificationsPlugin();
    _initialize();
  }

  late FlutterLocalNotificationsPlugin _plugin;
  NotificationConfig _defaultConfig = const NotificationConfig(
    channelId: 'default_channel', // Default Channel
    channelName: 'Default Notifications',
    channelDescription: 'Default notification channel for the app.',
    importance: Importance.high,
    priority: Priority.high,
  );
  
  final Map<String, NotificationConfig> _configCache = {};
  bool _isInitialized = false;

  /// Pre-defined notification configurations
  static final blockedCallConfig = NotificationConfig(
    channelId: 'blocked_calls', // Blocked Calls
    channelName: 'Blocked Call Notifications',
    channelDescription: 'Displays information about blocked calls.',
    importance: Importance.max,
    priority: Priority.high,
    playSound: false,
  );

  static final stirResultConfig = NotificationConfig(
    channelId: 'stir_results', // STIR/SHAKEN Results
    channelName: 'STIR/SHAKEN Verification',
    channelDescription: 'Displays STIR/SHAKEN verification results for numbers.',
    importance: Importance.high,
    priority: Priority.high,
  );

  static final fraudAlertConfig = NotificationConfig(
    channelId: 'fraud_alert', // Fraud Alerts
    channelName: 'Fraud Alert Warnings',
    channelDescription: 'Displays warnings for potential fraudulent calls.',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );
  
  /// 初始化通知服务
  Future<void> _initialize() async {
    if (_isInitialized) return;
    
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    
    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
    
    // 创建默认通知渠道
    await _createNotificationChannel(_defaultConfig);
    
    // 创建预定义的通知渠道
    await _createNotificationChannel(blockedCallConfig);
    await _createNotificationChannel(stirResultConfig);
    
    _isInitialized = true;
  }
  
  /// 处理通知响应
  void _onNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null) return;

    try {
      final Map<String, dynamic> data = jsonDecode(payload);
      final type = data['type'];

      // 全局导航处理
      final context = AppRouter.navigatorKey.currentContext;
      if (context != null) {
        if (type == 'call_history' || type == 'fraud_alert' || type == 'blocked_call' || type == 'stir_result') {
          GoRouter.of(context).go(AppRouter.callHistory);
        } else if (type == 'sms' || type == 'blocked_sms') {
          // 可以在此处添加 SMS 相关页面的导航
          // 例如：GoRouter.of(context).go(AppRouter.smsHistory);
        }
      }

      // 保留旧的处理方式以兼容
      _notificationTapHandlers.forEach((handler) => handler(data));
    } catch (e) {
      debugPrint('Error handling notification response: $e');
    }
  }
  
  final List<Function(Map<String, dynamic>)> _notificationTapHandlers = [];
  final Map<String, List<Function(String, Map<String, dynamic>?)>> _actionHandlers = {};
  
  /// 注册通知点击处理器
  void registerNotificationTapHandler(Function(Map<String, dynamic>) handler) {
    _notificationTapHandlers.add(handler);
  }
  
  /// 注册通知动作处理器
  void registerActionHandler(String actionId, Function(String, Map<String, dynamic>?) handler) {
    if (!_actionHandlers.containsKey(actionId)) {
      _actionHandlers[actionId] = [];
    }
    _actionHandlers[actionId]!.add(handler);
  }
  
  /// 创建通知渠道
  Future<void> _createNotificationChannel(NotificationConfig config) async {
    final androidChannel = AndroidNotificationChannel(
      config.channelId,
      config.channelName,
      description: config.channelDescription,
      importance: config.importance,
      playSound: config.playSound,
      sound: config.soundSource != null ? RawResourceAndroidNotificationSound(config.soundSource!) : null,
      enableVibration: config.enableVibration,
      showBadge: config.showBadge,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
    
    // 缓存配置
    _configCache[config.channelId] = config;
  }
  
  /// 显示通知
  /// [title] 通知标题
  /// [body] 通知内容
  /// [config] 通知配置
  /// [notificationId] 通知ID，用于更新或取消通知
  /// [payload] 通知负载，可用于点击通知时传递数据
  Future<void> showNotification({
    required String title,
    required String body,
    required NotificationConfig config,
    int notificationId = 0,
    Map<String, dynamic>? payload,
    bool autoCancel = true,
    Duration? autoCancelDelay,
  }) async {
    if (!_isInitialized) await _initialize();

    // 创建Android通知详情
    final androidDetails = config.createAndroidDetails();

    // 显示通知
    await _plugin.show(
      notificationId,
      title,
      body,
      NotificationDetails(android: androidDetails),
      payload: payload != null ? jsonEncode(payload) : null,
    );

    // 自动取消通知
    if (autoCancel) {
      final delay = autoCancelDelay ?? config.autoCancelDelay;
      await Future.delayed(delay);
      await _plugin.cancel(notificationId);
    }
  }

  /// 取消通知
  Future<void> cancelNotification(int notificationId) async {
    await _plugin.cancel(notificationId);
  }

  /// 取消所有通知
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  /// 检查通知权限
  Future<bool> checkNotificationPermission() async {
    // 使用permission_handler插件检查通知权限
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  /// 请求通知权限
  Future<bool> requestNotificationPermission() async {
    // 使用permission_handler插件请求通知权限
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// 打开通知设置
  Future<void> openNotificationSettings() async {
    // 使用permission_handler插件打开通知设置
    await openAppSettings();
  }

  /// 重定向到页面
  static void redirectToPage(String routeName, Map<String, dynamic>? params) {
    // 需要结合项目路由系统实现
  }
}

/// 通知动作类
class NotificationAction {
  /// 动作ID
  final String id;
  
  /// 动作标题
  final String title;
  
  /// 是否为破坏性动作（通常显示为红色）
  final bool isDestructive;
  
  /// 是否在后台处理（不会打开应用）
  final bool isBackground;
  
  /// 构造函数
  const NotificationAction({
    required this.id,
    required this.title,
    this.isDestructive = false,
    this.isBackground = false,
  });
}

/// 通知重要性级别枚举
enum NotificationImportance {
  none,      // 无声音，无视觉干扰
  min,       // 无声音，状态栏图标
  low,       // 无声音，状态栏和通知栏可见
  default_,  // 有声音，状态栏和通知栏可见
  high,      // 有声音，状态栏和通知栏可见，可能会有横幅
  max,       // 有声音，状态栏和通知栏可见，会有横幅和全屏意图
}

/// 扩展方法，将自定义枚举转换为Flutter枚举
extension NotificationImportanceExtension on NotificationImportance {
  Importance toAndroidImportance() {
    switch (this) {
      case NotificationImportance.none:
        return Importance.none;
      case NotificationImportance.min:
        return Importance.min;
      case NotificationImportance.low:
        return Importance.low;
      case NotificationImportance.default_:
        return Importance.defaultImportance;
      case NotificationImportance.high:
        return Importance.high;
      case NotificationImportance.max:
        return Importance.max;
    }
  }
}