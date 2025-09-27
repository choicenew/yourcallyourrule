// core/services/notification_service_contract.dart
// core/services/notification_service_contract.dart

import 'package:yourcallyourrule/core/services/notification_config.dart';

/// 通知服务接口 (契约)
/// 职责：定义应用内所有通知服务必须遵守的契约。
abstract class NotificationServiceContract {
  /// 显示通知
  /// [title] 通知标题
  /// [body] 通知内容
  /// [config] 包含渠道ID、名称、重要性等所有配置的对象
  /// [notificationId] 通知ID，用于更新或取消通知
  /// [payload] 通知负载，可用于点击通知时传递数据
  /// [autoCancel] 点击后是否自动取消
  /// [autoCancelDelay] 自动取消的延迟时间
  Future<void> showNotification({
    required String title,
    required String body,
    required NotificationConfig config,
    int notificationId = 0,
    Map<String, dynamic>? payload,
    bool autoCancel = true,
    Duration? autoCancelDelay,
  });

  /// 显示带有动作按钮的通知
  /// [title] 通知标题
  /// [body] 通知内容
  /// [config] 包含渠道ID、名称、重要性等所有配置的对象
  /// [actions] 通知动作列表
  /// [notificationId] 通知ID，用于更新或取消通知
  /// [payload] 通知负载，可用于点击通知时传递数据
  Future<void> showNotificationWithActions({
    required String title,
    required String body,
    required NotificationConfig config,
    required List<NotificationAction> actions,
    int notificationId = 0,
    Map<String, dynamic>? payload,
  });

  /// 取消通知
  /// [notificationId] 通知ID
  Future<void> cancelNotification(int notificationId);

  /// 取消所有通知
  Future<void> cancelAllNotifications();

  /// 检查通知权限
  Future<bool> checkPermission();

  /// 请求通知权限
  Future<bool> requestPermission();

  /// 打开通知设置
  Future<void> openSettings();

  /// 初始化通知服务
  Future<void> initialize();

  /// 处理通知点击事件
  void onNotificationTapped(Function(Map<String, dynamic>? payload) handler);

  /// 处理通知动作点击事件
  void onNotificationActionTapped(Function(String actionId, Map<String, dynamic>? payload) handler);
}

/// 通知动作类
class NotificationAction {
  /// 动作ID
  final String id;
  
  /// 动作标题
  final String title;
  
  /// 是否为破坏性动作（通常显示为红色）
  final bool isDestructive;
  
  /// 是否在后台处理（不会打开应用）
  final bool isBackground;
  
  /// 构造函数
  const NotificationAction({
    required this.id,
    required this.title,
    this.isDestructive = false,
    this.isBackground = false,
  });
}
/// 通知重要性级别枚举
enum NotificationImportance {
  none,      // 无声音，无视觉干扰
  min,       // 无声音，状态栏图标
  low,       // 无声音，状态栏和通知栏可见
  default_,  // 有声音，状态栏和通知栏可见
  high,      // 有声音，状态栏和通知栏可见，可能会有横幅
  max,       // 有声音，状态栏和通知栏可见，会有横幅和全屏意图
}