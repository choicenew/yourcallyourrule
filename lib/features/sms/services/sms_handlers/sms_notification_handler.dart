import 'package:yourcallyourrule/core/coordinator/app_coordinator.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

import 'base_sms_handler.dart';

class SmsNotificationHandler extends BaseSmsHandler {
  final ConfigRepository _configRepository;
  final AppCoordinator? _coordinator;

  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  static const String smsLocalNotificationKey = 'config_sms_local_notification';
  static const String smsCancelLocalNotificationKey = 'config_sms_cancel_local_notification';

  SmsNotificationHandler({
    ConfigRepository? configRepository,
    AppCoordinator? coordinator,
  })  : _configRepository = configRepository ?? SharedPreferencesConfigRepository(),
        _coordinator = coordinator;

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
  }) async {
    if (!useLocalNotification) return;

    _coordinator?.emit('show_system_notification', {
      'title': title,
      'body': body,
      'type': 'sms',
      'notificationId': phoneNumber.hashCode,
      'payload': {'type': 'sms', 'phoneNumber': phoneNumber, 'messageContent': messageContent},
      'autoCancel': cancelLocalNotification,
    });
  }
  
  Future<void> showBlockedSmsNotification({
    required String title,
    required String body,
    required String phoneNumber,
  }) async {
    if (!useLocalNotification) return;

    _coordinator?.emit('show_system_notification', {
      'title': title,
      'body': body,
      'type': 'blocked_sms',
      'notificationId': phoneNumber.hashCode,
      'payload': {'type': 'blocked_sms', 'phoneNumber': phoneNumber},
      'autoCancel': cancelLocalNotification,
    });
  }
}
