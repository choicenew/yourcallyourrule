import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


import '../screens/appstate_provider.dart';
import '../services/allowed_blocked_service.dart';

import '../services/blacklist_whitelist_service.dart';

import '../services/regex_service.dart';
import 'package:sqflite/sqflite.dart';

class CallFilterConfig {
  bool rejectAllNumbers;
  bool allowAllAllowedNumbers;
  bool allowRegexWhitelistedPatterns;
  bool allowBlockedNumbers;
  bool allowAllWhitelistedNumbers;
  bool allowRegexBlacklistedPatterns;
  bool allowAllBlacklistedNumbers;

  CallFilterConfig({
    this.rejectAllNumbers = false,
    this.allowAllAllowedNumbers = true,
    this.allowRegexWhitelistedPatterns = true,
    this.allowBlockedNumbers = false,
    this.allowAllWhitelistedNumbers = true,
    this.allowRegexBlacklistedPatterns = true,
    this.allowAllBlacklistedNumbers = false,
  });
}

class CallFilter {

  final RegexService regexService;
  final AllowedService allowedService;
  final BlockedService blockedService;
  final WhitelistService whitelistService;
  final BlacklistService blacklistService;
 
 CallFilterConfig config = CallFilterConfig(); // 使用默认配置初始化

  CallFilter({
    required this.regexService,
    required this.allowedService,
    required this.blockedService,
    required this.whitelistService,
    required this.blacklistService,
  });

/*
  final RegexService regexService;
  final AllowedService allowedService;
  final BlockedService blockedService;
  final WhitelistService whitelistService;
  final BlacklistService blacklistService;
  CallFilterConfig config;

  CallFilter({
    required this.regexService,
    required this.allowedService,
    required this.blockedService,
    required this.whitelistService,
    required this.blacklistService,
    CallFilterConfig? config,
  }) : config = config ?? CallFilterConfig();
*/





  // 从 Shared Preferences 加载配置
  Future<void> loadConfig() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    config = CallFilterConfig(
      rejectAllNumbers: await asyncPrefs.getBool('rejectAllNumbers') ?? false,
      allowAllAllowedNumbers: await asyncPrefs.getBool('allowAllAllowedNumbers') ?? true,
      allowRegexWhitelistedPatterns: await asyncPrefs.getBool('allowRegexWhitelistedPatterns') ?? true,
      allowBlockedNumbers: await asyncPrefs.getBool('allowBlockedNumbers') ?? false,
      allowAllWhitelistedNumbers: await asyncPrefs.getBool('allowAllWhitelistedNumbers') ?? true,
      allowRegexBlacklistedPatterns: await asyncPrefs.getBool('allowRegexBlacklistedPatterns') ?? true,
      allowAllBlacklistedNumbers: await asyncPrefs.getBool('allowAllBlacklistedNumbers') ?? false,
    );
  }

  // 保存配置到 Shared Preferences
  Future<void> saveConfig() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('rejectAllNumbers', config.rejectAllNumbers);
    await asyncPrefs.setBool('allowAllAllowedNumbers', config.allowAllAllowedNumbers);
    await asyncPrefs.setBool('allowRegexWhitelistedPatterns', config.allowRegexWhitelistedPatterns);
    await asyncPrefs.setBool('allowBlockedNumbers', config.allowBlockedNumbers);
    await asyncPrefs.setBool('allowAllWhitelistedNumbers', config.allowAllWhitelistedNumbers);
    await asyncPrefs.setBool('allowRegexBlacklistedPatterns', config.allowRegexBlacklistedPatterns);
    await asyncPrefs.setBool('allowAllBlacklistedNumbers', config.allowAllBlacklistedNumbers);
  }

/*
  // endCallChannel 用于处理  endCurrentCall:
  static const endCallChannel = MethodChannel('com.example.yourcallyourrule/end_call');

  // shouldAcceptCallChannel  用于处理 shouldAcceptCall：
  static const shouldAcceptCallChannel = MethodChannel('com.example.yourcallyourrule/should_accept_call');
  //final calleridchannel;
  static const callerIdChannel = MethodChannel('com.example.yourcallyourrule/caller_id');
*/

  // 工厂方法创建 CallFilter 实例
  static Future<CallFilter> create({required Database database}) async {
    final CallFilter filter = CallFilter(
      regexService: RegexService(database),
      allowedService: AllowedService(database),
      blockedService: BlockedService(database),
      whitelistService: WhitelistService(database),
      blacklistService: BlacklistService(database),
    );
    await filter.initialize(); // 初始化 CallFilter，加载配置信息
    return filter;
  }

  // 初始化方法，加载配置
  Future<void> initialize() async {
    await loadConfig();
  }

  

/*
 // channel should accept
  void setupMethodChannel() {
    bool isChannelInitialized = false;

    shouldAcceptCallChannel.setMethodCallHandler((call) async {
      if (call.method == 'onShouldAcceptCallInitializationComplete') {
        print("Android shouldAcceptCallChannel is initialized!");
        isChannelInitialized = true;
      }

      //  只有在通道建立之后才处理 shouldAcceptCall
      if (isChannelInitialized && call.method == 'shouldAcceptCall') {
        final phoneNumber = call.arguments as String;
        final shouldAccept = await shouldAcceptCall(phoneNumber);
        return shouldAccept;
      }
      return null;
    });
  }
*/
/*
Future<void> initialize() async {
 print("CallFilter.initialize: 开始执行"); // 添加日志打印
    
    try {
      await callerIdChannel.invokeMethod('initialize');
    } on PlatformException catch (e) {
      print("Failed to initialize call screening: '${e.message}'.");
    }
*/
/*
        // 设置 shouldAcceptCallChannel 的监听器
    shouldAcceptCallChannel.setMethodCallHandler((call) async {
      if (call.method == 'shouldAcceptCall') {
        final String phoneNumber = call.arguments;
        print("CallHandler: Received shouldAcceptCall message with phoneNumber: $phoneNumber");
        // 使用 CallFilter 判断是否应该接听来电
        final shouldAccept = await shouldAcceptCall(phoneNumber);
        return shouldAccept;
      }
      return null;
    });
  }
*/
/*
   // 监听原生端的结束通话初始化完成事件listenForEndCallInitialization
  // 这个方法本身不结束通话，而是用于监听来自 Android 端的初始化完成消息
  Future<void> endCurrentCall() async {
    // 监听初始化完成事件
    endCallChannel.setMethodCallHandler((call) async {
      if (call.method == "onEndCallInitializationComplete") {
        // 原生端初始化完成，调用 endCurrentCall 方法
        try {
          final String result =
              await endCallChannel.invokeMethod('endCurrentCall');
          print(result);
        } on PlatformException catch (e) {
          print("Failed to use myCall Screening Service: '${e.message}'.");
        }
      }
      return null;
    });
  }
*/
  // 工厂方法创建 CallFilter 实例，并加载配置

  /*
  static Future<CallFilter> create({required Database database, CallFilterConfig? config}) async {

    return CallFilter(
      regexService: RegexService(database),
      allowedService: AllowedService(database),
      blockedService: BlockedService(database),
      whitelistService: WhitelistService(database),
      blacklistService: BlacklistService(database),
      config: config,
    );
  }
*/
/*
  // 工厂方法创建 CallFilter 实例，并加载配置
  static Future<CallFilter> create({required Database database}) async {
    final CallFilter filter = CallFilter(
      regexService: RegexService(database),
      allowedService: AllowedService(database),
      blockedService: BlockedService(database),
      whitelistService: WhitelistService(database),
      blacklistService: BlacklistService(database),
    );
    await filter.loadConfig(); // 加载配置
    return filter;
  }
*/



  //return config.allowBlockedNumbers ? true : "silence";
  // 如果拒绝所有号码，则直接返回 false
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    if (config.rejectAllNumbers) {
      return false;
    }
    // 检查号码是否在允许名单中
    if (config.allowAllAllowedNumbers &&
        await allowedService.contains(phoneNumber)) {
      return true;
    }

    // 检查号码是否在阻止名单中
    if (await blockedService.contains(phoneNumber) &&
        !config.allowBlockedNumbers) {
      return false;
    }
    // 检查号码是否匹配白名单通配符
    if (config.allowRegexWhitelistedPatterns) {
      final whitelistedPatterns =
          await regexService.getWhitelistedPatterns();
      for (var rexPattern in whitelistedPatterns) {
        if (rexPattern.enabled &&
            regexService.matchesPattern(phoneNumber, rexPattern.pattern)) {
          return true;
        }
      }
    }

    // 检查号码是否在白名单中
    if (config.allowAllWhitelistedNumbers &&
        await whitelistService.contains(phoneNumber)) {
      return true;
    }
// 检查号码是否匹配黑名单通配符
    if (config.allowRegexBlacklistedPatterns) {
      final blacklistedPatterns =
          await regexService.getBlacklistedPatterns();
      for (var rexPattern in blacklistedPatterns) {
        if (rexPattern.enabled &&
            regexService.matchesPattern(phoneNumber, rexPattern.pattern)) {
              // 添加打印语句
          return false;
        }
      }
       // 添加打印语句
    }
    // 检查号码是否在黑名单中
    // 如果允许所有黑名单号码，则放行
    if (await blacklistService.contains(phoneNumber) &&
        !config.allowAllBlacklistedNumbers) {
      return false;
    }
    // 放行所有其他号码
    return true;
  }

  void updateConfig(CallFilterConfig newConfig) {
    // 添加打印日志
    config = newConfig;
    // 添加打印日志 确认赋值是否成功
  }
}
