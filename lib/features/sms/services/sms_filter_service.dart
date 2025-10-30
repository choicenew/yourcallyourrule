import 'dart:async';
import 'package:flutter/services.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/features/sms/services/sms_handlers/sms_filter_handler.dart';
import 'package:yourcallyourrule/features/sms/services/sms_handlers/sms_notification_handler.dart';
import 'package:yourcallyourrule/platform/sms_channel_switcher.dart';

import 'sms_handlers/base_sms_handler.dart';

import 'sms_handlers/incoming_sms_handler.dart';


class SmsFilterService {
  final SmsChannelInterface smsChannelManager;

  // 处理器工厂
  final SmsHandlerFactory _handlerFactory = SmsHandlerFactory();
  
  // 处理器
  late final SmsFilterHandler _filterHandler;
  late final SmsNotificationHandler _notificationHandler;
  late final IncomingSmsHandler _incomingSmsHandler;
  
  SmsFilterService({
    required this.smsChannelManager,
    required List<SmsRegexRule> initialRules,
  }) {
    _initializeHandlers(initialRules);
  }

  static Future<SmsFilterService> create({
    required SmsChannelInterface smsChannelManager,
    required List<SmsRegexRule> rules,
  }) async {
    final service = SmsFilterService(
      smsChannelManager: smsChannelManager,
      initialRules: rules,
    );
    
    await service.initialize();
    return service;
  }
  
  /// 判断是否应该通知
  Future<bool> shouldNotify(String phoneNumber, String messageContent) async {
    return _filterHandler.shouldNotify(phoneNumber, messageContent);
  }
  
  /// 处理接收到的SMS
  Future<void> handleIncomingSms(String phoneNumber, String messageContent) async {
    await _incomingSmsHandler.handleIncomingSms(phoneNumber, messageContent);
  }

  void _initializeHandlers(List<SmsRegexRule> initialRules) {
    // 创建过滤处理器
    _filterHandler = _handlerFactory.create(
      SmsFilterHandler(initialRules: initialRules)
    );
    
    // 创建通知处理器
    _notificationHandler = _handlerFactory.create(
      SmsNotificationHandler()
    );
    
    // 创建接收SMS处理器
    _incomingSmsHandler = _handlerFactory.create(
      IncomingSmsHandler(
        filterHandler: _filterHandler,
        notificationHandler: _notificationHandler,
      )
    );
  }

  Future<void> initialize() async {
    _setupChannelCallbacks();
    await _initializeAllHandlers();
  }

  Future<void> _initializeAllHandlers() async {
    await _filterHandler.initialize();
    await _notificationHandler.initialize();
    await _incomingSmsHandler.initialize();
  }

  void _setupChannelCallbacks() {
    smsChannelManager.onSmsCall = _handleSmsChannelCall;
  }

  Future<void> _handleSmsChannelCall(MethodCall call) async {
    await _incomingSmsHandler.handleSmsChannelCall(call);
  }

  // 公开的API方法，委托给相应的处理器

  Future<void> setEnabled(bool enabled) async {
    await _filterHandler.setEnabled(enabled);
  }

  Future<void> setUseLocalNotification(bool useLocal) async {
    await _notificationHandler.setUseLocalNotification(useLocal);
  }

  Future<void> closeLocalNotification(bool cancelLocal) async {
    await _notificationHandler.closeLocalNotification(cancelLocal);
  }

  Future<void> updateRules(List<SmsRegexRule> rules) async {
    await _filterHandler.updateRules(rules);
  }

  Future<List<SmsRegexRule>> getRules() async {
    return _filterHandler.getRules();
  }

  /// 添加规则
  Future<void> addRules(List<SmsRegexRule> rules) async {
    _filterHandler.addRules(rules);
  }
}