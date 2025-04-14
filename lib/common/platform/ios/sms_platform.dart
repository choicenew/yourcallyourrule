import 'package:flutter/services.dart';

import '../../../common/error/exceptions.dart';

/// iOS SMS platform interface
class IOSSmsPlatform {
  static const MethodChannel _channel = MethodChannel('com.yourcallyourrule.app/sms_ios');

  const IOSSmsPlatform._();

  /// Get SMS messages
  static Future<List<Map<String, dynamic>>> getSmsMessages({int? limit}) async {
    try {
      final result = await _channel.invokeMethod('getSmsMessages', {'limit': limit});
      return List<Map<String, dynamic>>.from(result ?? []);
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to get SMS messages: ${e.message}', code: e.code);
    }
  }

  /// Block incoming SMS
  static Future<bool> blockIncomingSms(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('blockIncomingSms', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to block SMS: ${e.message}', code: e.code);
    }
  }

  /// Allow incoming SMS
  static Future<bool> allowIncomingSms(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('allowIncomingSms', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to allow SMS: ${e.message}', code: e.code);
    }
  }

  /// Send SMS
  static Future<bool> sendSms(String phoneNumber, String message) async {
    try {
      final result = await _channel.invokeMethod('sendSms', {
        'phoneNumber': phoneNumber,
        'message': message
      });
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to send SMS: ${e.message}', code: e.code);
    }
  }

  /// Register SMS listener
  static Future<bool> registerSmsListener() async {
    try {
      final result = await _channel.invokeMethod('registerSmsListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to register SMS listener: ${e.message}', code: e.code);
    }
  }

  /// Unregister SMS listener
  static Future<bool> unregisterSmsListener() async {
    try {
      final result = await _channel.invokeMethod('unregisterSmsListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to unregister SMS listener: ${e.message}', code: e.code);
    }
  }

  /// Check SMS permission
  static Future<bool> checkSmsPermission() async {
    try {
      final result = await _channel.invokeMethod('checkSmsPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to check SMS permission: ${e.message}', code: e.code);
    }
  }

  /// Request SMS permission
  static Future<bool> requestSmsPermission() async {
    try {
      final result = await _channel.invokeMethod('requestSmsPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to request SMS permission: ${e.message}', code: e.code);
    }
  }
}