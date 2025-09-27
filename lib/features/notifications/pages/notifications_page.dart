// features/notifications/presentation/pages/notifications_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/notification_history_provider.dart';
import 'package:yourcallyourrule/core/services/notification_manager.dart';
import 'package:yourcallyourrule/data/models/notification_item.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通知页面
/// 显示应用内所有通知的历史记录
class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationHistoryAsync = ref.watch(notificationHistoryProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notifications),
        actions: [
          notificationHistoryAsync.maybeWhen(
            data: (history) => history.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.delete_sweep),
                    onPressed: () => _showClearConfirmationDialog(context, ref),
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: notificationHistoryAsync.when(
        data: (history) => history.isEmpty
            ? _buildEmptyState(context)
            : _buildNotificationList(context, ref, history),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Failed to load notifications: $err',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  /// 构建空状态视图
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_off,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.noNotifications,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  /// 构建通知列表
  Widget _buildNotificationList(BuildContext context, WidgetRef ref, List<NotificationItem> notifications) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationCard(
          notification: notification,
          onDismiss: () async {
            // 这里没有 async gap 问题，因为我们只是调用方法，不关心它的完成
            // 但为了保持健壮性，调用 invalidate 之前可以先不 await
            ref.read(notificationManagerProvider).rawHistoryService.removeNotification(notification.id);
            ref.invalidate(notificationHistoryProvider);
          },
        );
      },
    );
  }

  /// 显示清除确认对话框
  void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog( // 使用一个新的 context 名字以示区分
        title: Text(AppLocalizations.of(context)!.clearAllNotifications),
        content: Text(AppLocalizations.of(context)!.clearAllNotificationsConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () async {
              // 异步操作开始
              await ref.read(notificationManagerProvider).rawHistoryService.clearAllNotifications();
              
              // [核心修正]: 在异步鸿沟之后，检查 context 是否仍然有效
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
              
              // 让主页面的 Provider 失效以刷新UI
              ref.invalidate(notificationHistoryProvider);
            },
            child: Text(AppLocalizations.of(context)!.clearButton),
          ),
        ],
      ),
    );
  }
}

/// 通知卡片组件
class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onDismiss;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) => onDismiss(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          leading: _buildNotificationIcon(),
          title: Text(notification.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification.body),
              const SizedBox(height: 4),
              Text(
                _formatDateTime(context, notification.timestamp),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }

  /// 构建通知图标
  Widget _buildNotificationIcon() {
    IconData iconData;
    Color iconColor;

    switch (notification.type) {
      case 'blocked_call':
        iconData = Icons.call_end;
        iconColor = Colors.red;
        break;
      case 'fraud_alert':
        iconData = Icons.warning;
        iconColor = Colors.orange;
        break;
      case 'stir_result':
        iconData = Icons.verified_user;
        iconColor = Colors.green;
        break;
      case 'sms':
        iconData = Icons.sms;
        iconColor = Colors.blue;
        break;
      case 'deletion_proposal':
        iconData = Icons.delete_forever;
        iconColor = Colors.deepPurple;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = Colors.purple;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withAlpha(50),
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }

  /// 格式化日期时间
   String _formatDateTime(BuildContext context, DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
       return AppLocalizations.of(context)!.daysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return AppLocalizations.of(context)!.hoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return AppLocalizations.of(context)!.minutesAgo(difference.inMinutes);
    } else {
      return AppLocalizations.of(context)!.justNow;
    }
  }
}