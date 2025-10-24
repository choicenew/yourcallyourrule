// 导入 Flutter 核心包

import 'package:flutter/services.dart';
// 导入项目中的实体类和服务
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart'; // FraudAlertConfigService 在这里


import 'package:yourcallyourrule/features/call/caller_id/services/fraud_alert_config_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 诈骗检测服务
/// 【最终修正】: 恢复为一个包含静态方法的纯粹工具类。
/// 它不通过 Riverpod 进行依赖注入，而是在需要时直接创建它所依赖的服务的临时实例。
class FraudDetectionService {

  /// 检查是否包含诈骗相关标签（静态方法）
  static bool checkForFraudLabels(CallerIdData callerIdData) {
    if (callerIdData.labels == null || callerIdData.labels!.isEmpty) {
      return false;
    }
    final fraudKeywords = [
      'Fraud', 'Scam', 'Spam','Scams',
      'Fraud Scam Likely', 'Spam Likely', 'Scams Likely',
      'Risk', 'Silent Call Voice Clone'
    ];
    final hasSuspiciousNumberFeatures = callerIdData.phoneNumber.value.contains('+');
    for (final label in callerIdData.labels!) {
      if (fraudKeywords.any((keyword) => label.label.toLowerCase().contains(keyword.toLowerCase()))) {
        return true;
      }
    }
    if (hasSuspiciousNumberFeatures && callerIdData.labels!.length <= 1) {
      return true;
    }
    return false;
  }

  /// 触发增强的反诈骗提醒（静态方法）
  static Future<void> triggerFraudAlert(String phoneNumber) async {
    // 1. 在所有 await 之前，立即获取 context
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    // 2. 在 await 之前，使用 context 准备好所有需要的数据
    final notificationConfig = NotificationService.fraudAlertConfig(context);
    final title = "⚠️ ${AppLocalizations.of(context)!.fraudAlertTitle} ($phoneNumber)";
    final body = AppLocalizations.of(context)!.securityMessage;
    
    // --- 从这里开始可以有异步操作 ---

    // 【核心修正】: 在静态方法内部，手动创建它所需要的依赖的临时实例。
           
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

    // 手动创建 NotificationService 的实例
    final notificationService = NotificationService();
    
    // 3. 使用预先准备好的变量
    await notificationService.showNotification(
      config: notificationConfig,
      title: title,
      body: body,
      notificationId: phoneNumber.hashCode + 2,
      payload: {'type': 'fraud_alert', 'phone': phoneNumber},
      // 使用从配置中获取的自动取消设置
      autoCancel: config.isAutoCancelEnabled,
      autoCancelDelay: Duration(seconds: config.autoCancelDelaySeconds),
    );
  }
}