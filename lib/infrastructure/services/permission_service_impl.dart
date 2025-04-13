import 'package:permission_handler/permission_handler.dart';

import '../base_service_impl.dart';

/// 权限服务实现
/// 负责处理应用所需的各种权限
class PermissionServiceImpl extends BaseServiceImpl {
  /// 请求电话权限
  Future<bool> requestPhonePermission() async {
    final status = await Permission.phone.request();
    logOperation('请求电话权限', details: 'Status: ${status.toString()}');
    return status.isGranted;
  }
  
  /// 请求通讯录权限
  Future<bool> requestContactsPermission() async {
    final status = await Permission.contacts.request();
    logOperation('请求通讯录权限', details: 'Status: ${status.toString()}');
    return status.isGranted;
  }
  
  /// 请求短信权限
  Future<bool> requestSmsPermission() async {
    final status = await Permission.sms.request();
    logOperation('请求短信权限', details: 'Status: ${status.toString()}');
    return status.isGranted;
  }
  
  /// 请求通知权限
  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    logOperation('请求通知权限', details: 'Status: ${status.toString()}');
    return status.isGranted;
  }
  
  /// 请求存储权限
  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    logOperation('请求存储权限', details: 'Status: ${status.toString()}');
    return status.isGranted;
  }
  
  /// 检查电话权限
  Future<bool> hasPhonePermission() async {
    return await Permission.phone.isGranted;
  }
  
  /// 检查通讯录权限
  Future<bool> hasContactsPermission() async {
    return await Permission.contacts.isGranted;
  }
  
  /// 检查短信权限
  Future<bool> hasSmsPermission() async {
    return await Permission.sms.isGranted;
  }
  
  /// 检查通知权限
  Future<bool> hasNotificationPermission() async {
    return await Permission.notification.isGranted;
  }
  
  /// 检查存储权限
  Future<bool> hasStoragePermission() async {
    return await Permission.storage.isGranted;
  }
  
  /// 打开应用设置
  Future<void> openAppSettings() async {
    await openAppSettings();
    logOperation('打开应用设置');
  }
}