import 'package:flutter/services.dart';

import '../../../common/error/exceptions.dart';

/// Android平台短信通道
class AndroidSmsChannel {
  static const MethodChannel _channel = MethodChannel('com.yourcallyourrule.app/sms');

  const AndroidSmsChannel._();

  /// 获取短信记录
  static Future<List<Map<String, dynamic>>> getSmsMessages({int? limit}) async {
    try {
      final result = await _channel.invokeMethod('getSmsMessages', {'limit': limit});
      return List<Map<String, dynamic>>.from(result ?? []);
    } on PlatformException catch (e) {
      throw PlatformException('获取短信记录失败: ${e.message}', code: e.code);
    }
  }

  /// 拦截短信
  static Future<bool> blockIncomingSms(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('blockIncomingSms', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('拦截短信失败: ${e.message}', code: e.code);
    }
  }

  /// 允许短信
  static Future<bool> allowIncomingSms(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('allowIncomingSms', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('允许短信失败: ${e.message}', code: e.code);
    }
  }

  /// 发送短信
  static Future<bool> sendSms(String phoneNumber, String message) async {
    try {
      final result = await _channel.invokeMethod('sendSms', {
        'phoneNumber': phoneNumber,
        'message': message
      });
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('发送短信失败: ${e.message}', code: e.code);
    }
  }

  /// 注册短信监听器
  static Future<bool> registerSmsListener() async {
    try {
      final result = await _channel.invokeMethod('registerSmsListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('注册短信监听器失败: ${e.message}', code: e.code);
    }
  }

  /// 取消注册短信监听器
  static Future<bool> unregisterSmsListener() async {
    try {
      final result = await _channel.invokeMethod('unregisterSmsListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('取消注册短信监听器失败: ${e.message}', code: e.code);
    }
  }

  /// 检查短信权限
  static Future<bool> checkSmsPermission() async {
    try {
      final result = await _channel.invokeMethod('checkSmsPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('检查短信权限失败: ${e.message}', code: e.code);
    }
  }

  /// 请求短信权限
  static Future<bool> requestSmsPermission() async {
    try {
      final result = await _channel.invokeMethod('requestSmsPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('请求短信权限失败: ${e.message}', code: e.code);
    }
  }

  /// 过滤短信内容
  static Future<bool> filterSmsContent(String phoneNumber, String content) async {
    try {
      final result = await _channel.invokeMethod('filterSmsContent', {
        'phoneNumber': phoneNumber,
        'content': content
      });
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('过滤短信内容失败: ${e.message}', code: e.code);
    }
  }
}