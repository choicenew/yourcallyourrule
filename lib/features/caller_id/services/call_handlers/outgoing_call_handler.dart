import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';

import 'caller_id_handler.dart';
import 'caller_id_handler_extension.dart';

/// 去电处理器
/// 专门负责处理去电相关的逻辑
class OutgoingCallHandler {
  final CallHandler _callHandler;
  
  /// 构造函数
  OutgoingCallHandler({
    required CallHandler callHandler,
  }) : _callHandler = callHandler;

  /// 处理去电
  Future<void> processOutgoingCall(String phoneNumber, Function(CallerIdData) onCallerIdDataReceived) async {
    // 处理通话并获取通话数据
    CallData callData = await _callHandler.handleCall(phoneNumber);
    
    // 通知监听器
    onCallerIdDataReceived(callData.callerIdData);
    
    // 记录去电
    this.recordOutgoingCallWithOptionalRecorder(phoneNumber, callData);
  }
}