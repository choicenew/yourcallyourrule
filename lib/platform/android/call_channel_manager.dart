import 'package:flutter/services.dart';
import 'package:yourcallyourrule/features/common/error/logger.dart';
import '../call_channel_switcher.dart';

class AndroidCallChannelManager implements CallChannelInterface {
  static final AndroidCallChannelManager _instance = AndroidCallChannelManager._internal();
  factory AndroidCallChannelManager() => _instance;
  AndroidCallChannelManager._internal();

  static const callerIdChannel = MethodChannel('com.yours.yourcallyourrule/caller_id');
  static const endCallChannel = MethodChannel('com.yours.yourcallyourrule/end_call');
  static const shouldAcceptCallChannel = MethodChannel('com.yours.yourcallyourrule/should_accept_call');
  static const stirChannel = MethodChannel('com.yours.yourcallyourrule/stir_check');
  static const simChannel = MethodChannel('com.yours.yourcallyourrule/sim_check');
  static const phoneStateChannel = MethodChannel('com.yours.yourcallyourrule/phone_state');

  @override
  Function(MethodCall)? onCallerIdCall;
  @override
  Function(MethodCall)? onStirCall;
  @override
  Function(MethodCall)? onSimCall;
  @override
  Future<bool> Function(MethodCall)? onShouldAcceptCallCall;
  @override
  Future<String?> Function(MethodCall)? onEndCallCall;

  @override
  void initialize() {
    _setupCallerIdChannel();
    _setupShouldAcceptCallChannel();
    _setupEndCallChannel();
    _setupStirChannel();
    _setupSimChannel();
  }

  void _setupCallerIdChannel() {
    callerIdChannel.setMethodCallHandler((call) async {
      onCallerIdCall?.call(call);
      return null;
    });
  }

  void _setupShouldAcceptCallChannel() {
    shouldAcceptCallChannel.setMethodCallHandler((call) async {
      if (onShouldAcceptCallCall != null) {
        return await onShouldAcceptCallCall!(call);
      }
      return true;
    });
  }

  void _setupEndCallChannel() {
    endCallChannel.setMethodCallHandler((call) async {
      if (onEndCallCall != null) {
        return await onEndCallCall!(call);
      }
      return null;
    });
  }

  void _setupStirChannel() {
    stirChannel.setMethodCallHandler((call) async {
      onStirCall?.call(call);
      return null;
    });
  }

  void _setupSimChannel() {
    simChannel.setMethodCallHandler((call) async {
      onSimCall?.call(call);
      return null;
    });
  }

  @override
  Future<void> initializeCallerId() async {
    try {
      await callerIdChannel.invokeMethod('initialize');
    } catch (e) {
      AppLogger.error('Failed to initialize caller ID service: $e');
    }
  }
}
