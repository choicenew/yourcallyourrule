// features/notifications/providers/notification_providers.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service_contract.dart';

part 'notification_providers.g.dart';

/// 这个 Provider 将 NotificationService 的实例绑定到 NotificationServiceContract 接口上。
@Riverpod(keepAlive: true)
NotificationServiceContract notificationService(Ref ref) {
  final service = NotificationService();
  service.initialize();
  return service;
}