// features/notifications/presentation/pages/notifications_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_history_provider.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_manager.dart';
import 'package:yourcallyourrule/data/models/notification_item.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通知页面 (Elite Dopamine 现代视觉规范)
/// 显示应用内所有通知的历史记录
class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final notificationHistoryAsync = ref.watch(notificationHistoryProvider);
    
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          l10n.notifications,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          notificationHistoryAsync.maybeWhen(
            data: (history) => history.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
                    tooltip: l10n.clearAllNotifications,
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
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEDE8DF), width: 1.1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noNotifications,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建通知列表
  Widget _buildNotificationList(BuildContext context, WidgetRef ref, List<NotificationItem> notifications) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationCard(
          notification: notification,
          onDismiss: () async {
            ref.read(notificationManagerProvider).rawHistoryService.removeNotification(notification.id);
            ref.invalidate(notificationHistoryProvider);
          },
        );
      },
    );
  }

  /// 显示清除确认对话框
  void _showClearConfirmationDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.clearAllNotifications, style: const TextStyle(fontWeight: FontWeight.w800)),
        content: Text(l10n.clearAllNotificationsConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancelButton, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(notificationManagerProvider).rawHistoryService.clearAllNotifications();
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
              ref.invalidate(notificationHistoryProvider);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text(l10n.clearButton, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}

/// 通知卡片组件 (Elite Dopamine 现代视觉规范)
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
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
      onDismissed: (_) => onDismiss(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFEDE8DF),
            width: 1.1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationIcon(),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatDateTime(context, notification.timestamp),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
        iconData = Icons.call_end_rounded;
        iconColor = Colors.redAccent;
        break;
      case 'fraud_alert':
        iconData = Icons.warning_amber_rounded;
        iconColor = Colors.orangeAccent;
        break;
      case 'stir_result':
        iconData = Icons.verified_user_rounded;
        iconColor = EliteDopamineTheme.freshMint;
        break;
      case 'sms':
        iconData = Icons.sms_rounded;
        iconColor = const Color(0xFF2D9CDB);
        break;
      case 'deletion_proposal':
        iconData = Icons.delete_forever_rounded;
        iconColor = const Color(0xFF6C5CE7);
        break;
      default:
        iconData = Icons.notifications_rounded;
        iconColor = EliteDopamineTheme.sunsetTangerine;
    }

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          iconData,
          color: iconColor,
          size: 20,
        ),
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