import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/services/permission_service.dart';
import 'package:yourcallyourrule/core/services/permission_service_impl.dart';

/// permissionServiceProvider
/// 提供PermissionService的实例
final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionServiceImpl();
});