import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'sms_blacklist_whitelist_service.dart';

import 'sms_text_service.dart';

class SmsFilterService {
  static const platform =
      MethodChannel('com.example.yourcallyourrule/sms_filter');

  static const String smsFilterEnabledKey = 'sms_filter_enabled';
  static const String _useLocalNotificationKey = 'use_local_notification';

  final SmsBlacklistService numberBlacklistService;
  final SmsWhitelistService numberWhitelistService;
  final SmsTextBlacklistService textBlacklistService;
  final SmsTextWhitelistService textWhitelistService;
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  bool _isEnabled = false;
  bool _useLocalNotification = false;
//String? _smsPackageName; // 存储短信应用包名

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
  }

  void _setupMethodChannels() {
    platform.setMethodCallHandler((call) async {
      if (call.method == "onSmsInitializationComplete") {
        // 原生端 smsChannel 初始化完成
        print("Native smsChannel initialized.");
      } else if (call.method == 'onReceivedSms') {
        final String phoneNumber = call.arguments['phoneNumber'];
        final String messageContent = call.arguments['messageContent'];
        print("flutter端的Received SMS from: $phoneNumber, Content: $messageContent");
        await handleIncomingSms(phoneNumber, messageContent);
      }
      return null;
    });
  }

  Future<void> registerSmsListener() async {
    try {
      await platform.invokeMethod('registerSmsListener');
      print("SMS flutter端的Listener registered successfully.");
    } on PlatformException catch (e) {
      print("Failed to register SMS flutter端的listener: '${e.message}'.");
    }
  }

  Future<void> unregisterSmsListener() async {
    try {
      await platform.invokeMethod('unregisterSmsListener');
      print("SMS Listener unregistered successfully.");
    } on PlatformException catch (e) {
      print("Failed to unregister SMS listener: '${e.message}'.");
    }
  }

/*
// 在 SmsFilterService 的 initState 或其他合适的时机调用
Future<void> _getSmsPackageName() async {
  try {
    String? smsPackageName = await platform.invokeMethod('getDefaultSmsPackage');
    print("Default SMS package name: $smsPackageName");
    // 将 smsPackageName 存储到变量中，以便后续使用
  } on PlatformException catch (e) {
    print("Failed to get default SMS package name: '${e.message}'.");
  }
}
*/

  Future<void> _loadSettings() async {
    final asyncPrefs = SharedPreferencesAsync();
    _isEnabled = await asyncPrefs.getBool(smsFilterEnabledKey) ?? false;
    _useLocalNotification =
        await asyncPrefs.getBool(_useLocalNotificationKey) ?? false;
    print("SMS Filter Enabled: $_isEnabled");
    print("Use Local Notification: $_useLocalNotification");
  }

  Future<void> setEnabled(bool enabled) async {
    if (_isEnabled == enabled) return;

    _isEnabled = enabled;
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool(smsFilterEnabledKey, enabled);
/*
    if (enabled) {
      print("Enabling SMS Filter...");
      await registerSmsListener();
    } else {
      await unregisterSmsListener();
    }
    */
  }

  Future<void> setUseLocalNotification(bool useLocal) async {
    if (_useLocalNotification == useLocal) return;

    _useLocalNotification = useLocal;
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool(_useLocalNotificationKey, useLocal);
  }

  bool get isEnabled => _isEnabled;
  bool get useLocalNotification => _useLocalNotification;

  Future<bool> shouldNotify(String phoneNumber, String messageContent) async {
    if (!_isEnabled) return true;

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
    print("不匹配规则No rule matched. Allowing notification.");

    return false;
  }
/*
  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onReceivedSms':
        final String phoneNumber = call.arguments['phoneNumber'];
        final String messageContent = call.arguments['messageContent'];
        print("handlemethod 测试Received SMS from: $phoneNumber, Content: $messageContent");
        await handleIncomingSms(phoneNumber, messageContent);
        break;
      default:
        print('Unknown method ${call.method}');
    }
  }
*/

  Future<void> handleIncomingSms(
      String phoneNumber, String messageContent) async {
    if (!_isEnabled) return;
    print("!_isEnabled");
    bool shouldNotifyUser = await shouldNotify(phoneNumber, messageContent);

    // 获取原生短信应用的包名
   //String smsPackageName = _smsPackageName ?? "unknown"; // 如果包名为空，则使用默认值
String smsPackageName = await platform.invokeMethod('getDefaultSmsPackage'); // 直接使用返回值
    print(" handle SMS 里面的Default SMS package name: $smsPackageName");


    // 设置通知通道的重要性
    await platform.invokeMethod('setSmsNotificationChannelImportance', {
      'packageName': smsPackageName,
      'importance': shouldNotifyUser
          ? 4
          : 2, // 使用原生端的常量值(4 代表 IMPORTANCE_DEFAULT，2 代表 IMPORTANCE_LOW)
    });
    print("打印sms包名 for: $smsPackageName, $shouldNotifyUser");
    if (_useLocalNotification && shouldNotifyUser) {
      await _showLocalNotification(phoneNumber, messageContent);
    }
  }

  Future<void> _showLocalNotification(
      String phoneNumber, String messageContent) async {
    // 实现本地通知逻辑（如果需要）
  }


  Future<void> close() async {
    await numberBlacklistService.database.close();
    await textBlacklistService.database.close();
  }
}
