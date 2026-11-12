import 'dart:async';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/sms/data/repositories/sms_regex_rule_repository_impl.dart';
import 'package:yourcallyourrule/features/sms/services/sms_handlers/sms_filter_handler.dart';
import 'package:yourcallyourrule/features/sms/services/sms_handlers/sms_notification_handler.dart';
import 'package:yourcallyourrule/platform/sms_channel_switcher.dart';

import 'sms_handlers/base_sms_handler.dart';
import 'sms_handlers/incoming_sms_handler.dart';

part 'sms_filter_service.g.dart';

@Riverpod(keepAlive: true)
SmsFilterService smsFilterService(Ref ref) {
  final smsRuleRepository = ref.watch(smsRegexRuleRepositoryProvider);
  List<RegexRuleEntity> initialRules = [];
  final smsChannelManager = SmsChannelSwitcher.getPlatformChannelManager();

  final service = SmsFilterService(
    smsChannelManager: smsChannelManager,
    initialRules: initialRules,
  );

  Future.microtask(() async {
    final rules = await smsRuleRepository.getAll();
    service.addRules(rules);
    await service.initialize();
  });

  return service;
}

class SmsFilterService {
  final SmsChannelInterface smsChannelManager;

  final SmsHandlerFactory _handlerFactory = SmsHandlerFactory();
  
  late final SmsFilterHandler _filterHandler;
  late final SmsNotificationHandler _notificationHandler;
  late final IncomingSmsHandler _incomingSmsHandler;
  
  SmsFilterService({
    required this.smsChannelManager,
    required List<RegexRuleEntity> initialRules,
  }) {
    _initializeHandlers(initialRules);
  }

  static Future<SmsFilterService> create({
    required SmsChannelInterface smsChannelManager,
    required List<RegexRuleEntity> rules,
  }) async {
    final service = SmsFilterService(
      smsChannelManager: smsChannelManager,
      initialRules: rules,
    );
    
    await service.initialize();
    return service;
  }
  
  Future<bool> shouldNotify(String phoneNumber, String messageContent) async {
    return _filterHandler.shouldNotify(phoneNumber, messageContent);
  }
  
  Future<void> handleIncomingSms(String phoneNumber, String messageContent) async {
    await _incomingSmsHandler.handleIncomingSms(phoneNumber, messageContent);
  }

  void _initializeHandlers(List<RegexRuleEntity> initialRules) {
    _filterHandler = _handlerFactory.create(
      SmsFilterHandler(initialRules: initialRules)
    );
    
    _notificationHandler = _handlerFactory.create(
      SmsNotificationHandler()
    );
    
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

  Future<void> setEnabled(bool enabled) async {
    await _filterHandler.setEnabled(enabled);
  }

  Future<void> setUseLocalNotification(bool useLocal) async {
    await _notificationHandler.setUseLocalNotification(useLocal);
  }

  Future<void> closeLocalNotification(bool cancelLocal) async {
    await _notificationHandler.closeLocalNotification(cancelLocal);
  }

  Future<void> updateRules(List<RegexRuleEntity> rules) async {
    await _filterHandler.updateRules(rules);
  }

  Future<List<RegexRuleEntity>> getRules() async {
    return _filterHandler.getRules();
  }

  Future<void> addRules(List<RegexRuleEntity> rules) async {
    _filterHandler.addRules(rules);
  }
}
