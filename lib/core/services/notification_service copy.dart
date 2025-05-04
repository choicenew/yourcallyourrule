// 通知服务基类，用于处理应用内通知

/// 通知服务接口
abstract class NotificationService {
  /// 显示通知
  /// [title] 通知标题
  /// [body] 通知内容
  /// [channelId] 通知渠道ID
  /// [notificationId] 通知ID，用于更新或取消通知
  /// [payload] 通知负载，可用于点击通知时传递数据
  Future<void> showNotification({
    required String title,
    required String body,
    required String channelId,
    int notificationId = 0,
    Map<String, dynamic>? payload,
  });

  /// 显示带有动作按钮的通知
  /// [title] 通知标题
  /// [body] 通知内容
  /// [channelId] 通知渠道ID
  /// [notificationId] 通知ID，用于更新或取消通知
  /// [actions] 通知动作列表
  /// [payload] 通知负载，可用于点击通知时传递数据
  Future<void> showNotificationWithActions({
    required String title,
    required String body,
    required String channelId,
    required List<NotificationAction> actions,
    int notificationId = 0,
    Map<String, dynamic>? payload,
  });

  /// 取消通知
  /// [notificationId] 通知ID
  Future<void> cancelNotification(int notificationId);

  /// 取消所有通知
  Future<void> cancelAllNotifications();

  /// 创建通知渠道（仅Android 8.0及以上需要）
  /// [channelId] 渠道ID
  /// [channelName] 渠道名称
  /// [channelDescription] 渠道描述
  /// [importance] 重要性级别
  Future<void> createNotificationChannel({
    required String channelId,
    required String channelName,
    required String channelDescription,
    required NotificationImportance importance,
  });

  /// 检查通知权限
  Future<bool> checkNotificationPermission();

  /// 请求通知权限
  Future<bool> requestNotificationPermission();

  /// 打开通知设置
  Future<void> openNotificationSettings();

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