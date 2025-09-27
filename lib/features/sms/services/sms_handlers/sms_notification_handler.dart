import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yourcallyourrule/core/services/notification_config.dart';
import 'package:yourcallyourrule/core/services/notification_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';


import 'base_sms_handler.dart';

/// SMS通知处理器
class SmsNotificationHandler extends BaseSmsHandler {
  final NotificationService _notificationService;
  final ConfigRepository _configRepository;

  // 您的所有属性都保持不变
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  static const String smsLocalNotificationKey = 'config_sms_local_notification';
  static const String smsCancelLocalNotificationKey = 'config_sms_cancel_local_notification';

  // 您的构造函数保持不变
  SmsNotificationHandler({
    NotificationService? notificationService,
    ConfigRepository? configRepository,
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  })  : _notificationService = notificationService ?? NotificationService(),
        _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  // 您的 initialize, loadSettings, setUseLocalNotification, closeLocalNotification 方法全部保持不变
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

  /// 【唯一修改点 A】: 修改方法签名，直接接收 NotificationConfig
  Future<void> showSmsNotification({
    required String title,
    required String body,
    required String phoneNumber,
    required String messageContent,
    required NotificationConfig config, // 新增参数
  }) async {
    if (!useLocalNotification) return;

    await _notificationService.showNotification(
      config: config, // 使用传入的 config
      title: title,
      body: body,
      payload: {'type': 'sms', 'phoneNumber': phoneNumber, 'messageContent': messageContent},
      autoCancel: cancelLocalNotification,
    );
  }
  
  /// 【唯一修改点 B】: 修改方法签名，直接接收 NotificationConfig
  Future<void> showBlockedSmsNotification({
    required String title,
    required String body,
    required String phoneNumber,
    required NotificationConfig config, // 新增参数
  }) async {
    if (!useLocalNotification) return;

    await _notificationService.showNotification(
      config: config, // 使用传入的 config
      title: title,
      body: body,
      payload: {'type': 'blocked_sms', 'phoneNumber': phoneNumber},
      autoCancel: cancelLocalNotification,
    );
  }
}