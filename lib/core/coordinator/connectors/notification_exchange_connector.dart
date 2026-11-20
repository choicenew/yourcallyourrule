import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/common/router/app_router_provider.dart';
import 'package:yourcallyourrule/features/notifications/config/notification_config.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_history_provider.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_manager.dart';
import '../app_coordinator.dart';

class NotificationExchangeConnector {
  final Ref ref;
  final AppCoordinator coordinator;

  const NotificationExchangeConnector({
    required this.ref,
    required this.coordinator,
  });

  void initialize() {
    coordinator.on('show_system_notification', (payload) async {
      try {
        final title = payload['title'] as String? ?? '';
        final body = payload['body'] as String? ?? '';
        final type = payload['type'] as String? ?? 'general';
        final notificationId = payload['notificationId'] as int?;
        final notificationPayload = payload['payload'] as Map<String, dynamic>?;
        final manager = ref.read(notificationManagerProvider);

        String channelId = 'general';
        String channelName = 'General Notifications';
        Importance importance = Importance.high;
        Priority priority = Priority.high;
        bool playSound = true;
        bool enableVibration = true;

        switch (type) {
          case 'deletion_proposal':
            channelId = 'deletion_proposals';
            channelName = 'Deletion Proposals';
            break;
          case 'fraud_alert':
            channelId = 'fraud_alert';
            channelName = 'Fraud Alerts';
            importance = Importance.max;
            break;
          case 'blocked_call':
          case 'blocked_calls':
            channelId = 'blocked_calls';
            channelName = 'Blocked Calls';
            importance = Importance.max;
            playSound = false;
            enableVibration = false;
            break;
          case 'sms':
          case 'blocked_sms':
            channelId = 'sms';
            channelName = 'SMS Notifications';
            break;
        }

        final config = NotificationConfig(
          channelId: channelId,
          channelName: channelName,
          importance: importance,
          priority: priority,
          playSound: playSound,
          enableVibration: enableVibration,
        );
        await manager.showAndRecord(
          title: title,
          body: body,
          config: config,
          type: type,
          notificationId: notificationId ?? 0,
          payload: notificationPayload,
        );

        final autoCancel = payload['autoCancel'] as bool? ?? false;
        final autoCancelDelaySeconds = payload['autoCancelDelaySeconds'] as int?;
        if (autoCancel && notificationId != null) {
          final delay = Duration(seconds: autoCancelDelaySeconds ?? 5);
          Future.delayed(delay, () async {
            try {
              await manager.rawNotificationService.cancelNotification(notificationId);
            } catch (_) {}
          });
        }
      } catch (e) {
        debugPrint('[NotificationConnector] show_system_notification error: $e');
      }
    });

    coordinator.on('cancel_system_notification', (payload) async {
      try {
        final notificationId = payload['notificationId'] as int?;
        if (notificationId != null) {
          final manager = ref.read(notificationManagerProvider);
          await manager.rawNotificationService.cancelNotification(notificationId);
        }
      } catch (e) {
        debugPrint('[NotificationConnector] cancel_system_notification error: $e');
      }
    });

    coordinator.on('clear_notifications_by_type', (payload) async {
      try {
        final type = payload['type'] as String?;
        if (type != null) {
          final manager = ref.read(notificationManagerProvider);
          await manager.rawHistoryService.removeNotificationsByType(type);
          ref.invalidate(notificationHistoryProvider);
        }
      } catch (e) {
        debugPrint('[NotificationConnector] clear_notifications_by_type error: $e');
      }
    });

    try {
      final manager = ref.read(notificationManagerProvider);
      manager.rawNotificationService.onNotificationTapped((payload) {
        if (payload != null) {
          final type = payload['type'] as String?;
          if (type == 'deletion_proposal') {
            final data = payload['data'] as Map<String, dynamic>?;
            final proposalId = data?['proposalId'] as String?;
            final router = ref.read(appRouterProvider).router;
            const String deletionProposalPath = '/deletion-proposal';
            if (proposalId != null && proposalId.isNotEmpty && proposalId != 'pending_proposals') {
              router.push('$deletionProposalPath/$proposalId');
            } else {
              router.push(deletionProposalPath);
            }
          }
        }
      });
    } catch (e) {
      debugPrint('[NotificationConnector] onNotificationTapped setup error: $e');
    }
  }
}

