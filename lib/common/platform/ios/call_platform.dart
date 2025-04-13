import 'package:flutter/services.dart';

import '../../../common/error/exceptions.dart';

/// iOS平台通话接口
class IOSCallPlatform {
  static const MethodChannel _channel = MethodChannel('com.yourcallyourrule.app/call_ios');

  const IOSCallPlatform._();

  /// 获取通话记录
  static Future<List<Map<String, dynamic>>> getCallLogs({int? limit}) async {
    try {
      final result = await _channel.invokeMethod('getCallLogs', {'limit': limit});
      return List<Map<String, dynamic>>.from(result ?? []);
    } on PlatformException catch (e) {
      throw PlatformException('获取通话记录失败: ${e.message}', code: e.code);
    }
  }

  /// 拦截来电
  static Future<bool> blockIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('blockIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('拦截来电失败: ${e.message}', code: e.code);
    }
  }

  /// 允许来电
  static Future<bool> allowIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('allowIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('允许来电失败: ${e.message}', code: e.code);
    }
  }

  /// 静音来电
  static Future<bool> silentIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('silentIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('静音来电失败: ${e.message}', code: e.code);
    }
  }

  /// 注册来电监听器
  static Future<bool> registerCallListener() async {
    try {
      final result = await _channel.invokeMethod('registerCallListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('注册来电监听器失败: ${e.message}', code: e.code);
    }
  }

  /// 取消注册来电监听器
  static Future<bool> unregisterCallListener() async {
    try {
      final result = await _channel.invokeMethod('unregisterCallListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('取消注册来电监听器失败: ${e.message}', code: e.code);
    }
  }

  /// 检查通话权限
  static Future<bool> checkCallPermission() async {
    try {
      final result = await _channel.invokeMethod('checkCallPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('检查通话权限失败: ${e.message}', code: e.code);
    }
  }

  /// 请求通话权限
  static Future<bool> requestCallPermission() async {
    try {
      final result = await _channel.invokeMethod('requestCallPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('请求通话权限失败: ${e.message}', code: e.code);
    }
  }
}