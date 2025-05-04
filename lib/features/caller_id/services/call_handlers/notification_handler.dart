import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/services/notification_service.dart';

/// 通知处理器
/// 专门负责处理通知相关的逻辑
class NotificationHandler {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  
  // 通知设置
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  bool useStirNotification = false;
  
  // 设置键名
  static const String callLocalNotificationKey = 'call_local_notification';
  static const String callCancelLocalNotificationKey = 'call_cancel_local_notification';
  static const String stirLocalNotificationKey = 'stir_local_notification';

  /// 构造函数
  NotificationHandler({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  }) : _notificationsPlugin = notificationsPlugin ?? FlutterLocalNotificationsPlugin();

  /// 初始化通知
  Future<void> initialize() async {
    await loadSettings();
    
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _notificationsPlugin.initialize(initializationSettings);
  }

  /// 处理通知点击
  void _handleNotificationTap(Map<String, dynamic> payload) {
    final type = payload['type'] as String?;
    
    if (type == 'blocked_call') {
      // 处理拦截通知点击
      NotificationService.redirectToPage('callHistory', payload);
    } else if (type == 'stir_result') {
      // 处理STIR验证通知点击
      NotificationService.redirectToPage('callHistory', payload);
    }
  }

  /// 加载设置
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    useLocalNotification = prefs.getBool(callLocalNotificationKey) ?? false;
    cancelLocalNotification = prefs.getBool(callCancelLocalNotificationKey) ?? false;
    useStirNotification = prefs.getBool(stirLocalNotificationKey) ?? false;
  }

  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;

    useLocalNotification = useLocal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(callLocalNotificationKey, useLocal);
  }

  /// 设置是否关闭本地通知
  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;

    cancelLocalNotification = cancelLocal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(callCancelLocalNotificationKey, cancelLocal);
  }

  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool useStir) async {
    if (useStirNotification == useStir) return;

    useStirNotification = useStir;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(stirLocalNotificationKey, useStir);
  }

  /// 显示拦截通知
  Future<void> showBlockedCallNotification(String phoneNumber) async {
    const androidDetails = AndroidNotificationDetails(
      'call_blocker_channel',
      'Call Blocker Notifications',
      playSound: false, // 设置为 false 以禁用声音
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await _notificationsPlugin.show(0, 'Call Blocked',
        'Blocked call from $phoneNumber', notificationDetails,
        payload: 'goToCallHistory');
    
    if (cancelLocalNotification) {
      await Future.delayed(const Duration(seconds: 5)); // 延迟5秒
      await _notificationsPlugin.cancel(0); // 取消ID为0的通知
    }
  }

  /// 显示STIR验证通知
  Future<void> showStirCallNotification(String phoneNumber, bool isVerified,
      bool isNotVerified, bool isFailed) async {
    String stirResultMessage = "";

    if (isVerified) {
      stirResultMessage = "STIR Verified";
    } else if (isNotVerified) {
      stirResultMessage = "STIR Not Verified";
    } else if (isFailed) {
      stirResultMessage = "STIR Failed";
    } else {
      stirResultMessage = "STIR Unknown";
    }

    const androidDetails = AndroidNotificationDetails(
      'call_blocker_channel',
      'Call Blocker Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await _notificationsPlugin.show(0, 'Stir Verification',
        '$stirResultMessage from $phoneNumber', notificationDetails,
        payload: 'goToCallHistory');
  }

  /// 处理STIR信息
  Future<void> processStirInfo(StirInfo stirInfo) async {
    if (!useStirNotification) return;
    
    await showStirCallNotification(
      stirInfo.phoneNumber!,
      stirInfo.isVerified,
      stirInfo.isNotVerified,
      stirInfo.isFailed
    );
  }
}