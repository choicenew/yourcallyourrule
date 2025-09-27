// core/services/notification_config.dart

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// 通知配置数据类
/// 职责：定义一个通知的所有视觉和行为参数。
class NotificationConfig {
  final String channelId;
  final String channelName;
  final String channelDescription;
  final Importance importance;
  final Priority priority;
  final Duration autoCancelDelay;
  final bool playSound;
  final String? soundSource;
  final bool enableVibration;
  final bool showBadge;
  final Color? color;

  const NotificationConfig({
    required this.channelId,
    required this.channelName,
    this.channelDescription = '',
    this.importance = Importance.defaultImportance,
    this.priority = Priority.defaultPriority,
    this.autoCancelDelay = const Duration(seconds: 5),
    this.playSound = true,
    this.soundSource,
    this.enableVibration = true,
    this.showBadge = true,
    this.color,
  });

  /// 辅助方法，将此配置转换为插件所需的具体类型。
  AndroidNotificationDetails createAndroidDetails() {
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
      playSound: playSound,
      sound: soundSource != null ? RawResourceAndroidNotificationSound(soundSource) : null,
      enableVibration: enableVibration,
      channelShowBadge: showBadge,
      color: color,
    );
  }
}