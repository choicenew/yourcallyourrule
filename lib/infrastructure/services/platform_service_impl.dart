import 'package:flutter/services.dart';

import '../../common/utils/permission_utils.dart';
import '../base_service_impl.dart';

/// 平台服务实现
/// 负责处理与平台相关的功能，如权限请求和系统设置
class PlatformServiceImpl extends BaseServiceImpl {
  static const platform = MethodChannel('com.yourcallyourrule/platform');
  
  final PermissionUtils _permissionUtils;
  
  PlatformServiceImpl(this._permissionUtils);
  
  /// 请求通话权限
  Future<bool> requestCallPermission() async {
    return await _permissionUtils.requestCallPermission();
  }
  
  /// 请求短信权限
  Future<bool> requestSmsPermission() async {
    return await _permissionUtils.requestSmsPermission();
  }
  
  /// 请求联系人权限
  Future<bool> requestContactPermission() async {
    return await _permissionUtils.requestContactPermission();
  }
  
  /// 检查是否为默认电话应用
  Future<bool> isDefaultPhoneApp() async {
    try {
      final result = await platform.invokeMethod<bool>('isDefaultPhoneApp');
      return result ?? false;
    } on PlatformException catch (e) {
      logOperation('检查默认电话应用失败', details: e.message);
      return false;
    }
  }
  
  /// 请求设置为默认电话应用
  Future<void> requestDefaultPhoneApp() async {
    try {
      await platform.invokeMethod('requestDefaultPhoneApp');
    } on PlatformException catch (e) {
      logOperation('请求设置默认电话应用失败', details: e.message);
      rethrow;
    }
  }
  
  /// 检查是否为默认短信应用
  Future<bool> isDefaultSmsApp() async {
    try {
      final result = await platform.invokeMethod<bool>('isDefaultSmsApp');
      return result ?? false;
    } on PlatformException catch (e) {
      logOperation('检查默认短信应用失败', details: e.message);
      return false;
    }
  }
  
  /// 请求设置为默认短信应用
  Future<void> requestDefaultSmsApp() async {
    try {
      await platform.invokeMethod('requestDefaultSmsApp');
    } on PlatformException catch (e) {
      logOperation('请求设置默认短信应用失败', details: e.message);
      rethrow;
    }
  }
}