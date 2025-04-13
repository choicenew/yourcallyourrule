import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../base_service_impl.dart';

/// 通知服务实现
/// 负责发送应用通知
class NotificationServiceImpl extends BaseServiceImpl {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  
  /// 初始化通知服务
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    
    _isInitialized = true;
    logOperation('通知服务初始化完成');
  }
  
  /// 显示通知
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_isInitialized) await initialize();
    
    const androidDetails = AndroidNotificationDetails(
      'your_call_your_rule_channel',
      'Your Call Your Rule',
      channelDescription: 'Notifications from Your Call Your Rule app',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
    
    logOperation('显示通知', details: title);
  }
  
  /// 取消通知
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
    logOperation('取消通知', details: 'ID: $id');
  }
  
  /// 取消所有通知
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
    logOperation('取消所有通知');
  }
  
  /// 通知点击回调
  void _onNotificationTapped(NotificationResponse response) {
    logOperation('通知被点击', details: 'Payload: ${response.payload}');
    // 在实际应用中，可以根据payload处理不同的通知点击事件
  }
}