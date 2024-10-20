import 'dart:async';


import 'package:flutter/material.dart';
import 'package:path/path.dart' as path_helper;
import 'package:sqflite/sqflite.dart';

import '../../services/allowed_blocked_service.dart';
import '../../services/blacklist_whitelist_service.dart';
import '../../services/contact_service.dart';
import '../../services/label_service.dart';
import '../../services/location_service.dart';
import '../../services/plugin_manager_service.dart';
import '../../services/sms_blacklist_whitelist_service.dart';
import '../../services/sms_subscribe_service.dart';
import '../../services/sms_text_service.dart';
import '../../services/subscribe_contacts_service.dart';
import '../services/call_channel_manager.dart';
import '../services/regex_service.dart';

import '../services/caller_id_monitor_service.dart';
import '../services/caller_id_service.dart';
import '../services/sms_channel_manager.dart';
import '../services/sms_notification_service.dart';
import '../services/subscription_service.dart';
import '../utils/blocked_call_repository.dart';
import '../utils/call_filter.dart';


// 导入所有需要的服务

class AppState extends ChangeNotifier {
  final ValueNotifier<double> initializationProgress =
      ValueNotifier<double>(0.0);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Progress weights
  static const double servicesInitWeight = 0.2;
  static const double databaseInitWeight = 0.1;
  static const double tablesCreateWeight = 0.4;
  static const double servicesCreateWeight = 0.3;
  // 存储单一数据库实例
  late Database callRuleDatabase;

  // 存储 Service 实例
  late BlacklistService blacklistService;
  late WhitelistService whitelistService;
  late SubscriptionService subscriptionService;
  late AllowedService allowedService;
  late BlockedService blockedService;
  late LabelService labelService;
  late ContactService contactService;
  late SubscribeContactsService subscribeContactsService;
  late PluginService pluginService;
  late SmsBlacklistService smsBlacklistService;
  late SmsWhitelistService smsWhitelistService;
  late SmsTextBlacklistService smsTextBlacklistService;
  late SmsTextWhitelistService smsTextWhitelistService;
  late SmsSubscribeService smsSubscriptionService;
  late RegexService regexService;
  late LocationService locationService;

  // 特殊 Service 实例
  late CallerIdService callerIdService;
 // late CallBlockerService callBlockerService;
  late SmsFilterService smsFilterService;
  late CallFilter callFilter;
  late CallerIdMonitorService callerIdMonitorService;

  bool _isDatabaseInitialized = false;
  bool get isDatabaseInitialized => _isDatabaseInitialized;

  bool _areServicesInitialized = false;
  bool get areServicesInitialized => _areServicesInitialized;

  AppState() {
    initServices();
  }


  Future<void> initServices() async {
    await initializeDatabases().then((_) {
      _initServices(); // 这里调用的是 void 返回类型的方法
    });
  }

  Future<void> _initServices() async {
      // 创建 ChannelManager 实例并初始化
  final callChannelManager = CallChannelManager();
    final smsChannelManager = SmsChannelManager();
  callChannelManager.initialize();
smsChannelManager.initialize();
  
        final blockedCallRepository = BlockedCallRepository();



    // 初始化 CallerIdService
    callerIdService = await CallerIdService.create(
      database: callRuleDatabase,
    );



    // 初始化 CallFilter
    callFilter = await CallFilter.create(
      database: callRuleDatabase,
    );


  
    // 初始化 CallerIdMonitorService


    callerIdMonitorService = CallerIdMonitorService(callChannelManager, callerIdService, callFilter, blockedCallRepository);
    



        smsFilterService = await SmsFilterService.create(
  database: callRuleDatabase,
  smsChannelManager: smsChannelManager, // Pass the SmsChannelManager instance
);
  


/*
    // 设置 SMS 监听器
    SmsFilterService.smsChannel.setMethodCallHandler((call) async {
      if (call.method == 'onSmsReceived') {
        final String phoneNumber = call.arguments['phoneNumber'];
        final String messageContent = call.arguments['messageContent'];
        await smsFilterService.handleIncomingSms(phoneNumber, messageContent);
      }
    });
*/
    _areServicesInitialized = true;
    _updateProgress(servicesInitWeight);
  }

  @override
  void dispose() {
    initializationProgress.dispose();
    super.dispose();
  }

  Future<void> initializeDatabases() async {
    if (_isDatabaseInitialized) return;

    await _openDatabase();
    _isDatabaseInitialized = true;
    _updateProgress(databaseInitWeight);
    await _createAllTables();

    await _createServiceInstances();
  }
  
  Future<void> _openDatabase() async {
    final dbPath = path_helper.join(await getDatabasesPath(), 'call_rule_database.db');
    callRuleDatabase = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await _createAllTables(db);
      },
    );
  }

  Future<void> _createAllTables([Database? db]) async {
    Database database = db ?? callRuleDatabase;
    // 创建所有需要的表
    List<String> tableQueries = [
      '''CREATE TABLE IF NOT EXISTS blacklist_phonenumber (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT,
        isSubscribed INTEGER,
        count INTEGER DEFAULT 0,
        url TEXT 
      )''',
      '''CREATE TABLE IF NOT EXISTS whitelist_phonenumber (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT,
        isSubscribed INTEGER,
        count INTEGER DEFAULT 0,
        url TEXT 
      )''',
      '''CREATE TABLE IF NOT EXISTS subscription_models (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            url TEXT,
            enabled INTEGER,
            isWhitelist INTEGER,
            isBlacklist INTEGER,
            lastUpdated TEXT,
            isAutoUpdate INTEGER
      )''',
      '''CREATE TABLE IF NOT EXISTS allowed_phonenumber (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT
      )''',
      '''CREATE TABLE IF NOT EXISTS blocked_phonenumber (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT
      )''',
      '''CREATE TABLE IF NOT EXISTS labeled_calls (
        phoneNumber TEXT,
        label TEXT,
        name TEXT,
        avatar TEXT
      )''',
      '''CREATE TABLE IF NOT EXISTS contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      phone_numbers TEXT NOT NULL,
      email TEXT,
      label TEXT,
      avatar TEXT,
      website TEXT,
      "group" TEXT,
      url TEXT
      )''',
      '''CREATE TABLE IF NOT EXISTS contact_subscriptions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      url TEXT,
      enabled INTEGER,
      last_updated TEXT,
      isAutoUpdate INTEGER
      )''',
      '''CREATE TABLE IF NOT EXISTS plugins (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT,
        version TEXT NOT NULL,
        enabled INTEGER NOT NULL,
        pluginOrder INTEGER NOT NULL,
        isAutoUpdate INTEGER 
      )''',
      '''CREATE TABLE IF NOT EXISTS sms_blacklisted (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT,
        isSubscribed INTEGER,
        url TEXT
      )''',
      '''CREATE TABLE IF NOT EXISTS sms_whitelisted (
        phoneNumber TEXT UNIQUE,
        label TEXT,
        name TEXT,
        avatar TEXT,
        isSubscribed INTEGER,
        url TEXT
      )''',
      '''CREATE TABLE IF NOT EXISTS sms_text_blacklisted (
        keyword TEXT NOT NULL UNIQUE,
        name TEXT,
        isSubscribed INTEGER,
        url TEXT
      )''',
      '''CREATE TABLE IF NOT EXISTS sms_text_whitelisted (
        keyword TEXT NOT NULL UNIQUE,
        name TEXT,
        isSubscribed INTEGER,
        url TEXT
      )''',
      '''CREATE TABLE IF NOT EXISTS sms_subscribe (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            url TEXT,
            enabled INTEGER,
            isWhitelist INTEGER,
            isBlacklist INTEGER,
            isNumberType INTEGER,  -- 使用整数来表示是否为 number 类型
            lastUpdated TEXT,
            isAutoUpdate INTEGER
      )''',
      '''CREATE TABLE IF NOT EXISTS regex_patterns (
        pattern TEXT PRIMARY KEY, 
        name TEXT,        
        isWhitelist INTEGER,
        isBlacklist INTEGER,     
        enabled INTEGER 
      )''',
      '''CREATE TABLE IF NOT EXISTS location_data (
        phoneNumber TEXT NOT NULL,
        region TEXT,
        countryName TEXT,
        carrier TEXT,
        numberType TEXT NOT NULL
      )'''
      // Add other table creation queries here
    ];

    double progressPerTable = tablesCreateWeight / tableQueries.length;
    for (String query in tableQueries) {
      try {
        await database.execute(query);
        _updateProgress(progressPerTable);
      } catch (e) {
        // print('Error creating table: ${e.toString()}');
        // 可以选择重新抛出错误或以其他方式处理
      }
    }
  }

  Future<void> _createServiceInstances() async {
    List<Future Function()> serviceInitializers = [
      () async => blacklistService = BlacklistService(callRuleDatabase),
      () async => whitelistService = WhitelistService(callRuleDatabase),
      () async => subscriptionService = SubscriptionService(callRuleDatabase),
      () async => allowedService = AllowedService(callRuleDatabase),
      () async => blockedService = BlockedService(callRuleDatabase),
      () async => labelService = LabelService(callRuleDatabase),
      () async => contactService = ContactService(callRuleDatabase),
      () async =>
          subscribeContactsService = SubscribeContactsService(callRuleDatabase),
      () async => pluginService = PluginService(callRuleDatabase),
      () async => smsBlacklistService = SmsBlacklistService(callRuleDatabase),
      () async => smsWhitelistService = SmsWhitelistService(callRuleDatabase),
      () async =>
          smsTextBlacklistService = SmsTextBlacklistService(callRuleDatabase),
      () async =>
          smsTextWhitelistService = SmsTextWhitelistService(callRuleDatabase),
      () async =>
          smsSubscriptionService = SmsSubscribeService(callRuleDatabase),
      () async => regexService = RegexService(callRuleDatabase),
      () async => locationService = LocationService(callRuleDatabase),
    ];

    double progressPerService =
        servicesCreateWeight / serviceInitializers.length;
    await Future.wait(serviceInitializers.map((initializer) async {
      await initializer();
      _updateProgress(progressPerService);
    }));

    _areServicesInitialized = true;
  }

  void _updateProgress(double increment) {
    initializationProgress.value += increment;
    notifyListeners();
  }

  Future<void> reinitializeServices() async {
    await _openDatabase().then((_) async {
      await _createServiceInstances().then((_) {
        _initServices();
      });
    });
  }

  Future<void> ensureServicesInitialized() async {
    if (!_areServicesInitialized) {
      await reinitializeServices();
    }
  }
}
