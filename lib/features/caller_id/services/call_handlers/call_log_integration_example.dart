import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler_extension.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/incoming_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/outgoing_call_handler.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 通话记录集成示例
/// 本文件展示如何在现有代码中集成 CallLogRecorder
/// 注意：这只是一个示例，不应该直接使用
class CallLogIntegrationExample {
  final CallHandler _callHandler;
  final IncomingCallHandler _incomingCallHandler;
  final OutgoingCallHandler _outgoingCallHandler;
  final CallLogRecorder _callLogRecorder;
   final PredefinedLabelService _predefinedLabelService;

  CallLogIntegrationExample({
    required CallHandler callHandler,
    required IncomingCallHandler incomingCallHandler,
    required OutgoingCallHandler outgoingCallHandler,
    required CallLogService callLogService,
    required PredefinedLabelService predefinedLabelService
  }) : 
    _callHandler = callHandler,
    _incomingCallHandler = incomingCallHandler,
    _outgoingCallHandler = outgoingCallHandler,
    _predefinedLabelService = predefinedLabelService,
    _callLogRecorder = CallLogRecorder(callLogService, predefinedLabelService);
  
  /// 处理来电示例
  /// 
  /// [phoneNumber] 电话号码
  /// [simInfo] SIM卡信息（可选）
  /// [accepted] 是否接听来电
  /// 
  /// 通话类型设置：
  /// - 如果accepted为true，通话类型将被设置为'incoming'
  /// - 如果accepted为false，通话类型将被设置为'missed'
  Future<void> handleIncomingCall(String phoneNumber, {SimInfo? simInfo, bool accepted = true}) async {
    // 处理通话并获取通话数据
    CallData callData = await _callHandler.handleCall(phoneNumber);
    
    // 通知监听器（原有逻辑）
    final onCallerIdDataReceived = (CallerIdData data) {
      // 原有的回调处理逻辑
    };
    onCallerIdDataReceived(callData.callerIdData);
    
    // 使用扩展方法保存通话记录和缓存数据
    await _callHandler.saveCallerIdDataWithCallLog(
      phoneNumber, 
      callData, 
      _callLogRecorder,
      isIncoming: true,
      accepted: accepted
    );
    
    // 继续原有的来电处理逻辑...
  }
  
  /// 处理去电示例
  /// 
  /// [phoneNumber] 电话号码
  /// 
  /// 通话类型将被设置为'outgoing'
  Future<void> handleOutgoingCall(String phoneNumber) async {
    // 处理通话并获取通话数据
    CallData callData = await _callHandler.handleCall(phoneNumber);
    
    // 通知监听器（原有逻辑）
    final onCallerIdDataReceived = (CallerIdData data) {
      // 原有的回调处理逻辑
    };
    onCallerIdDataReceived(callData.callerIdData);
    
    // 使用扩展方法保存通话记录和缓存数据
    await _callHandler.saveCallerIdDataWithCallLog(
      phoneNumber, 
      callData, 
      _callLogRecorder,
      isIncoming: false
    );
    
    // 继续原有的去电处理逻辑...
  }
  
  /// 处理拒接来电示例
  /// 
  /// [phoneNumber] 电话号码
  /// 
  /// 通话类型将被设置为'rejected'
  Future<void> handleRejectedCall(String phoneNumber) async {
    // 处理通话并获取通话数据
    CallData callData = await _callHandler.handleCall(phoneNumber);
    
    // 使用扩展方法保存通话记录
    await _incomingCallHandler.recordRejectedCall(phoneNumber, callData, _callLogRecorder);
    
    // 继续原有的拒接处理逻辑...
  }
  
  /// 处理拦截来电示例
  /// 
  /// [phoneNumber] 电话号码
  /// 
  /// 通话类型将被设置为'blocked'
  Future<void> handleBlockedCall(String phoneNumber) async {
    // 处理通话并获取通话数据
    CallData callData = await _callHandler.handleCall(phoneNumber);
    
    // 使用扩展方法保存通话记录
    await _incomingCallHandler.recordBlockedCall(phoneNumber, callData, _callLogRecorder);
    
    // 继续原有的拦截处理逻辑...
  }
}