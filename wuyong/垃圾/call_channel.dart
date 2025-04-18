import 'package:flutter/services.dart';

import '../../lib/common/error/exceptions.dart';

/// Android call platform channel
class AndroidCallChannel {
  // Channels compatible with original code
  static const MethodChannel _callerIdChannel = MethodChannel('com.yours.yourcallyourrule/caller_id');
  static const MethodChannel _endCallChannel = MethodChannel('com.yours.yourcallyourrule/end_call');
  static const MethodChannel _shouldAcceptCallChannel = MethodChannel('com.yours.yourcallyourrule/should_accept_call');
  static const MethodChannel _stirChannel = MethodChannel('com.yours.yourcallyourrule/stir_check');
  static const MethodChannel _simChannel = MethodChannel('com.yours.yourcallyourrule/sim_check');
  
  // Channel for new architecture
  static const MethodChannel _channel = MethodChannel('com.yourcallyourrule.app/call');

  const AndroidCallChannel._();

  // Callback function type definitions
  static Function(MethodCall)? onCallerIdCall;
  static Function(MethodCall)? onStirCall;
  static Function(MethodCall)? onSimCall;
  static Future<bool> Function(MethodCall)? onShouldAcceptCallCall;
  static Future<String?> Function(MethodCall)? onEndCallCall;

  /// Initialize all channels
  static Future<void> initialize() async {
    _setupCallerIdChannel();
    _setupShouldAcceptCallChannel();
    _setupEndCallChannel();
    _setupStirChannel();
    _setupSimChannel();
  }

  /// Set up caller ID channel
  static void _setupCallerIdChannel() {
    _callerIdChannel.setMethodCallHandler((call) async {
      onCallerIdCall?.call(call);
      return null;
    });
  }

  /// Set up should accept call channel
  static void _setupShouldAcceptCallChannel() {
    _shouldAcceptCallChannel.setMethodCallHandler((call) async {
      if (onShouldAcceptCallCall != null) {
        return await onShouldAcceptCallCall!(call);
      }
      return true; // Default return
    });
  }

  /// Set up end call channel
  static void _setupEndCallChannel() {
    _endCallChannel.setMethodCallHandler((call) async {
      if (onEndCallCall != null) {
        return await onEndCallCall!(call);
      }
      return null; // Default return
    });
  }

  /// Set up STIR verification channel
  static void _setupStirChannel() {
    _stirChannel.setMethodCallHandler((call) async {
      onStirCall?.call(call);
      return null;
    });
  }

  /// Set up SIM info channel
  static void _setupSimChannel() {
    _simChannel.setMethodCallHandler((call) async {
      onSimCall?.call(call);
      return null;
    });
  }

  /// Initialize caller ID service
  static Future<void> initializeCallerId() async {
    try {
      await _callerIdChannel.invokeMethod('initialize');
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to initialize caller ID service: ${e.message}', code: e.code);
    }
  }

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

  /// Redirect incoming call
  static Future<bool> redirectIncomingCall(String phoneNumber, String redirectTo) async {
    try {
      final result = await _channel.invokeMethod('redirectIncomingCall', {
        'phoneNumber': phoneNumber,
        'redirectTo': redirectTo
      });
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to redirect call: ${e.message}', code: e.code);
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