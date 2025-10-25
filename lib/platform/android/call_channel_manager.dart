import 'package:flutter/services.dart';
import 'package:yourcallyourrule/common/error/logger.dart';


import '../call_channel_switcher.dart';


/// Android平台的通话通道管理器实现
class AndroidCallChannelManager implements CallChannelInterface {
  // 单例模式
  static final AndroidCallChannelManager _instance = AndroidCallChannelManager._internal();
  factory AndroidCallChannelManager() => _instance;
  AndroidCallChannelManager._internal();

  // 通道定义
  static const callerIdChannel = MethodChannel('com.yours.yourcallyourrule/caller_id');
  static const endCallChannel = MethodChannel('com.yours.yourcallyourrule/end_call');
  static const shouldAcceptCallChannel = MethodChannel('com.yours.yourcallyourrule/should_accept_call');
  static const stirChannel = MethodChannel('com.yours.yourcallyourrule/stir_check');
  static const simChannel = MethodChannel('com.yours.yourcallyourrule/sim_check');
  // ✅ 1. 定义新的 phone_state Channel
  static const phoneStateChannel = MethodChannel('com.yours.yourcallyourrule/phone_state');

  // 回调函数
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
      return true; // 默认返回
    });
  }

  void _setupEndCallChannel() {
    endCallChannel.setMethodCallHandler((call) async {
      if (onEndCallCall != null) {
        return await onEndCallCall!(call);
      }
      return null; // 默认返回
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
       AppLogger.error('初始化来电显示服务失败', e);
      
    }
  }
}