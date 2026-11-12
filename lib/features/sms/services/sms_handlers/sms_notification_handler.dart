import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yourcallyourrule/features/notifications/config/notification_config.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

import 'base_sms_handler.dart';

class SmsNotificationHandler extends BaseSmsHandler {
  final NotificationService _notificationService;
  final ConfigRepository _configRepository;

  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  static const String smsLocalNotificationKey = 'config_sms_local_notification';
  static const String smsCancelLocalNotificationKey = 'config_sms_cancel_local_notification';

  SmsNotificationHandler({
    NotificationService? notificationService,
    ConfigRepository? configRepository,
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  })  : _notificationService = notificationService ?? NotificationService(),
        _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  @override
  Future<void> initialize() async {
    await loadSettings();
  }
  
  Future<void> loadSettings() async {
    final localNotificationConfig = await _configRepository.getConfig(smsLocalNotificationKey);
    useLocalNotification = localNotificationConfig?['value'] as bool? ?? false;
    final cancelNotificationConfig = await _configRepository.getConfig(smsCancelLocalNotificationKey);
    cancelLocalNotification = cancelNotificationConfig?['value'] as bool? ?? false;
  }
  
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;
    useLocalNotification = useLocal;
    await _configRepository.saveConfig(smsLocalNotificationKey, {'value': useLocal});
  }

  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;
    cancelLocalNotification = cancelLocal;
    await _configRepository.saveConfig(smsCancelLocalNotificationKey, {'value': cancelLocal});
  }

  Future<void> showSmsNotification({
    required String title,
    required String body,
    required String phoneNumber,
    required String messageContent,
    required NotificationConfig config,
  }) async {
    if (!useLocalNotification) return;

    await _notificationService.showNotification(
      config: config,
      title: title,
      body: body,
      payload: {'type': 'sms', 'phoneNumber': phoneNumber, 'messageContent': messageContent},
      autoCancel: cancelLocalNotification,
    );
  }
  
  Future<void> showBlockedSmsNotification({
    required String title,
    required String body,
    required String phoneNumber,
    required NotificationConfig config,
  }) async {
    if (!useLocalNotification) return;

    await _notificationService.showNotification(
      config: config,
      title: title,
      body: body,
      payload: {'type': 'blocked_sms', 'phoneNumber': phoneNumber},
      autoCancel: cancelLocalNotification,
    );
  }
}
