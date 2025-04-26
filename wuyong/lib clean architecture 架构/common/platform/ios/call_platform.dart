import 'package:flutter/services.dart';

import '../../error/exceptions.dart';

/// iOS call platform interface
class IOSCallPlatform {
  static const MethodChannel _channel = MethodChannel('com.yourcallyourrule.app/call_ios');

  const IOSCallPlatform._();

  /// Get call logs
  static Future<List<Map<String, dynamic>>> getCallLogs({int? limit}) async {
    try {
      final result = await _channel.invokeMethod('getCallLogs', {'limit': limit});
      return List<Map<String, dynamic>>.from(result ?? []);
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to get call logs: ${e.message}', code: e.code);
    }
  }

  /// Block incoming call
  static Future<bool> blockIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('blockIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to block call: ${e.message}', code: e.code);
    }
  }

  /// Allow incoming call
  static Future<bool> allowIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('allowIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to allow call: ${e.message}', code: e.code);
    }
  }

  /// Silent incoming call
  static Future<bool> silentIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('silentIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to silent call: ${e.message}', code: e.code);
    }
  }

  /// Register call listener
  static Future<bool> registerCallListener() async {
    try {
      final result = await _channel.invokeMethod('registerCallListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to register call listener: ${e.message}', code: e.code);
    }
  }

  /// Unregister call listener
  static Future<bool> unregisterCallListener() async {
    try {
      final result = await _channel.invokeMethod('unregisterCallListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to unregister call listener: ${e.message}', code: e.code);
    }
  }

  /// Check call permission
  static Future<bool> checkCallPermission() async {
    try {
      final result = await _channel.invokeMethod('checkCallPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to check call permission: ${e.message}', code: e.code);
    }
  }

  /// Request call permission
  static Future<bool> requestCallPermission() async {
    try {
      final result = await _channel.invokeMethod('requestCallPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to request call permission: ${e.message}', code: e.code);
    }
  }
}