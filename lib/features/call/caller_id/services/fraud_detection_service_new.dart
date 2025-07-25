import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';

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
      'Fraud', 'Scam', 'Spam', 
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
  static void triggerFraudAlertNotification() {
    // 触发震动提醒
    HapticFeedback.heavyImpact();
    
    // 延迟后再次触发震动，形成警告模式
    Future.delayed(const Duration(milliseconds: 500), () {
      HapticFeedback.heavyImpact();
    });
  }
  
  /// 触发增强的反诈骗提醒（通知方式）
  static Future<void> triggerFraudAlertDialog(String phoneNumber, {NotificationHandler? notificationHandler}) async {
    // 触发震动提醒
    HapticFeedback.heavyImpact();
    
    // 延迟后再次触发震动，形成警告模式
    Future.delayed(const Duration(milliseconds: 500), () {
      HapticFeedback.heavyImpact();
    });
    
    // 如果提供了通知处理器，则显示通知
    if (notificationHandler != null) {
      await notificationHandler.showFraudAlertNotification(phoneNumber);
    } else {
      // 否则只触发震动提醒
      triggerFraudAlertNotification();
    }
  }
}