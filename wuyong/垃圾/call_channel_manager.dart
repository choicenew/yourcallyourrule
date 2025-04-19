import 'package:flutter/services.dart';

import '../../lib clean architecture 架构/common/error/exceptions.dart';

/// Call Channel Manager
/// Manages method channels for call-related functionality
class CallChannelManager {
  // Method channels for different call functionalities
  static const MethodChannel callerIdChannel = MethodChannel('com.yours.yourcallyourrule/caller_id');
  static const MethodChannel endCallChannel = MethodChannel('com.yours.yourcallyourrule/end_call');
  static const MethodChannel shouldAcceptCallChannel = MethodChannel('com.yours.yourcallyourrule/should_accept_call');
  static const MethodChannel stirChannel = MethodChannel('com.yours.yourcallyourrule/stir_check');
  static const MethodChannel simChannel = MethodChannel('com.yours.yourcallyourrule/sim_check');

  // Callback function definitions
  Function(MethodCall)? onCallerIdCall;
  Function(MethodCall)? onStirCall;
  Function(MethodCall)? onSimCall;
  Future<bool> Function(MethodCall)? onShouldAcceptCallCall;
  Future<String?> Function(MethodCall)? onEndCallCall;

  /// Initialize all method channels
  void initialize() {
    _setupCallerIdChannel();
    _setupShouldAcceptCallChannel();
    _setupEndCallChannel();
    _setupStirChannel();
    _setupSimChannel();
  }

  /// Set up caller ID channel
  void _setupCallerIdChannel() {
    callerIdChannel.setMethodCallHandler((call) async {
      onCallerIdCall?.call(call);
      return null;
    });
  }

  /// Set up should accept call channel
  void _setupShouldAcceptCallChannel() {
    shouldAcceptCallChannel.setMethodCallHandler((call) async {
      if (onShouldAcceptCallCall != null) {
        return await onShouldAcceptCallCall!(call);
      }
      return true; // Default return
    });
  }

  /// Set up end call channel
  void _setupEndCallChannel() {
    endCallChannel.setMethodCallHandler((call) async {
      if (onEndCallCall != null) {
        return await onEndCallCall!(call);
      }
      return null; // Default return
    });
  }

  /// Set up STIR verification channel
  void _setupStirChannel() {
    stirChannel.setMethodCallHandler((call) async {
      onStirCall?.call(call);
      return null;
    });
  }

  /// Set up SIM info channel
  void _setupSimChannel() {
    simChannel.setMethodCallHandler((call) async {
      onSimCall?.call(call);
      return null;
    });
  }

  /// Initialize caller ID service
  Future<void> initializeCallerId() async {
    try {
      await callerIdChannel.invokeMethod('initialize');
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to initialize caller ID service: ${e.message}', code: e.code);
    }
  }

  /// Block incoming call
  Future<bool> blockIncomingCall(String phoneNumber) async {
    try {
      final result = await endCallChannel.invokeMethod('blockIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to block call: ${e.message}', code: e.code);
    }
  }

  /// Allow incoming call
  Future<bool> allowIncomingCall(String phoneNumber) async {
    try {
      final result = await endCallChannel.invokeMethod('allowIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to allow call: ${e.message}', code: e.code);
    }
  }

  /// Silent incoming call
  Future<bool> silentIncomingCall(String phoneNumber) async {
    try {
      final result = await endCallChannel.invokeMethod('silentIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to silent call: ${e.message}', code: e.code);
    }
  }

  /// Redirect incoming call
  Future<bool> redirectIncomingCall(String phoneNumber, String redirectTo) async {
    try {
      final result = await endCallChannel.invokeMethod('redirectIncomingCall', {
        'phoneNumber': phoneNumber,
        'redirectTo': redirectTo
      });
      return result ?? false;
    } on PlatformException catch (e) {
      throw AppPlatformException('Failed to redirect call: ${e.message}', code: e.code);
    }
  }
}

/// App Platform Exception
/// Used when platform-specific operations fail
class AppPlatformException implements Exception {
  final String message;
  final String code;

  AppPlatformException(this.message, {required this.code});

  @override
  String toString() => 'AppPlatformException: $message (code: $code)';
}