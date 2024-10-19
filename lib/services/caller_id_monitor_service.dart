import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart' as overlay;
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/callerID/callerid_configuration.dart';
import '../screens/callerID/callerid_style_provider.dart';
import '../screens/home_page.dart';
import '../utils/blocked_call_repository.dart';
import '../utils/call_filter.dart';
import '../utils/language_provider.dart';
import '../utils/parse_phonenumber.dart';
import '../utils/repeated_call.dart';
import 'caller_id_service.dart';

/*
// 定义 CallData 类 包含callerid data
class CallData {
  final CallerIdData callerIdData;
  final String e164Number;
  final String nationalNumber;

  CallData({
    required this.callerIdData,
    required this.e164Number,
    required this.nationalNumber,
  });
}
*/
// 定义 CallData 类 包含 callerid data, stirInfo 和 simInfo
class CallData {
  final CallerIdData callerIdData;
  final String e164Number;
  final String nationalNumber;
  final StirInfo? stirInfo;
  final SimInfo? simInfo;

  CallData({
    required this.callerIdData,
    required this.e164Number,
    required this.nationalNumber,
    this.stirInfo,
    this.simInfo,
  });
}

// 定义 StirInfo 类
class StirInfo {
  final bool isVerified;
  final bool isNotVerified;
  final bool isFailed;
  final String? phoneNumber; // 注意：这里添加了 phoneNumber 属性，用于匹配

  StirInfo({
    required this.isVerified,
    required this.isNotVerified,
    required this.isFailed,
    this.phoneNumber,
  });

  // 添加 toJson 和 fromJson 方法 (可选)
  Map<String, dynamic> toJson() {
    return {
      'isVerified': isVerified,
      'isNotVerified': isNotVerified,
      'isFailed': isFailed,
      'phoneNumber': phoneNumber,
    };
  }

  factory StirInfo.fromJson(Map<String, dynamic> json) {
    return StirInfo(
      isVerified: json['isVerified'],
      isNotVerified: json['isNotVerified'],
      isFailed: json['isFailed'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // 可以根据需要添加其他方法，例如：
  bool isStirVerified() {
    return isVerified;
  }
}

// 定义 SimInfo 类
class SimInfo {
  final String? carrierName;
  final String? displayName;
  final String? iccId;
  final String? countryIso;
  final String? phoneNumber;
  final int? simSlotIndex;
  final int? subscriptionId;
  final String? mccString;
  final String? mncString;
  final String? simPhoneNumber;
  final String? callType;

  SimInfo({
    this.carrierName,
    this.displayName,
    this.iccId,
    this.countryIso,
    this.phoneNumber,
    this.simSlotIndex,
    this.subscriptionId,
    this.mccString,
    this.mncString,
    this.simPhoneNumber,
    this.callType,
  });

  // 添加 toJson 和 fromJson 方法
  Map<String, dynamic> toJson() {
    return {
      'carrierName': carrierName,
      'displayName': displayName,
      'iccId': iccId,
      'countryIso': countryIso,
      'phoneNumber': phoneNumber,
      'simSlotIndex': simSlotIndex,
      'subscriptionId': subscriptionId,
      'mccString': mccString,
      'mncString': mncString,
      'simPhoneNumber': simPhoneNumber,
      'callType': callType,
    };
  }

  factory SimInfo.fromJson(Map<String, dynamic> json) {
    return SimInfo(
      carrierName: json['carrierName'],
      displayName: json['displayName'],
      iccId: json['iccId'],
      countryIso: json['countryIso'],
      phoneNumber: json['phoneNumber'],
      simSlotIndex: json['simSlotIndex'],
      subscriptionId: json['subscriptionId'],
      mccString: json['mccString'],
      mncString: json['mncString'],
      simPhoneNumber: json['simPhoneNumber'],
      callType: json['callType'],
    );
  }
}

class CallerIdMonitorService {
  static const callerIdChannel =
      MethodChannel('com.yours.yourcallyourrule/caller_id');

  static const endCallChannel =
      MethodChannel('com.yours.yourcallyourrule/end_call');

  static const shouldAcceptCallChannel =
      MethodChannel('com.yours.yourcallyourrule/should_accept_call');

  static const stirChannel =
      MethodChannel('com.yours.yourcallyourrule/stir_check');

  static const simChannel =
      MethodChannel('com.yours.yourcallyourrule/sim_check');

  static const String callLocalNotificationKey = 'call_local_notification';
  static const String callCancelLocalNotificationKey =
      'call_cancel_local_notification';
  static const String stirLocalNotificationKey =
      'stir_local_notification'; //添加stir 的notification

  final CallerIdService _callerIdService;
  final CallFilter _callFilter;
  final BlockedCallRepository _blockedCallRepository;
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;

  final TimeBasedInterceptor _timeBasedInterceptor = TimeBasedInterceptor();
  //final TimeBasedInterceptor _timeBasedInterceptor;
  bool useLocalNotification = true;
  bool cancelLocalNotification = false;
  bool useStirNotification = true; //stir 通知

  OverlayEntry? _currentOverlay;

  final FlutterLocalNotificationsPlugin notificationsPlugin;

//后期增加的STIR和SIMinfo
  // 存储 STIR 信息
  StirInfo? stirInfo;

  // 存储 SIM 信息
  SimInfo? simInfo;
//后期增加的stir 和siminfo信息，到此结束

  CallerIdMonitorService(
      this._callerIdService, this._callFilter, this._blockedCallRepository)
      : notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize(BuildContext context) async {
    // Debug print
    await loadSettings();
    await _initializeNotifications();
    _setupMethodChannels(context);
    //_startListeningPhoneState(context);
    await _initializeCallerIdService();

    // Debug print
  }

  Future<void> loadSettings() async {
    final asyncPrefs = SharedPreferencesAsync();
    useLocalNotification =
        await asyncPrefs.getBool(callLocalNotificationKey) ?? false;

    // 从 SharedPreferences 读取拦截方式

    final interceptAction =
        await asyncPrefs.getString('intercept_action') ?? 'endCall';

//stir 通知
    useStirNotification =
        await asyncPrefs.getBool(stirLocalNotificationKey) ?? false;
  }

  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;

    useLocalNotification = useLocal;
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool(callLocalNotificationKey, useLocal);
  }

  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;

    cancelLocalNotification = cancelLocal;
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool(callCancelLocalNotificationKey, cancelLocal);
  }

//stir 通知
  Future<void> setUseStirNotification(bool useStir) async {
    if (useStirNotification == useStir) return;

    useStirNotification = useStir;
    final asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool(stirLocalNotificationKey, useStir);
  }

  void _setupMethodChannels(BuildContext context) {
    _setupCallerIdChannel(context);
    _setupShouldAcceptCallChannel();
    _setupEndCallChannel();
    _setupStirChannel();
    _setupSimChannel();
  }

  //calleridchannel的setup
  void _setupCallerIdChannel(BuildContext context) {
    //calleridchannel的setup
    callerIdChannel.setMethodCallHandler((call) async {
      // Debug print
      if (call.method == "onCallerIdInitializationComplete") {
        try {
          //final String result =
              await callerIdChannel.invokeMethod('initialize');
        } on PlatformException catch (e) {
          //
        }
      } else if (call.method == 'onIncomingCall') {
        // Debug print
        await _handleIncomingCall(call.arguments['phoneNumber'], context);
      } else if (call.method == 'onCallEnded') {
        if (_currentOverlay != null) {
          enableOverlayDismissal();
        }
      } else if (call.method == 'onOutgoingCall') {
        // Debug print
        await _handleOutgoingCall(call.arguments['phoneNumber'], context);
      }
      return null;
    });
  }

//shouldAcceptCall channel的setup
  void _setupShouldAcceptCallChannel() {
    shouldAcceptCallChannel.setMethodCallHandler((call) async {
      if (call.method == 'onShouldAcceptCallInitializationComplete') {
      } else if (call.method == 'shouldAcceptCall') {
        final phoneNumber = call.arguments as String;
        // 先判断 _callFilter 的结果
        await _callFilter.loadConfig(); // 重新加载配置
        bool shouldAccept = await _callFilter.shouldAcceptCall(phoneNumber);
        await _timeBasedInterceptor.loadConfig();
        // 如果 _callFilter bu允许接听，再判断 _timeBasedInterceptor 的结果
        if (!shouldAccept && _timeBasedInterceptor.config.shouldIntercept) {
          shouldAccept =
              !await _timeBasedInterceptor.shouldIntercept(phoneNumber);
        }

        return shouldAccept;
      }
      return null;
    });
  }

  //endcallchannel 的setup
  void _setupEndCallChannel() {
    endCallChannel.setMethodCallHandler((call) async {
      if (call.method == "onEndCallInitializationComplete") {
      } else if (call.method == "interceptAction") {
        final phoneNumber = call.arguments as String;
        SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
        final interceptAction =
            await asyncPrefs.getString('intercept_action') ?? 'endCall';
        return interceptAction;
      }
      return null;
    });
  }

//stirchannel的setup
  void _setupStirChannel() {
    stirChannel.setMethodCallHandler((call) async {
      if (call.method == "onStirInitializationComplete") {
        // STIR 初始化完成，可以在这里进行一些初始化操作（可选）
      } else if (call.method == "onStirResult") {
        final isVerified = call.arguments['isVerified'] as bool;
        final isNotVerified = call.arguments['isNotVerified'] as bool;
        final isFailed = call.arguments['isFailed'] as bool;
        final phoneNumber =
            call.arguments['phoneNumber'] as String?; // 获取来电/去电号码

        // 存储 STIR 信息
        stirInfo = StirInfo(
          isVerified: isVerified,
          isNotVerified: isNotVerified,
          isFailed: isFailed,
          phoneNumber: phoneNumber, // 假设 phoneNumber 从这里获取
        );

        // 根据 STIR 验证结果进行拦截判断
        //  await _showStirCallNotification(
        //        call.arguments['phoneNumber'], isVerified, isNotVerified, isFailed);

        await _handleStir(
            call.arguments['phoneNumber'], isVerified, isNotVerified, isFailed);

        // ... 你的拦截逻辑 ...

        // 例如，如果 STIR 验证失败，则拦截来电
        if (isFailed) {
          // ... 执行拦截操作 ...
        }
      }
      return null;
    });
  }

  //simChannel的setup
  void _setupSimChannel() {
    simChannel.setMethodCallHandler((call) async {
      if (call.method == "onSimInitializationComplete") {
      } else if (call.method == "onSimInfo") {
        final carrierName = call.arguments['carrierName'] as String?;
        final displayName = call.arguments['displayName'] as String?;
        final iccId = call.arguments['iccId'] as String?;
        final countryIso = call.arguments['countryIso'] as String?;
        final phoneNumber =
            call.arguments['incomingPhoneNumber'] as String?; // 获取来电/去电号码
        final simSlotIndex = call.arguments['simSlotIndex'] as int?; // SIM 卡槽索引
        final subscriptionId =
            call.arguments['subscriptionId'] as int?; // 订阅 ID
        final mccString = call.arguments['mccString'] as String?; // MCC 字符串
        final mncString = call.arguments['mncString'] as String?; // MNC 字符串
        final simPhoneNumber =
            call.arguments['simPhoneNumber'] as String?; // SIM 卡号码
        final callType = call.arguments['callType'] as String?; // SIM 卡号码

        // 存储 SIM 信息
        simInfo = SimInfo(
          carrierName: carrierName,
          displayName: displayName,
          iccId: iccId,
          countryIso: countryIso,
          phoneNumber: phoneNumber,
          simSlotIndex: simSlotIndex,
          subscriptionId: subscriptionId,
          mccString: mccString,
          mncString: mncString,
          simPhoneNumber: simPhoneNumber,
          callType: callType,
        );

        // ... 处理 SIM 卡信息 ...
      }
    });
  }

//初始化服务
  Future<void> _initializeCallerIdService() async {
    try {
      await callerIdChannel.invokeMethod('initialize');
    } on PlatformException catch (e) {
      //
    }
  }

  Future<void> _initializeNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(initializationSettings);
  }

// 提取的公共函数
  Future<CallData> _handleCall(String phoneNumber, BuildContext context) async {
    // 使用存储的 STIR 信息 (如果 phoneNumber 匹配)
    StirInfo? stirInfoToUse =
        stirInfo != null && stirInfo!.phoneNumber == phoneNumber
            ? stirInfo
            : null;

    // 使用存储的 SIM 信息 (如果 phoneNumber 匹配)
    SimInfo? simInfoToUse =
        simInfo != null && simInfo?.phoneNumber == phoneNumber ? simInfo : null;

    // 解析号码

    // 根据 simInfoToUse.countryIso 判断使用哪个解析方法
    Map<String, String> parsedData;
    if (simInfoToUse != null && simInfoToUse.countryIso != null) {
      // 使用带有国家代码的解析方法
      parsedData =
          await parsePhoneNumberWithIso(phoneNumber, simInfoToUse.countryIso!);
    } else {
      // 使用不带国家代码的解析方法
      parsedData = await parsePhoneNumber(phoneNumber);
    }

    String countryCode = parsedData['countryCode']!;

    String e164Number = parsedData['e164Number']!;
    String nationalNumber = parsedData['nationalNumber']!;

    // 判断 e164Number 是否有效
    if (e164Number.isEmpty) {
      return CallData(
        callerIdData: CallerIdData(
          phoneNumber: phoneNumber,
          countryName: 'Unknown',
          region: 'Unknown',
          carrier: 'Unknown',
          numberType: PhoneNumberType.unknown,
          labels: [Label(label: 'Unknown')],
          name: 'Unknown',
          avatar: '',
          count: 0,
        ),
        e164Number: '',
        nationalNumber: '',
      );
    }

    // 获取当前 Locale
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;
    final languageCode = currentLocale.languageCode;

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      country: (countryCode).toUpperCase(),
    );

    // 获取来电显示信息
    CallerIdData callerIdData =
        await _callerIdService.getCallerId(phoneNumber, context, dlibLocale);

    return CallData(
      callerIdData: callerIdData,
      e164Number: e164Number,
      nationalNumber: nationalNumber,
      stirInfo: stirInfoToUse,
      simInfo: simInfoToUse,
    );
  }

// 处理拨出电话的方法
  Future<void> _handleOutgoingCall(
      String phoneNumber, BuildContext context) async {
    CallData callData = await _handleCall(phoneNumber, context);

    //await showCallerIdOverlay(context, callData.callerIdData);
    await showCallerIdOverlay(
        context, callData.callerIdData, callData.stirInfo, callData.simInfo);

    _callerIdSubject.add(callData.callerIdData);
  }

// 处理来电的方法
  Future<void> _handleIncomingCall(
      String phoneNumber, BuildContext context) async {
    CallData callData = await _handleCall(phoneNumber, context);

    //await showCallerIdOverlay(context, callData.callerIdData);
    await showCallerIdOverlay(
        context, callData.callerIdData, callData.stirInfo, callData.simInfo);

    _callerIdSubject.add(callData.callerIdData);

    // 使用列表和 any 方法进行优先级判断
    final numbersToTest = [
      phoneNumber,
      callData.nationalNumber,
      callData.e164Number
    ].whereType<String>();

    await _callFilter.loadConfig(); // 重新加载配置
    await _timeBasedInterceptor.loadConfig();

    final shouldAccept = await Future.any(
      numbersToTest.map((number) async {
        bool shouldAccept = await _callFilter.shouldAcceptCall(number);
        // 如果 _callFilter 不允许接听，再判断 _timeBasedInterceptor 的结果
        if (!shouldAccept && _timeBasedInterceptor.config.shouldIntercept) {
          shouldAccept = !await _timeBasedInterceptor.shouldIntercept(number);
        }
        return shouldAccept;
      }),
    );

    if (shouldAccept) {
      // 显示 Overlay
    } else {
      // 拦截来电

      // 从 SharedPreferences 读取拦截方式
      SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
      final interceptAction =
          await asyncPrefs.getString('intercept_action') ?? 'endCall';

      if (useLocalNotification) {
        await _showBlockedCallNotification(phoneNumber);
        if (cancelLocalNotification) {
          await Future.delayed(
              const Duration(seconds: 5)); // Delay for 5 seconds
          await notificationsPlugin
              .cancel(0); // cancel the notification with id value of zero
        }
      }

      await _blockedCallRepository.addBlockedCall(phoneNumber);
    }
  }

// 处理stir的方法
  Future<void> _handleStir(String phoneNumber, bool isVerified,
      bool isNotVerified, bool isFailed) async {
    if (useStirNotification) {
      // 根据 STIR 验证结果进行拦截判断
      await _showStirCallNotification(
          phoneNumber, isVerified, isNotVerified, isFailed);

      await Future.delayed(const Duration(seconds: 5)); // Delay for 5 seconds
      await notificationsPlugin
          .cancel(0); // cancel the notification with id value of zero
    }
  }

  Future<void> _showBlockedCallNotification(String phoneNumber) async {
    // Debug print
    const androidDetails = AndroidNotificationDetails(
      'call_blocker_channel',
      'Call Blocker Notifications',
      playSound: false, // 设置为 false 以禁用声音
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await notificationsPlugin.show(0, 'Call Blocked',
        'Blocked call from $phoneNumber', notificationDetails,
        payload: 'goToCallHistory');
  }

  Future<void> _showStirCallNotification(String phoneNumber, bool isVerified,
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

    // Debug print

    const androidDetails = AndroidNotificationDetails(
      'call_blocker_channel',
      'Call Blocker Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await notificationsPlugin.show(0, 'Stir Verification',
        '${stirResultMessage} from $phoneNumber', notificationDetails,
        payload: 'goToCallHistory');
  }

  Future<void> updateAndShareConfiguration(
      CallerIdStyleProvider styleProvider) async {
    // 传输配置给 isolated overlay
    final styleProviderData = ConfigurationManager.getConfigMap(styleProvider);

    // 添加 configType 标识
    final dataToSend = {
      "configType": "callerIdStyle",
      ...styleProviderData,
    };

    // 传递 Map 对象
    FlutterOverlayWindow.shareData(dataToSend);
  }

  OverlayPosition? storedPosition;

  Future<void> showCallerIdOverlay(BuildContext context,
      CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    CallerIdStyleProvider? styleProvider;

    styleProvider = await ConfigurationManager.fromSharedPreferences();

    await updateAndShareConfiguration(styleProvider);

    // 获取当前 Overlay 位置，如果 Overlay 处于激活状态
    if (await FlutterOverlayWindow.isActive()) {
      storedPosition = await FlutterOverlayWindow.getOverlayPosition();
    } else {
      // 如果 Overlay 未激活，则初始化位置或使用默认位置
      storedPosition = storedPosition ?? const OverlayPosition(0, 0);
    }

    // 添加 configType 标识
    final dataToSend = {
      "configType": "callerIdData", // 添加 configType 字段
      ...callerIdData.toJson(),
    };

    // 传递 Map 对象
    FlutterOverlayWindow.shareData(dataToSend);

    if (stirInfo != null) {
      await FlutterOverlayWindow.shareData({
        "configType": "stirInfo", // 添加 configType 字段
        ...stirInfo.toJson(),
      });
    }

    if (simInfo != null) {
      await FlutterOverlayWindow.shareData({
        "configType": "simInfo", // 添加 configType 字段
        ...simInfo.toJson(),
      });
    }

    // 如果 Overlay 未激活，则显示 Overlay 并设置初始位置
    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      overlayTitle: "来电显示",
      overlayContent:
          "name:${callerIdData.phoneNumber},region:${callerIdData.countryName},carrier:${callerIdData.carrier}",
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.defaultFlag,
      visibility: overlay.NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: (styleProvider.windowHeight * (pixelRatio ?? 3.0))
          .toInt(), // 使用 styleProvider.windowHeight
      width: (styleProvider.windowWidth * (pixelRatio ?? 3.0)).toInt(),
      startPosition: storedPosition!,
    );
  }

  void enableOverlayDismissal() {
    // 直接使用 FlutterOverlayWindow 关闭 overlay 应用
    FlutterOverlayWindow.closeOverlay();
  }

  Future<void> dispose() async {
    _callerIdSubject.close();
    // 只有当 overlay 激活时才关闭它
    if (await FlutterOverlayWindow.isActive()) {
      FlutterOverlayWindow.closeOverlay();
    }
  }
//ceshi
}
