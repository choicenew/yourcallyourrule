import 'package:flutter/foundation.dart';
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
      // --- 【修改】1. 从 arguments 中提取时间戳 ---
    // 这个时间戳可能在 'onIncomingCall', 'onCallAnswered', 'onCallEnded', 'onOutgoingCall' 中存在
    final int? timestamp = (call.arguments is Map) ? call.arguments['timestamp'] as int? : null;

    switch (call.method) {
      case "onCallerIdInitializationComplete":
        return await _handleInitializationComplete();
      case 'onIncomingCall':
         // --- 【修改】2. 将时间戳传递给处理函数 ---
         debugPrint("onIncomingCall-timestamp: $timestamp");
        return await _handleIncomingCall(call.arguments['phoneNumber'], timestamp);
      case 'onCallEnded':
         // --- 【修改】3. 将时间戳传递给处理函数 ---
         debugPrint("onCallEnded-timestamp: $timestamp");
        return _handleCallEnded(timestamp);
      // --- 【新增】4. 添加 onCallAnswered 的处理 case ---
      case 'onCallAnswered':
      debugPrint("onCallAnswered-timestamp: $timestamp");
        return _handleCallAnswered(timestamp);
      case 'onOutgoingCall':
       // --- 【修改】5. 将时间戳传递给处理函数 ---
        return await _handleOutgoingCall(call.arguments['phoneNumber'], timestamp);
      default:
        throw UnimplementedError('未实现的方法: ${call.method}');
    }
  }

  /// 处理初始化完成
  Future<void> _handleInitializationComplete() async {
    await _channelManager.initializeCallerId();
  }

  /// 处理来电
  // --- 【修改】6. _handleIncomingCall 函数增加 timestamp 参数 ---
  Future<void> _handleIncomingCall(String phoneNumber, int? timestamp) async {
    // 原有逻辑不变，只是现在可以利用时间戳（如果需要的话）
    // 目前的 processIncomingCall 不需要时间戳，所以直接调用
    // 使用新的处理器
    await _incomingCallHandler.processIncomingCall(phoneNumber, _onCallerIdDataReceived);
  }

  /// 处理通话结束
   // --- 【修改】7. _handleCallEnded 函数增加 timestamp 参数 ---
  void _handleCallEnded(int? timestamp) {
    // 通话结束处理
    // 原有逻辑 "不再需要处理通话结束" 保持不变
    // 这个事件现在由 CallerIdMonitorService 直接广播出去，由 CallEventListenerService 监听
    // 通话结束处理
    // 不再需要处理通话结束
  }

  // --- 【新增】8. 新增 _handleCallAnswered 函数 ---
  /// 处理通话被接听
  void _handleCallAnswered(int? timestamp) {
    // 通话接听处理
    // 同样，这个事件也只是被广播出去，由 CallEventListenerService 监听
  }

  /// 处理去电
  // --- 【修改】9. _handleOutgoingCall 函数增加 timestamp 参数 ---
  Future<void> _handleOutgoingCall(String phoneNumber, int? timestamp) async {
    // 使用新的处理器
    await _outgoingCallHandler.processOutgoingCall(phoneNumber, _onCallerIdDataReceived);
  }
}