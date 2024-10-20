import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'sms_channel_manager.dart'; // Import the new SmsChannelManager
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'sms_blacklist_whitelist_service.dart';

import 'sms_text_service.dart';

class SmsFilterService {
  final SmsChannelManager smsChannelManager; // Using SmsChannelManager

  static const String smsFilterEnabledKey = 'sms_filter_enabled';
  static const String smsLocalNotificationKey = 'sms_local_notification';
  static const String smsCancelLocalNotificationKey =
      'sms_cancel_local_notification';

  final SmsBlacklistService numberBlacklistService;
  final SmsWhitelistService numberWhitelistService;
  final SmsTextBlacklistService textBlacklistService;
  final SmsTextWhitelistService textWhitelistService;
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isEnabled = false;
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  String? _smsPackageName; // 存储短信应用包名

  SmsFilterService({
    required this.smsChannelManager, // Inject SmsChannelManager - Correct name
    required this.numberBlacklistService,
    required this.numberWhitelistService,
    required this.textBlacklistService,
    required this.textWhitelistService,
  });

  static Future<SmsFilterService> create({
    required Database database,
    required SmsChannelManager smsChannelManager, // Pass SmsChannelManager
  }) async {
    final service = SmsFilterService(
      smsChannelManager:
          smsChannelManager, // Assign SmsChannelManager - Correct name
      numberBlacklistService: SmsBlacklistService(database),
      numberWhitelistService: SmsWhitelistService(database),
      textBlacklistService: SmsTextBlacklistService(database),
      textWhitelistService: SmsTextWhitelistService(database),
    );

    return service;
  }

  Future<void> initialize() async {
    await _loadSettings();
    _setupChannelCallbacks();

    _smsPackageName =
        await smsChannelManager.getDefaultSmsPackage(); // Use SmsChannelManager
    await _initializeNotifications();
  }

  // 初始化本地通知插件
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _setupChannelCallbacks() {
    smsChannelManager.onSmsCall = _handleSmsChannelCall;
  }

  Future<void> _handleSmsChannelCall(MethodCall call) async {
    if (call.method == "onSmsInitializationComplete") {
      await smsChannelManager
          .initializeSmsListener(); // Use the corrected method
    } else if (call.method == 'onReceivedSms') {
      await _handleReceivedSms(call);
    }
  }

  Future<void> _handleReceivedSms(MethodCall call) async {
    // 处理 "onReceivedSms" 方法调用
    final String phoneNumber = call.arguments['phoneNumber'];
    final String messageContent = call.arguments['messageContent'];

    await handleIncomingSms(phoneNumber, messageContent);
  }

  Future<void> _loadSettings() async {
    final asyncPrefs = SharedPreferencesAsync();
    isEnabled = await asyncPrefs.getBool(smsFilterEnabledKey) ?? false;

    useLocalNotification =
        await asyncPrefs.getBool(smsLocalNotificationKey) ?? false;

    cancelLocalNotification =
        await asyncPrefs.getBool(smsCancelLocalNotificationKey) ?? false;
  }

  Future<void> setEnabled(bool enabled) async {
    if (isEnabled == enabled) return;

    isEnabled = enabled;
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool(smsFilterEnabledKey, enabled);
  }

  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;

    useLocalNotification = useLocal;
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool(smsLocalNotificationKey, useLocal);
  }

  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;

    cancelLocalNotification = cancelLocal;
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool(smsCancelLocalNotificationKey, cancelLocal);
  }

  Future<bool> shouldNotify(String phoneNumber, String messageContent) async {
    if (!isEnabled) return true;

    if (await textWhitelistService.isIncluded(messageContent)) {
      return true;
    }

    if (await numberWhitelistService.isWhitelisted(phoneNumber)) {
      return true;
    }

    if (await textBlacklistService.isIncluded(messageContent)) {
      return false;
    }

    if (await numberBlacklistService.isBlacklisted(phoneNumber)) {
      return false;
    }

    return true;
  }

  Future<void> handleIncomingSms(
      String phoneNumber, String messageContent) async {
    if (!isEnabled) return;

    bool shouldNotifyUser = await shouldNotify(phoneNumber, messageContent);

    if (useLocalNotification && shouldNotifyUser) {
      await _showLocalNotification(phoneNumber, messageContent);
      if (cancelLocalNotification) {
        await Future.delayed(const Duration(seconds: 5)); // Delay for 5 seconds
        await _flutterLocalNotificationsPlugin
            .cancel(0); // cancel the notification with id value of zero
      }
    }
  }

  Future<void> _showLocalNotification(
      String phoneNumber, String messageContent) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'SMS_Filter_channel',
      'SMS Filter Notifications',
      //channelDescription: 'SMS Filter Notifications',
      importance: Importance.max,
      priority: Priority.high,
      //ticker: 'ticker'
    );
    const notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    // 显示通知
    await _flutterLocalNotificationsPlugin
        .show(0, '新短信', messageContent, notificationDetails, payload: 'item x');
  }

  Future<void> close() async {
    await numberBlacklistService.database.close();
    await textBlacklistService.database.close();
  }
}
