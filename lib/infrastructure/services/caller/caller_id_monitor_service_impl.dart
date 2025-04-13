import 'dart:async';

import '../../../common/platform/android/call_channel.dart';
import '../../../domain/entities/call/call_log.dart';
import '../../../domain/value_objects/rule_action.dart';
import '../base_service_impl.dart';
import 'caller_id_service_impl.dart';

/// 来电监控服务实现
/// 负责监听来电事件并调用来电识别服务进行处理
class CallerIdMonitorServiceImpl extends BaseServiceImpl {
  final CallerIdServiceImpl _callerIdService;
  final CallChannel _callChannel;
  
  StreamSubscription? _callSubscription;
  bool _isMonitoring = false;
  
  CallerIdMonitorServiceImpl(
    this._callerIdService,
    this._callChannel,
  );
  
  /// 开始监控来电
  Future<void> startMonitoring() async {
    if (_isMonitoring) return;
    
    try {
      await _callChannel.initialize();
      
      _callSubscription = _callChannel.callStream.listen(_handleIncomingCall);
      _isMonitoring = true;
      
      logOperation('开始监控来电');
    } catch (e) {
      logOperation('监控来电失败', details: e.toString());
      rethrow;
    }
  }
  
  /// 停止监控来电
  Future<void> stopMonitoring() async {
    if (!_isMonitoring) return;
    
    await _callSubscription?.cancel();
    _callSubscription = null;
    _isMonitoring = false;
    
    logOperation('停止监控来电');
  }
  
  /// 处理来电
  Future<void> _handleIncomingCall(CallEvent event) async {
    logOperation('收到来电', details: '${event.phoneNumber}');
    
    // 识别来电
    final result = await _callerIdService.identifyCaller(event.phoneNumber);
    
    // 根据规则执行相应动作
    switch (result.action.value) {
      case 'block':
        await _callChannel.rejectCall(event.phoneNumber);
        break;
      case 'allow':
        // 允许通话，不做任何操作
        break;
      default:
        // 默认行为，可以根据应用设置决定
        break;
    }
    
    // 记录通话
    final callLog = CallLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      phoneNumber: event.phoneNumber,
      name: result.contact?.name,
      duration: 0, // 未接通的通话
      timestamp: DateTime.now().millisecondsSinceEpoch,
      callType: 'incoming',
      actionTaken: result.action.value,
      ruleId: result.matchedRule?.id,
    );
    
    await _callerIdService.logCall(callLog);
  }
  
  /// 检查是否正在监控
  bool isMonitoring() {
    return _isMonitoring;
  }
}

/// 通话事件
class CallEvent {
  final String phoneNumber;
  final String state;
  
  CallEvent({
    required this.phoneNumber,
    required this.state,
  });
}