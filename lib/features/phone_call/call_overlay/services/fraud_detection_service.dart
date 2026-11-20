import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/core/coordinator/app_coordinator.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/call_policy_evaluator.dart';
import 'fraud_alert_config_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 诈骗检测服务
class FraudDetectionService {

  static bool checkForFraudLabels(CallerIdData callerIdData, {List<String>? userCustomKeywords}) {
    if (callerIdData.labels.isEmpty) {
      return false;
    }
    for (final label in callerIdData.labels) {
      if (CallPolicyEvaluator.isFraudLabel(label, userCustomKeywords: userCustomKeywords)) {
        return true;
      }
    }
    if (callerIdData.phoneNumber.contains('+') && callerIdData.labels.length <= 1) {
      return true;
    }
    return false;
  }

  static Future<void> triggerFraudAlert(String phoneNumber, {AppCoordinator? coordinator}) async {
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    final title = "⚠️ ${AppLocalizations.of(context).fraudAlertTitle} ($phoneNumber)";
    final body = AppLocalizations.of(context).securityMessage;

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

    AppCoordinator? appCoordinator = coordinator;
    if (appCoordinator == null) {
      try {
        appCoordinator = ProviderScope.containerOf(context, listen: false).read(appCoordinatorProvider);
      } catch (_) {}
    }

    appCoordinator?.emit('show_system_notification', {
      'title': title,
      'body': body,
      'type': 'fraud_alert',
      'notificationId': phoneNumber.hashCode + 2,
      'payload': {'type': 'fraud_alert', 'phone': phoneNumber},
      'autoCancel': config.isAutoCancelEnabled,
      'autoCancelDelaySeconds': config.autoCancelDelaySeconds,
    });
  }
}
