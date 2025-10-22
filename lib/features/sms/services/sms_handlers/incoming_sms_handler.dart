import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/core/router/app_router.dart'; // [1] 导入 AppRouter
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart'; // [2] 导入以创建 Config
import 'package:yourcallyourrule/generated/app_localizations.dart'; // [3] 导入以使用国际化
import 'base_sms_handler.dart';
import 'sms_filter_handler.dart';
import 'sms_notification_handler.dart';


class IncomingSmsHandler extends BaseSmsHandler {
  // 您的所有属性和构造函数都保持不变
  final SmsFilterHandler _filterHandler;
  final SmsNotificationHandler _notificationHandler;
  final BlockedCallRepository _blockedCallRepository;

  IncomingSmsHandler({
    required SmsFilterHandler filterHandler,
    required SmsNotificationHandler notificationHandler,
    BlockedCallRepository? blockedCallRepository,
  }) : 
    _filterHandler = filterHandler,
    _notificationHandler = notificationHandler,
    _blockedCallRepository = blockedCallRepository ?? BlockedCallRepository();

  // 您的 handleSmsChannelCall 方法保持不变
  @override
  Future<void> handleSmsChannelCall(MethodCall call) async {
    if (call.method == "onReceivedSms") {
      final String phoneNumber = call.arguments['phoneNumber'];
      final String messageContent = call.arguments['messageContent'];
      await handleIncomingSms(phoneNumber, messageContent);
    }
  }

  /// 【这是唯一被修改的方法】
  Future<void> handleIncomingSms(String phoneNumber, String messageContent) async {
    // [A] 在方法内部获取 context
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    // 您的原有逻辑保持不变
    await _filterHandler.loadSettings();
    await _notificationHandler.loadSettings();
    if (!_filterHandler.isEnabled) return;
    
    bool shouldNotifyUser = await _filterHandler.shouldNotify(phoneNumber, messageContent);
    final l10n = AppLocalizations.of(context)!;

    if (shouldNotifyUser) {
      // [B] 调用新的方法，并传入在这里创建的 config
      await _notificationHandler.showSmsNotification(
        title: l10n.sms,
        body: messageContent,
        phoneNumber: phoneNumber,
        messageContent: messageContent,
        config: NotificationService.defaultConfig(context),
      );
    } else {
      // [C] 调用新的方法，并传入在这里创建的 config
      await _notificationHandler.showBlockedSmsNotification(
        title: '已拦截短信',//l10n.blockedSmsTitle,
        body: '已成功拦截来自 $phoneNumber 的短信',//l10n.blockedSmsBody(phoneNumber),
        phoneNumber: phoneNumber,
        config: NotificationService.blockedCallConfig(context),
      );
      
      await _blockedCallRepository.addBlockedSms(phoneNumber);
    }
  }
}