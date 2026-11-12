import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'base_sms_handler.dart';
import 'sms_filter_handler.dart';
import 'package:yourcallyourrule/features/sms/services/sms_handlers/sms_notification_handler.dart';

class IncomingSmsHandler extends BaseSmsHandler {
  final SmsFilterHandler _filterHandler;
  final SmsNotificationHandler _notificationHandler;

  IncomingSmsHandler({
    required SmsFilterHandler filterHandler,
    required SmsNotificationHandler notificationHandler,
  }) : 
    _filterHandler = filterHandler,
    _notificationHandler = notificationHandler;

  @override
  Future<void> handleSmsChannelCall(MethodCall call) async {
    if (call.method == "onReceivedSms") {
      final String phoneNumber = call.arguments['phoneNumber'];
      final String messageContent = call.arguments['messageContent'];
      await handleIncomingSms(phoneNumber, messageContent);
    }
  }

  Future<void> handleIncomingSms(String phoneNumber, String messageContent) async {
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    await _filterHandler.loadSettings();
    await _notificationHandler.loadSettings();
    if (!_filterHandler.isEnabled) return;
    
    bool shouldNotifyUser = await _filterHandler.shouldNotify(phoneNumber, messageContent);
    final l10n = AppLocalizations.of(context)!;

    if (shouldNotifyUser) {
      await _notificationHandler.showSmsNotification(
        title: l10n.sms,
        body: messageContent,
        phoneNumber: phoneNumber,
        messageContent: messageContent,
        config: NotificationService.defaultConfig(context),
      );
    } else {
      await _notificationHandler.showBlockedSmsNotification(
        title: 'Blocked SMS',
        body: 'Blocked SMS from $phoneNumber',
        phoneNumber: phoneNumber,
        config: NotificationService.blockedCallConfig(context),
      );
    }
  }
}
