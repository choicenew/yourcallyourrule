import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler show openAppSettings;
import 'package:yourcallyourrule/core/services/permission_service.dart';

/// PermissionService的具体实现类
class PermissionServiceImpl implements PermissionService {
  final Map<String, Permission> _stringToPermission = {
    'call': Permission.phone,
    'sms': Permission.sms,
    'contacts': Permission.contacts,
    'storage': Permission.storage,
    'overlay': Permission.systemAlertWindow,
    'notification': Permission.notification,
  };

  Permission _getPermission(String permission) {
    return _stringToPermission[permission] ?? Permission.unknown;
  }

  @override
  Future<bool> hasPermission(String permission) async {
    final p = _getPermission(permission);
    if (p == Permission.unknown) return false;
    return await p.isGranted;
  }

  @override
  Future<bool> requestPermission(String permission) async {
    final p = _getPermission(permission);
    if (p == Permission.unknown) return false;
    final status = await p.request();
    return status.isGranted;
  }

  @override
  Future<Map<String, bool>> requestPermissions(List<String> permissions) async {
    final Map<String, bool> results = {};
    final List<Permission> permsToRequest = [];
    for (var pStr in permissions) {
      final p = _getPermission(pStr);
      if (p != Permission.unknown) {
        permsToRequest.add(p);
      }
    }

    if (permsToRequest.isNotEmpty) {
      final statuses = await permsToRequest.request();
      statuses.forEach((p, status) {
        final pStr = _stringToPermission.entries.firstWhere((e) => e.value == p, orElse: () => const MapEntry('', Permission.unknown)).key;
        if (pStr.isNotEmpty) {
          results[pStr] = status.isGranted;
        }
      });
    }
    
    return results;
  }

  @override
  Future<void> openAppSettings() async {
    await permission_handler.openAppSettings();
  }

  @override
  Future<bool> hasCallPermission() => hasPermission('call');

  @override
  Future<bool> requestCallPermission() => requestPermission('call');

  @override
  Future<bool> hasSmsPermission() => hasPermission('sms');

  @override
  Future<bool> requestSmsPermission() => requestPermission('sms');

  @override
  Future<bool> hasContactsPermission() => hasPermission('contacts');

  @override
  Future<bool> requestContactsPermission() => requestPermission('contacts');

  @override
  Future<bool> hasStoragePermission() => hasPermission('storage');

  @override
  Future<bool> requestStoragePermission() => requestPermission('storage');

  @override
  Future<bool> hasOverlayPermission() => hasPermission('overlay');

  @override
  Future<bool> requestOverlayPermission() => requestPermission('overlay');

  @override
  Future<bool> hasNotificationPermission() => hasPermission('notification');

  @override
  Future<bool> requestNotificationPermission() => requestPermission('notification');
}

/// permissionServiceProvider
/// 提供PermissionService的实例
final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionServiceImpl();
});