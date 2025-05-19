
import 'package:yourcallyourrule/core/services/notification_service.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';

import 'base_sms_handler.dart';

/// SMS通知处理器
/// 专门负责处理SMS通知相关的逻辑
class SmsNotificationHandler extends BaseSmsHandler {
  final NotificationService _notificationService;
  final ConfigRepository _configRepository;
  
  // 通知设置
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  
  // 设置键名
  static const String smsLocalNotificationKey = 'sms_local_notification';
  static const String smsCancelLocalNotificationKey = 'sms_cancel_local_notification';

  /// 构造函数
  SmsNotificationHandler({
    NotificationService? notificationService,
    ConfigRepository? configRepository,
  }) : _notificationService = notificationService ?? NotificationService(),
       _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  /// 初始化通知
  @override
  Future<void> initialize() async {
    await loadSettings();
  }

  /// 加载设置
  Future<void> loadSettings() async {
    final localNotificationConfig = await _configRepository.getConfig(smsLocalNotificationKey);
    useLocalNotification = localNotificationConfig?['value'] as bool? ?? false;
    
    final cancelNotificationConfig = await _configRepository.getConfig(smsCancelLocalNotificationKey);
    cancelLocalNotification = cancelNotificationConfig?['value'] as bool? ?? false;
  }

  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;

    useLocalNotification = useLocal;
    await _configRepository.saveConfig(smsLocalNotificationKey, {'value': useLocal});
  }

  /// 设置是否关闭本地通知
  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;

    cancelLocalNotification = cancelLocal;
    await _configRepository.saveConfig(smsCancelLocalNotificationKey, {'value': cancelLocal});
  }

  /// 显示SMS通知
  Future<void> showSmsNotification(String phoneNumber, String messageContent) async {
    if (!useLocalNotification) return;
    
    // 使用NotificationService显示通知
    await _notificationService.showNotificationWithConfig(
      config: NotificationConfig(
        channelId: 'sms_notifications',
        channelName: '短信通知',
        channelDescription: '显示接收到的短信信息',
        titleBuilder: (_) => '收到短信',
        bodyBuilder: (_) => '来自: $phoneNumber',
      ),
      contentData: messageContent,
      payload: {
        'type': 'sms',
        'phoneNumber': phoneNumber,
        'messageContent': messageContent
      },
      autoCancel: cancelLocalNotification,
    );
  }
  
  /// 显示拦截的SMS通知
  Future<void> showBlockedSmsNotification(String phoneNumber) async {
    if (!useLocalNotification) return;
    
    // 使用NotificationService显示通知
    await _notificationService.showNotificationWithConfig(
      config: NotificationConfig(
        channelId: 'sms_blocker_channel',
        channelName: '短信拦截通知',
        channelDescription: '显示被拦截的短信信息',
        playSound: false,
        titleBuilder: (_) => '短信已拦截',
        bodyBuilder: (_) => '已拦截来自 $phoneNumber 的短信',
      ),
      contentData: phoneNumber,
      payload: {
        'type': 'blocked_sms',
        'phoneNumber': phoneNumber
      },
      autoCancel: cancelLocalNotification,
    );
  }
}