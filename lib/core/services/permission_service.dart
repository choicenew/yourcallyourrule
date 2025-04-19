// 权限服务，用于处理应用权限

/// 权限服务接口
abstract class PermissionService {
  /// 检查权限是否已授予
  /// [permission] 权限名称
  Future<bool> hasPermission(String permission);

  /// 请求权限
  /// [permission] 权限名称
  /// 返回是否授予了权限
  Future<bool> requestPermission(String permission);

  /// 请求多个权限
  /// [permissions] 权限名称列表
  /// 返回每个权限是否授予的映射
  Future<Map<String, bool>> requestPermissions(List<String> permissions);

  /// 打开应用设置页面
  Future<void> openAppSettings();

  /// 检查是否有通话权限
  Future<bool> hasCallPermission() => hasPermission('call');

  /// 请求通话权限
  Future<bool> requestCallPermission() => requestPermission('call');

  /// 检查是否有短信权限
  Future<bool> hasSmsPermission() => hasPermission('sms');

  /// 请求短信权限
  Future<bool> requestSmsPermission() => requestPermission('sms');

  /// 检查是否有联系人权限
  Future<bool> hasContactsPermission() => hasPermission('contacts');

  /// 请求联系人权限
  Future<bool> requestContactsPermission() => requestPermission('contacts');

  /// 检查是否有存储权限
  Future<bool> hasStoragePermission() => hasPermission('storage');

  /// 请求存储权限
  Future<bool> requestStoragePermission() => requestPermission('storage');

  /// 检查是否有悬浮窗权限
  Future<bool> hasOverlayPermission() => hasPermission('overlay');

  /// 请求悬浮窗权限
  Future<bool> requestOverlayPermission() => requestPermission('overlay');

  /// 检查是否有通知权限
  Future<bool> hasNotificationPermission() => hasPermission('notification');

  /// 请求通知权限
  Future<bool> requestNotificationPermission() => requestPermission('notification');
}