import 'dart:async';

import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';


import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';




import 'package:yourcallyourrule/platform/call_channel_switcher.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler_extension.dart';

/// 通话事件监听服务
/// 负责监听来电去电事件，并将通话数据同步到通话记录服务
/// 通过监听平台通道的方法调用来实现
class CallEventListenerService {
  final CallLogService _callLogService;
  final CallHandler _callHandler;
  final Uuid _uuid = const Uuid();
  
  // 平台通道管理器
  late final CallChannelInterface _channelManager;
  
  // 来电去电数据流控制器
  final _incomingCallSubject = BehaviorSubject<Map<String, dynamic>>();
  final _outgoingCallSubject = BehaviorSubject<Map<String, dynamic>>();
  
  // 通话数据订阅
  StreamSubscription<dynamic>? _callDataSubscription;
  
  // 通话记录器
  late final CallLogRecorder _callLogRecorder;
  
  
  CallEventListenerService(this._callLogService, this._callHandler) {
    _callLogRecorder = CallLogRecorder(_callLogService);
  }

  Future<void> initialize() async {
    _channelManager = CallChannelSwitcher.getPlatformChannelManager();
    
    // 设置来电去电回调
    _channelManager.onCallerIdCall = _handleCallerIdMethodCall;
    
    // 初始化通道
    _channelManager.initialize();
    
    // 初始化来电显示
    await _channelManager.initializeCallerId().catchError((error) {
      print('初始化来电显示失败: $error');
    });
    startListening();
  }
  
  /// 处理来电显示方法调用
  void _handleCallerIdMethodCall(MethodCall call) {
    switch (call.method) {
      case 'onIncomingCall':
        _handleIncomingCallEvent(call.arguments);
        break;
      case 'onOutgoingCall':
        _handleOutgoingCallEvent(call.arguments);
        break;
    }
  }
  
  /// 处理来电事件
  void _handleIncomingCallEvent(dynamic arguments) {
    if (arguments is Map<dynamic, dynamic>) {
      final phoneNumber = arguments['phoneNumber'] as String?;
      final callData = arguments['callData'] as CallData?;
      final status = arguments['status'] as String?;
      
      if (phoneNumber != null) {
        _incomingCallSubject.add({
          'phoneNumber': phoneNumber,
          'callData': callData,
          'status': status ?? 'missed' // 默认为未接来电
        });
      }
    }
  }
  
  /// 处理去电事件
  void _handleOutgoingCallEvent(dynamic arguments) {
    if (arguments is Map<dynamic, dynamic>) {
      final phoneNumber = arguments['phoneNumber'] as String?;
      final callData = arguments['callData'] as CallData?;
      final status = arguments['status'] as String?;
      
      if (phoneNumber != null) {
        _outgoingCallSubject.add({
          'phoneNumber': phoneNumber,
          'callData': callData,
          'status': status ?? 'missed' // 默认为未接来电
        });
      }
    }
  }
  
  /// 开始监听来电去电事件并同步到通话记录服务
  void startListening() {
    _callDataSubscription?.cancel();
    
    // 合并来电和去电数据流
    final mergedStream = _incomingCallSubject.map((data) => {'type': 'incoming', 'data': data})
      .mergeWith([_outgoingCallSubject.map((data) => {'type': 'outgoing', 'data': data})]);
    
    _callDataSubscription = mergedStream.listen((event) {
      if (event['type'] == 'incoming') {
        _handleIncomingCall(event['data'] as Map<String, dynamic>);
      } else if (event['type'] == 'outgoing') {
        _handleOutgoingCall(event['data'] as Map<String, dynamic>);
      }
    });
  }
  
  /// 处理来电事件
  Future<void> _handleIncomingCall(Map<String, dynamic> callData) async {
    final phoneNumber = callData['phoneNumber'] as String?;
    final callDataObj = callData['callData'] as CallData?;
    final callStatus = callData['status'] as String?;
    
    if (phoneNumber == null) {
      print('来电处理失败: 电话号码为空');
      return; // 电话号码为空，直接返回
    }
    
    if (callDataObj == null) {
      print('来电处理警告: 通话数据为空，将创建默认数据');
      // 如果通话数据为空，创建一个默认的CallData对象
      final defaultCallData = CallData(
        callerIdData: CallerIdData(
          id: _uuid.v4(),
          phoneNumber: PhoneNumber(phoneNumber),
          numberType: PhoneNumberType.unknown,
          name: phoneNumber,
        ),
        e164Number: phoneNumber,
        nationalNumber: phoneNumber,
      );
      
      // 根据来电状态处理不同类型的通话记录
      final status = callStatus ?? 'missed';
      await _recordCall(phoneNumber, defaultCallData, status);
      return;
    }
    
    // 根据来电状态处理不同类型的通话记录
    switch (callStatus) {
      case 'accepted':
        await _recordCall(phoneNumber, callDataObj, 'incoming');
        break;
      case 'rejected':
        await _recordCall(phoneNumber, callDataObj, 'rejected');
        break;
      case 'missed':
        await _recordCall(phoneNumber, callDataObj, 'missed');
        break;
      case 'blocked':
        await _recordCall(phoneNumber, callDataObj, 'blocked');
        break;
      default:
        // 未知状态，默认为未接来电
        await _recordCall(phoneNumber, callDataObj, 'missed');
    }
  }
  
  /// 处理去电事件
  Future<void> _handleOutgoingCall(Map<String, dynamic> callData) async {
    final phoneNumber = callData['phoneNumber'] as String?;
    final callDataObj = callData['callData'] as CallData?;
    
    if (phoneNumber == null) {
      print('去电处理失败: 电话号码为空');
      return; // 电话号码为空，直接返回
    }
    
    if (callDataObj == null) {
      print('去电处理警告: 通话数据为空，将创建默认数据');
      // 如果通话数据为空，创建一个默认的CallData对象
      final defaultCallData = CallData(
        callerIdData: CallerIdData(
          id: _uuid.v4(),
          phoneNumber: PhoneNumber(phoneNumber),
          numberType: PhoneNumberType.unknown,
          name: phoneNumber,
        ),
        e164Number: phoneNumber,
        nationalNumber: phoneNumber,
      );
      
      await _recordCall(phoneNumber, defaultCallData, 'outgoing');
      return;
    }
    
    await _recordCall(phoneNumber, callDataObj, 'outgoing');
  }
  
  /// 记录通话的通用方法
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [callType] 通话类型
  Future<void> _recordCall(String phoneNumber, CallData callData, String callType) async {
    // 使用CallHandlerExtension的扩展方法保存通话记录和缓存数据
    switch (callType) {
      case 'incoming':
        await _callHandler.saveCallerIdDataWithCallLog(
          phoneNumber, 
          callData, 
          _callLogRecorder,
          isIncoming: true,
          accepted: true
        );
        break;
      case 'missed':
        await _callHandler.saveCallerIdDataWithCallLog(
          phoneNumber, 
          callData, 
          _callLogRecorder,
          isIncoming: true,
          accepted: false
        );
        break;
      case 'outgoing':
        await _callHandler.saveCallerIdDataWithCallLog(
          phoneNumber, 
          callData, 
          _callLogRecorder,
          isIncoming: false
        );
        break;
      case 'rejected':
        // 先保存到缓存
        await _callHandler.saveCallerIdDataToCache(phoneNumber, callData);
        // 然后记录拒接通话
        await _callLogRecorder.recordRejectedCall(phoneNumber, callData);
        break;
      case 'blocked':
        // 先保存到缓存
        await _callHandler.saveCallerIdDataToCache(phoneNumber, callData);
        // 然后记录拦截通话
        await _callLogRecorder.recordBlockedCall(phoneNumber, callData);
        break;
      default:
        // 未知类型，默认为未接来电
        await _callHandler.saveCallerIdDataWithCallLog(
          phoneNumber, 
          callData, 
          _callLogRecorder,
          isIncoming: true,
          accepted: false
        );
    }
  }
  
  /// 停止监听服务
  void dispose() {
    _callDataSubscription?.cancel();
    _callDataSubscription = null;
    _incomingCallSubject.close();
    _outgoingCallSubject.close();
  }
}