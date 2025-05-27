import 'package:flutter/services.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/platform/call_channel_switcher.dart';

import 'base_call_handler.dart';
import 'incoming_call_handler.dart';
import 'outgoing_call_handler.dart';

/// 来电显示调用处理器
/// 负责处理与来电显示相关的方法调用
class CallEventHandler extends BaseCallHandler {
  final CallChannelInterface _channelManager;
  final IncomingCallHandler _incomingCallHandler;
  final OutgoingCallHandler _outgoingCallHandler;
  final Function(CallerIdData) _onCallerIdDataReceived;
  
  CallEventHandler(
    this._channelManager,
    dynamic _, {
    required IncomingCallHandler incomingCallHandler, // Add required keyword
    required OutgoingCallHandler outgoingCallHandler, // Add required keyword
    Function(CallerIdData)? onCallerIdDataReceived,
  }) : 
    _incomingCallHandler = incomingCallHandler,
    _outgoingCallHandler = outgoingCallHandler,
    _onCallerIdDataReceived = onCallerIdDataReceived ?? ((data) {});

  @override
  dynamic handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onCallerIdInitializationComplete":
        return await _handleInitializationComplete();
      case 'onIncomingCall':
        return await _handleIncomingCall(call.arguments['phoneNumber']);
      case 'onCallEnded':
        return _handleCallEnded();
      case 'onOutgoingCall':
        return await _handleOutgoingCall(call.arguments['phoneNumber']);
      default:
        throw UnimplementedError('未实现的方法: ${call.method}');
    }
  }

  /// 处理初始化完成
  Future<void> _handleInitializationComplete() async {
    await _channelManager.initializeCallerId();
  }

  /// 处理来电
  Future<void> _handleIncomingCall(String phoneNumber) async {
    // 使用新的处理器
    await _incomingCallHandler.processIncomingCall(phoneNumber, _onCallerIdDataReceived);
  }

  /// 处理通话结束
  void _handleCallEnded() {
    // 通话结束处理
    // 不再需要处理通话结束
  }

  /// 处理去电
  Future<void> _handleOutgoingCall(String phoneNumber) async {
    // 使用新的处理器
    await _outgoingCallHandler.processOutgoingCall(phoneNumber, _onCallerIdDataReceived);
  }
}