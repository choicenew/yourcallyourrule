import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/end_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/incoming_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/outgoing_call_handler.dart';

/// 扩展 CallHandler 类，添加通话记录功能
extension CallHandlerExtension on CallHandler {
  /// 使用 CallLogRecorder 保存通话记录
  /// 这个方法应该被调用来替代原始的 saveCallerIdDataToCache 方法
  /// 
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [recorder] CallLogRecorder 实例
  /// [isIncoming] 是否为来电，true表示来电，false表示去电
  /// [accepted] 仅当isIncoming=true时有效，表示是否接听来电
  ///   - 当isIncoming=true且accepted=true时，callType设置为'incoming'
  ///   - 当isIncoming=true且accepted=false时，callType设置为'missed'
  ///   - 当isIncoming=false时，callType设置为'outgoing'
  Future<void> saveCallerIdDataWithCallLog(
      String phoneNumber, CallData callData, CallLogRecorder recorder, {bool isIncoming = true, bool accepted = false}) async {
    // 首先调用原始的缓存保存方法
    await saveCallerIdDataToCache(phoneNumber, callData);
    
    // 然后根据通话类型使用 CallLogRecorder 记录通话
    if (isIncoming) {
      // 如果是来电，根据是否接听决定记录类型
      await recorder.recordIncomingCall(phoneNumber, callData, accepted);
    } else {
      // 如果是去电
      await recorder.recordOutgoingCall(phoneNumber, callData);
    }
  }
}

/// 来电处理扩展
extension IncomingCallHandlerExtension on IncomingCallHandler {
  /// 使用 CallLogRecorder 记录来电
  /// 
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [accepted] 是否接听来电
  /// [recorder] CallLogRecorder 实例
  /// 
  /// 注意：accepted参数决定了通话类型是'incoming'还是'missed'
  /// - 当accepted=true时，callType设置为'incoming'
  /// - 当accepted=false时，callType设置为'missed'
  Future<void> recordIncomingCall(
      String phoneNumber, CallData callData, bool accepted, CallLogRecorder recorder) async {
    await recorder.recordIncomingCall(phoneNumber, callData, accepted);
  }
  
  /// 使用 CallLogRecorder 记录拒接来电
  /// 
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [recorder] CallLogRecorder 实例
  /// 
  /// 通话类型将被设置为'rejected'
  Future<void> recordRejectedCall(
      String phoneNumber, CallData callData, CallLogRecorder recorder) async {
    await recorder.recordRejectedCall(phoneNumber, callData);
  }
  
  /// 使用 CallLogRecorder 记录拦截来电
  /// 
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [recorder] CallLogRecorder 实例
  /// 
  /// 通话类型将被设置为'blocked'
  Future<void> recordBlockedCall(
      String phoneNumber, CallData callData, CallLogRecorder recorder) async {
    await recorder.recordBlockedCall(phoneNumber, callData);
  }
  
  /// 记录被阻止的通话，支持可选的 CallLogRecorder 参数
  /// 
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [recorder] 可选的 CallLogRecorder 实例
  Future<void> recordBlockedCallWithOptionalRecorder(String phoneNumber, CallData callData, [CallLogRecorder? recorder]) async {
    // 如果提供了 recorder，使用它记录被阻止的通话
    if (recorder != null) {
      await recorder.recordBlockedCall(phoneNumber, callData);
    }
    // 这里可以添加其他记录逻辑，如果需要的话
  }
}

/// 去电处理扩展
extension OutgoingCallHandlerExtension on OutgoingCallHandler {
  /// 使用 CallLogRecorder 记录去电
  /// 
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [recorder] CallLogRecorder 实例
  /// 
  /// 通话类型将被设置为'outgoing'
  Future<void> recordOutgoingCall(
      String phoneNumber, CallData callData, CallLogRecorder recorder) async {
    await recorder.recordOutgoingCall(phoneNumber, callData);
  }
  
  /// 记录去电，支持可选的 CallLogRecorder 参数
  /// 
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [recorder] 可选的 CallLogRecorder 实例
  Future<void> recordOutgoingCallWithOptionalRecorder(String phoneNumber, CallData callData, [CallLogRecorder? recorder]) async {
    // 如果提供了 recorder，使用它记录去电
    if (recorder != null) {
      await recorder.recordOutgoingCall(phoneNumber, callData);
    }
    // 这里可以添加其他记录逻辑，如果需要的话
  }
}

/// CallFilterService 扩展，用于记录拒绝原因
extension CallFilterServiceExtension on CallFilterService {
  // 记录拒绝原因的静态变量
  static String? _rejectionReason;
  
  // 设置拒绝原因
  void setRejectionReason(String reason) {
    _rejectionReason = reason;
  }
  
  // 获取拒绝原因
  static String? getRejectionReason() {
    return _rejectionReason;
  }
}

/// EndCallHandler 扩展，用于记录拦截动作
extension EndCallHandlerExtension on EndCallHandler {
  // 记录拦截动作的静态变量
  static InterceptAction? _interceptAction;
  
  // 设置拦截动作
  void setInterceptAction(InterceptAction? action) {
    _interceptAction = action;
  }
  
  // 获取拦截动作
  static InterceptAction? getInterceptAction() {
    return _interceptAction;
  }
}