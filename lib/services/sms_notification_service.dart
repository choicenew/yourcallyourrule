import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'sms_blacklist_whitelist_service.dart';

import 'sms_text_service.dart';

class SmsFilterService {
  static const smsChannel =
      MethodChannel('com.yours.yourcallyourrule/sms_filter');

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
    required this.numberBlacklistService,
    required this.numberWhitelistService,
    required this.textBlacklistService,
    required this.textWhitelistService,
  });

  static Future<SmsFilterService> create({required Database database}) async {
    final service = SmsFilterService(
      numberBlacklistService: SmsBlacklistService(database),
      numberWhitelistService: SmsWhitelistService(database),
      textBlacklistService: SmsTextBlacklistService(database),
      textWhitelistService: SmsTextWhitelistService(database),
    );

    // await service.initialize();
    return service;
  }

  Future<void> initialize() async {
    await _loadSettings();
    _setupMethodChannels();
    await registerSmsListener(); // 初始化时注册监听器
    // _getSmsPackageName();
    // 初始化本地通知插件
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


  Future<void> _setupMethodChannels() async {
    smsChannel.setMethodCallHandler((call) async {
      if (call.method == "onSmsInitializationComplete") {
        await _handleSmsInitializationComplete();
      } else if (call.method == 'onReceivedSms') {
        await _handleReceivedSms(call);
      }
      return null;
    });
  }

  Future<void> _handleSmsInitializationComplete() async {
    // 处理 "onSmsInitializationComplete" 方法调用
    // 这里可以添加异步操作，例如初始化数据库
  }

  Future<void> _handleReceivedSms(MethodCall call) async {
    // 处理 "onReceivedSms" 方法调用
    final String phoneNumber = call.arguments['phoneNumber'];
    final String messageContent = call.arguments['messageContent'];
    await handleIncomingSms(phoneNumber, messageContent);
  }

  Future<void> registerSmsListener() async {
    try {
      await smsChannel.invokeMethod('registerSmsListener');
    } on PlatformException catch (e) {
      //
    }
  }

  Future<void> unregisterSmsListener() async {
    try {
      await smsChannel.invokeMethod('unregisterSmsListener');
    } on PlatformException catch (e) {
      //
    }
  }

// 在 SmsFilterService 的 initState 或其他合适的时机调用
  Future<void> _getSmsPackageName() async {
    try {
      String? smsPackageName =
          await smsChannel.invokeMethod('getDefaultSmsPackage');
      // 将 smsPackageName 存储到变量中，以便后续使用
    } on PlatformException catch (e) {
      //
    }
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
    // 获取原生短信应用的包名
    //String smsPackageName = _smsPackageName ?? "unknown"; // 如果包名为空，则使用默认值
    String smsPackageName =
        await smsChannel.invokeMethod('getDefaultSmsPackage'); // 直接使用返回值

    // 设置通知通道的重要性
    await smsChannel.invokeMethod('setSmsNotificationChannelImportance', {
      'packageName': smsPackageName,
      'importance': shouldNotifyUser
          ? 4
          : 2, // 使用原生端的常量值(4 代表 IMPORTANCE_DEFAULT，2 代表 IMPORTANCE_LOW)
    });


  }

  Future<void> _showLocalNotification(
      String phoneNumber, String messageContent) async {
    // Debug print
    const androidNotificationDetails = AndroidNotificationDetails(
      'SMS_Filter_channel', 'SMS Filter Notifications',
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
