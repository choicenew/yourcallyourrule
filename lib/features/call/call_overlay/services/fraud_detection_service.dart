import 'package:flutter/services.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'fraud_alert_config_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 诈骗检测服务
class FraudDetectionService {

  static bool checkForFraudLabels(CallerIdData callerIdData) {
    if (callerIdData.labels.isEmpty) {
      return false;
    }
    final fraudKeywords = [
      'Fraud', 'Scam', 'Spam','Scams',
      'Fraud Scam Likely', 'Spam Likely', 'Scams Likely',
      'Risk', 'Silent Call Voice Clone'
    ];
    final hasSuspiciousNumberFeatures = callerIdData.phoneNumber.contains('+');
    for (final label in callerIdData.labels) {
      if (fraudKeywords.any((keyword) => label.toLowerCase().contains(keyword.toLowerCase()))) {
        return true;
      }
    }
    if (hasSuspiciousNumberFeatures && callerIdData.labels.length <= 1) {
      return true;
    }
    return false;
  }

  static Future<void> triggerFraudAlert(String phoneNumber) async {
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    final notificationConfig = NotificationService.fraudAlertConfig(context);
    final title = "⚠️ ${AppLocalizations.of(context)!.fraudAlertTitle} ($phoneNumber)";
    final body = AppLocalizations.of(context)!.securityMessage;

    final config = await FraudAlertConfigService.getConfig();

    if (!config.isEnabled) {
      return;
    }

    if (config.isVibrationEnabled) {
      HapticFeedback.heavyImpact();
      Future.delayed(const Duration(milliseconds: 500), () {
        HapticFeedback.heavyImpact();
      });
    }

    final notificationService = NotificationService();

    await notificationService.showNotification(
      config: notificationConfig,
      title: title,
      body: body,
      notificationId: phoneNumber.hashCode + 2,
      payload: {'type': 'fraud_alert', 'phone': phoneNumber},
      autoCancel: config.isAutoCancelEnabled,
      autoCancelDelay: Duration(seconds: config.autoCancelDelaySeconds),
    );
  }
}
