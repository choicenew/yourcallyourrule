import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';

import 'package:yourcallyourrule/core/services/notification_service.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service_new.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';

/// 通知处理器
/// 专门负责处理通知相关的逻辑
class NotificationHandler {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  final CallerIdConfigRepository _configRepository;
  
  // 通知设置
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  bool useStirNotification = false;

  /// 构造函数
  NotificationHandler({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
    required CallerIdConfigRepository configRepository,
  }) : 
    _notificationsPlugin = notificationsPlugin ?? FlutterLocalNotificationsPlugin(),
    _configRepository = configRepository;

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
    useLocalNotification = await _configRepository.getUseLocalNotification();
    cancelLocalNotification = await _configRepository.getCancelLocalNotification();
    useStirNotification = await _configRepository.getUseStirNotification();
  }

  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;

    useLocalNotification = useLocal;
    await _configRepository.setUseLocalNotification(useLocal);
  }

  /// 设置是否关闭本地通知
  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;

    cancelLocalNotification = cancelLocal;
    await _configRepository.setCancelLocalNotification(cancelLocal);
  }

  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool useStir) async {
    if (useStirNotification == useStir) return;

    useStirNotification = useStir;
    await _configRepository.setUseStirNotification(useStir);
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
  
  /// 显示诈骗警告通知
  Future<void> showFraudAlertNotification(String phoneNumber) async {
    final androidDetails = AndroidNotificationDetails(
      'fraud_alert_channel',
      'Fraud Alert Notifications',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.call,
      playSound: true,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 500, 200, 500]), // 特殊震动模式
      color: Colors.red, // 红色通知
    );
    final notificationDetails = NotificationDetails(android: androidDetails);
    
    await _notificationsPlugin.show(
      2, // 使用不同的ID，避免与其他通知冲突
      '⚠️ 诈骗警告',
      '来自 $phoneNumber 的电话可能是诈骗电话，请注意防范',
      notificationDetails,
      payload: '{"type":"fraud_alert","phone":"$phoneNumber"}'
    );
    
    // 触发震动警告
    FraudDetectionService.triggerFraudAlertNotification();
  }
  
  /// 显示来电信息通知
  Future<void> showCallerIdNotification(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    // 检查是否为诈骗电话
    final isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);
    
    // 构建通知标题
    String title = callerIdData.name ?? callerIdData.phoneNumber.value;
    if (isFraudCall) {
      title = '⚠️ $title';
    }
    
    // 构建通知内容
    final List<String> contentParts = [];
    
    // 添加标签信息
    if (callerIdData.labels != null && callerIdData.labels!.isNotEmpty) {
      final labelTexts = callerIdData.labels!.map((label) => label.label).join(', ');
      contentParts.add(labelTexts);
    }
    
    // 添加STIR信息
    if (stirInfo != null) {
      String stirStatus = '';
      if (stirInfo.isVerified) {
        stirStatus = 'STIR Verified';
      } else if (stirInfo.isNotVerified) {
        stirStatus = 'STIR Not Verified';
      } else if (stirInfo.isFailed) {
        stirStatus = 'STIR Failed';
      }
      
      if (stirStatus.isNotEmpty) {
        contentParts.add(stirStatus);
      }
    }
    
    // 添加SIM卡信息
    if (simInfo != null && simInfo.simSlotIndex != null) {
      contentParts.add('SIM ${simInfo.simSlotIndex! + 1}');
    }
    
    // 合并内容
    final content = contentParts.isEmpty ? 'Incoming call' : contentParts.join(' | ');
    
    // 设置通知详情
    const androidDetails = AndroidNotificationDetails(
      'caller_id_channel',
      'Caller ID Notifications',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.call,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    
    // 显示通知
    await _notificationsPlugin.show(
      1, // 使用不同的ID，避免与其他通知冲突
      title,
      content,
      notificationDetails,
      payload: '{"type":"caller_id","phone":"${callerIdData.phoneNumber.value}"}'
    );
    
    // 如果是诈骗电话，触发额外的震动警告
    if (isFraudCall) {
      FraudDetectionService.triggerFraudAlertNotification();
    }
  }
}