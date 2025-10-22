// features/notifications/notification_manager.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_history_provider.dart';

import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';

import 'package:yourcallyourrule/features/notifications/config/notification_config.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_history_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service_contract.dart';

part 'notification_manager.g.dart';

@Riverpod(keepAlive: true)
NotificationManager notificationManager(Ref ref) {
  return NotificationManager(ref);
}

/// 通知管理器 (Facade)
/// 职责：作为应用内所有通知功能的统一入口，协调底层的服务。
class NotificationManager {
  NotificationManager(this._ref);
  final Ref _ref;

  NotificationServiceContract get _notificationService => _ref.read(notificationServiceProvider);
  NotificationHistoryService get _historyService => _ref.read(notificationHistoryServiceProvider);

  Future<void> showAndRecord({
    required String title, required String body, required NotificationConfig config,
    required String type, int notificationId = 0, Map<String, dynamic>? payload,
    bool autoCancel = true, Duration? autoCancelDelay,
  }) async {
    await _notificationService.showNotification(
      title: title, body: body, config: config,
      notificationId: notificationId, payload: payload,
      autoCancel: autoCancel, autoCancelDelay: autoCancelDelay,
    );
    await _historyService.addNotification(
      title: title, body: body, type: type, payload: payload,
    );
    _ref.invalidate(notificationHistoryProvider);
  }

  Future<void> showActionsAndRecord({
    required String title, required String body, required NotificationConfig config,
    required String type, required List<NotificationAction> actions,
    int notificationId = 0, Map<String, dynamic>? payload,
  }) async {
    await _notificationService.showNotificationWithActions(
      title: title, body: body, config: config, actions: actions,
      notificationId: notificationId, payload: payload,
    );
    await _historyService.addNotification(
      title: title, body: body, type: type, payload: payload,
    );
    _ref.invalidate(notificationHistoryProvider);
  }

  NotificationServiceContract get rawNotificationService => _notificationService;
  NotificationHistoryService get rawHistoryService => _historyService;
}