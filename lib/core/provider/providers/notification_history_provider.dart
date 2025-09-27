// features/notifications/providers/notification_history_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/services/notification_history_service.dart';
import 'package:yourcallyourrule/data/models/notification_item.dart';



part 'notification_history_provider.g.dart';

/// 通知历史状态 Provider
/// 职责：提供一个只读的、可被UI监听的通知历史列表。
@Riverpod(keepAlive: true)
Future<List<NotificationItem>> notificationHistory(Ref ref) async {
  final service = ref.watch(notificationHistoryServiceProvider);
  final notifications = await service.loadNotifications();
  notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  return notifications;
}