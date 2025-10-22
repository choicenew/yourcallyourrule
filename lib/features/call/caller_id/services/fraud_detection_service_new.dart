import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';

import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/fraud_alert_config.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 诈骗检测服务
/// 提供检测诈骗电话和触发警告的功能
class FraudDetectionService {
  /// 检查是否包含诈骗相关标签
  static bool checkForFraudLabels(CallerIdData callerIdData) {
    if (callerIdData.labels == null || callerIdData.labels!.isEmpty) {
      return false;
    }

    // 检查标签中是否包含诈骗相关关键词（增加更多关键词以增强检测能力）
    final fraudKeywords = [
      'Fraud', 'Scam', 'Spam','Scams',
      'Fraud Scam Likely', 'Spam Likely', 'Scams Likely',
      'Risk', 'Silent Call Voice Clone'
    ];

    // 检查电话号码是否有可疑特征（如国际号码前缀+）
    final hasSuspiciousNumberFeatures = callerIdData.phoneNumber.value.contains('+');

    // 检查标签
    for (final label in callerIdData.labels!) {
      if (fraudKeywords.any((keyword) => label.label.toLowerCase().contains(keyword.toLowerCase()))) {
        return true;
      }
    }

    // 如果有可疑特征且没有可信标签，也视为潜在风险
    if (hasSuspiciousNumberFeatures && callerIdData.labels!.length <= 1) {
      return true;
    }

    return false;
  }

  /// 触发增强的反诈骗提醒（通知方式）
  static Future<void> triggerFraudAlert(String phoneNumber) async {
    // 1. 在所有 await 之前，立即获取 context
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    // 2. 在 await 之前，使用 context 准备好所有需要的数据
    //    通过调用 fraudAlertConfig(context) 来获取 NotificationConfig 对象
    final notificationConfig = NotificationService.fraudAlertConfig(context);
    final title = "⚠️ ${AppLocalizations.of(context)!.fraudAlertTitle} ($phoneNumber)";
    final body = AppLocalizations.of(context)!.fraudAlertBody(phoneNumber);
    
    // --- 从这里开始可以有异步操作 ---

    final configService = FraudAlertConfigService(SharedPreferencesConfigRepository());
    final config = await configService.getConfig();

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
    // 3. 使用预先准备好的变量
    await notificationService.showNotification(
      config: notificationConfig, // 使用准备好的 config 对象
      title: title,              // 使用准备好的 title
      body: body,                // 使用准备好的 body
      notificationId: 2,
      payload: {'type': 'fraud_alert', 'phone': phoneNumber},
    );
  }
}