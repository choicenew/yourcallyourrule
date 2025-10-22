// features/notifications/services/notification_service.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import '../config/notification_config.dart';
import 'notification_service_contract.dart';
import 'package:go_router/go_router.dart';

/// 基于 flutter_local_notifications 的 NotificationService 实现
class NotificationService implements NotificationServiceContract {
  
  NotificationService() {
    _plugin = FlutterLocalNotificationsPlugin();
  }

  late final FlutterLocalNotificationsPlugin _plugin;
  Function(Map<String, dynamic>? payload)? _onTapHandler;
  Function(String actionId, Map<String, dynamic>? payload)? _onActionHandler;
  bool _isInitialized = false;

  /// 预定义的通知配置，现在是需要 BuildContext 的静态方法
  static NotificationConfig defaultConfig(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NotificationConfig(
      channelId: 'default_channel',
      channelName: l10n.defaultNotifications,
      channelDescription: l10n.defaultNotificationsDescription,
    );
  }
  
  static NotificationConfig blockedCallConfig(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NotificationConfig(
      channelId: 'blocked_calls',
      channelName: l10n.blockedCallNotifications,
      channelDescription: l10n.blockedCallNotificationsDescription,
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
    );
  }

  static NotificationConfig stirResultConfig(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NotificationConfig(
      channelId: 'stir_results',
      channelName: l10n.stirVerification,
      channelDescription: l10n.stirVerificationDescription,
      importance: Importance.high,
      priority: Priority.high,
    );
  }

  static NotificationConfig fraudAlertConfig(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NotificationConfig(
      channelId: 'fraud_alert',
      channelName: l10n.fraudAlerts,
      channelDescription: l10n.fraudAlertsDescription,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
            // 【关键】: 将颜色设置为红色。Android 会用这个颜色给小图标着色。
      color: Colors.red,
    );
  }

  static NotificationConfig deletionProposalConfig(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NotificationConfig(
      channelId: 'deletion_proposals',
      channelName: l10n.deletionProposals,
      channelDescription: l10n.deletionProposalNotificationDescription,
      importance: Importance.high,
      priority: Priority.high,
    );
  }

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

      // 【核心修正】: 使用一个专门的、存在于 drawable 目录下的图标来初始化。
    // 'ic_notification' 应该是您放置在 `android/app/src/main/res/drawable` 下的图标文件名。
    const initializationSettingsAndroid = AndroidInitializationSettings('ic_notification');
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    
    await _plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );

    // Channel creation is now handled on-demand in showNotification
    _isInitialized = true;
  }

  void _onNotificationResponse(NotificationResponse response) {
    Map<String, dynamic>? payload;
    if (response.payload != null && response.payload!.isNotEmpty) {
      payload = jsonDecode(response.payload!);
    }
    if (response.actionId != null && response.actionId!.isNotEmpty && _onActionHandler != null) {
      _onActionHandler!(response.actionId!, payload);
    } else if (_onTapHandler != null) {
      _onTapHandler!(payload);
    }

    if (payload != null) {
      _handleGlobalNavigation(payload);
    }
  }

  void _handleGlobalNavigation(Map<String, dynamic> data) {
    final type = data['type'];
    final context = AppRouter.navigatorKey.currentContext;
    if (context != null) {
      if (type == 'call_history' || type == 'fraud_alert' || type == 'blocked_call' || type == 'stir_result') {
        GoRouter.of(context).go(AppRouter.callHistory);
      }
    }
  }

  @pragma('vm:entry-point')
  static void onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
    debugPrint("Handling a background notification: ${response.payload}");
  }

  @override
  void onNotificationTapped(Function(Map<String, dynamic>? payload) handler) { _onTapHandler = handler; }
  @override
  void onNotificationActionTapped(Function(String actionId, Map<String, dynamic>? payload) handler) { _onActionHandler = handler; }

  /// 私有方法，用于确保通知渠道在使用前已被创建
  Future<void> _createNotificationChannel(NotificationConfig config) async {
    final androidChannel = AndroidNotificationChannel(
      config.channelId, config.channelName,
      description: config.channelDescription, importance: config.importance,
    );
    await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  @override
  Future<void> showNotification({
    required String title, required String body, required NotificationConfig config,
    int notificationId = 0, Map<String, dynamic>? payload,
    bool autoCancel = true, Duration? autoCancelDelay,
        // 【核心修正】: 接收新的可选参数
  // 【最终修正】: 接收通用的 NotificationStyle 对象
    NotificationStyle? style,
  }) async {
    if (!_isInitialized) await initialize();
    await _createNotificationChannel(config);
        // 【核心修正】:
       // 【最终修正】:
    // 1. 从 config 创建一个基础的 AndroidNotificationDetails。
    AndroidNotificationDetails androidDetails = config.createAndroidDetails();
    
    // 2. 如果外部传入了 style 对象，则用它的信息来“增强” androidDetails。
    if (style != null) {
      // a. 准备大图标
      AndroidBitmap<Object>? largeIcon;
      if (style.largeIconPath != null) {
        largeIcon = FilePathAndroidBitmap(style.largeIconPath!);
      }

      // b. 准备样式信息
      StyleInformation? styleInformation;
      if (style.useBigTextStyle) {
        styleInformation = BigTextStyleInformation(
           body,
          // 也可以在这里设置展开时的标题和摘要，如果需要的话
          //contentTitle: title,
          // summaryText: 'Expand to see more',
          );
      }

      // c. 使用 copyWith 方法创建一个新的、增强版的 androidDetails
      // (注意: AndroidNotificationDetails 没有 copyWith, 我们需要手动重建)
      androidDetails = AndroidNotificationDetails(
        config.channelId,
        config.channelName,
        channelDescription: config.channelDescription,
        importance: config.importance,
        priority: config.priority,
        // 应用 style 中的增强属性
        largeIcon: largeIcon,
        color: style.color,
        styleInformation: styleInformation,
        // 保留 config 中的其他属性
        playSound: config.playSound,
        sound: config.soundSource != null ? RawResourceAndroidNotificationSound(config.soundSource!) : null,
        enableVibration: config.enableVibration,
        channelShowBadge: config.showBadge,
      );
    }
    
    final details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      notificationId, title, body, details,
      payload: payload != null ? jsonEncode(payload) : null,
    );
    if (autoCancel) {
      final delay = autoCancelDelay ?? config.autoCancelDelay;
      Future.delayed(delay, () => _plugin.cancel(notificationId));
    }
  }

  @override
  Future<void> showNotificationWithActions({
    required String title, required String body, required NotificationConfig config,
    required List<NotificationAction> actions,
    int notificationId = 0, Map<String, dynamic>? payload,
  }) async {
    if (!_isInitialized) await initialize();
    await _createNotificationChannel(config);
    final androidActions = actions.map((action) => AndroidNotificationAction(
      action.id, action.title, showsUserInterface: !action.isBackground,
    )).toList();
    
    final androidDetails = AndroidNotificationDetails(
      config.channelId, config.channelName,
      channelDescription: config.channelDescription,
      importance: config.importance,
      priority: config.priority,
      playSound: config.playSound,
      sound: config.soundSource != null ? RawResourceAndroidNotificationSound(config.soundSource!) : null,
      enableVibration: config.enableVibration,
      channelShowBadge: config.showBadge,
      color: config.color,
      actions: androidActions,
    );
    
    final details = NotificationDetails(android: androidDetails);
    await _plugin.show(
      notificationId, title, body, details,
      payload: payload != null ? jsonEncode(payload) : null,
    );
  }

  @override
  Future<void> cancelNotification(int notificationId) async { await _plugin.cancel(notificationId); }
  @override
  Future<void> cancelAllNotifications() async { await _plugin.cancelAll(); }
  @override
  Future<bool> checkPermission() async {
    final status = await Permission.notification.status;
    return status.isGranted;
  }
  @override
  Future<bool> requestPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }
  @override
  Future<void> openSettings() async { await openAppSettings(); }
}