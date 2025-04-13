import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../error/exceptions.dart';

/// 权限工具类
class PermissionUtils {
  const PermissionUtils._();

  /// 检查电话权限
  static Future<bool> checkPhonePermission() async {
    return await Permission.phone.status.isGranted;
  }

  /// 请求电话权限
  static Future<bool> requestPhonePermission() async {
    final status = await Permission.phone.request();
    return status.isGranted;
  }

  /// 检查短信权限
  static Future<bool> checkSmsPermission() async {
    return await Permission.sms.status.isGranted;
  }

  /// 请求短信权限
  static Future<bool> requestSmsPermission() async {
    final status = await Permission.sms.request();
    return status.isGranted;
  }

  /// 检查联系人权限
  static Future<bool> checkContactsPermission() async {
    return await Permission.contacts.status.isGranted;
  }

  /// 请求联系人权限
  static Future<bool> requestContactsPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  /// 检查存储权限
  static Future<bool> checkStoragePermission() async {
    return await Permission.storage.status.isGranted;
  }

  /// 请求存储权限
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// 检查多个权限
  static Future<Map<Permission, PermissionStatus>> checkMultiplePermissions(
      List<Permission> permissions) async {
    return await permissions.request();
  }

  /// 请求多个权限
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
      List<Permission> permissions) async {
    return await permissions.request();
  }

  /// 检查并请求权限，如果未授权则抛出异常
  static Future<void> checkAndRequestPermission(Permission permission, String permissionName) async {
    final isGranted = await permission.status.isGranted;
    if (!isGranted) {
      final status = await permission.request();
      if (!status.isGranted) {
        throw PermissionException('$permissionName权限被拒绝');
      }
    }
  }

  /// 打开应用设置
  static Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  /// 获取权限状态描述
  static String getPermissionStatusDescription(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        return '已拒绝';
      case PermissionStatus.granted:
        return '已授予';
      case PermissionStatus.restricted:
        return '受限制';
      case PermissionStatus.limited:
        return '有限制';
      case PermissionStatus.permanentlyDenied:
        return '永久拒绝';
      default:
        return '未知状态';
    }
  }
}