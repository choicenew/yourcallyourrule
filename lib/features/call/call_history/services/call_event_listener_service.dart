import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';



import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';


import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 通话事件监听服务
/// 负责监听来电去电事件，并将通话数据同步到通话记录服务
/// 通过监听 CallerIdMonitorService 的事件流来实现
class CallEventListenerService {
  final CallLogService _callLogService;
  final CallerIdMonitorService _callerIdMonitorService;
  final PredefinedLabelService _predefinedLabelService;
  final Uuid _uuid = const Uuid();

  // 【修改】 1. 增加内部状态来管理通话时长
  String? _activeCallNumber; // 存储当前正在通话的号码
  int? _callStartTimeMillis; // 存储通话开始的时间戳

  // Temporary buffer to store raw call events until CallData is processed
  final Map<String, Map<String, dynamic>> _pendingRawCallEvents = {};

  // Subscription to the raw event stream from CallerIdMonitorService
  StreamSubscription<MethodCall>? _callEventSubscription;
  // Subscription to the processed CallData stream from CallerIdMonitorService
  StreamSubscription<CallData>? _callDataStreamSubscription;

  late final CallLogRecorder _callLogRecorder;

  CallEventListenerService(
    this._callLogService,
    this._callerIdMonitorService,
    this._predefinedLabelService,
  ) {
    _callLogRecorder = CallLogRecorder(_callLogService, _predefinedLabelService);
  }

  Future<void> initialize() async {
    await _callEventSubscription?.cancel();
    await _callDataStreamSubscription?.cancel();

    _callEventSubscription =
        _callerIdMonitorService.rawCallEventStream.listen(_handleCallerIdMethodCall);
    debugPrint('✅ [EventListener] Initialized and listening to raw call events.');

    _callDataStreamSubscription =
        _callerIdMonitorService.callDataStream.listen(_handleProcessedCallData);
    debugPrint('✅ [EventListener] Listening to processed CallData stream.');
  }

  /// Process raw method calls from the event stream
  void _handleCallerIdMethodCall(MethodCall call) {
       // --- 【第一处修改】: 在函数入口就打印日志，确保我们能看到所有事件 ---
    debugPrint("➡️ [EventListener] Received raw event: ${call.method}, args: ${call.arguments}");
    // 确保 arguments 是一个 Map
    if (call.arguments is! Map<dynamic, dynamic>) {
        // 【修改】2. 处理 onCallEnded 这种没有 arguments 的情况
        if (call.method == 'onCallEnded') {
            _handleCallEnded(null); // 仍然调用处理函数，但时间戳为 null
        }
        return;
    }

    final arguments = call.arguments as Map<dynamic, dynamic>;
    final phoneNumber = arguments['phoneNumber'] as String?;
    final timestamp = arguments['timestamp'] as int?;

    switch (call.method) {
      case 'onIncomingCall':
        if (phoneNumber != null) {
          // 【修改】3. 存储时间戳，并将初始状态设为 'ringing'，更准确
          _pendingRawCallEvents[phoneNumber] = {
            'type': 'incoming',
            'status': 'ringing', // 初始状态是响铃中
            'timestamp': timestamp,
          };
         debugPrint('📝 [EventListener] Stored incoming call event for $phoneNumber with timestamp: $timestamp');
        }
        break;
      
      case 'onOutgoingCall':
        if (phoneNumber != null) {
          // 【修改】4. 存储时间戳，并标记为活动通话
          _pendingRawCallEvents[phoneNumber] = {
            'type': 'outgoing',
            'status': 'dialing', // 初始状态是拨号中
            'timestamp': timestamp,
          };
          // 去电一旦发生，就认为是“活动通话”
          _activeCallNumber = phoneNumber;
          _callStartTimeMillis = timestamp;
          debugPrint('📝 [EventListener] Stored outgoing call event for $phoneNumber with timestamp: $timestamp');
        }
        break;

      // 【新增】5. 处理电话被接听的事件
      case 'onCallAnswered':
        // 如果有正在响铃的电话，将其状态更新为 'answered'
        final ringingCallEntry = _pendingRawCallEvents.entries.firstWhere(
            (entry) => entry.value['status'] == 'ringing',
            orElse: () => const MapEntry('', {}));
        
        if (ringingCallEntry.key.isNotEmpty) {
          _activeCallNumber = ringingCallEntry.key;
          _callStartTimeMillis = timestamp;
          // 更新缓存中该电话的状态
          _pendingRawCallEvents[_activeCallNumber!]?['status'] = 'answered';
             debugPrint('⏱️ [EventListener] onCallAnswered Call answered for $_activeCallNumber. Start time recorded with timestamp: $timestamp');
        }
        break;

      // 【新增】6. 将 onCallEnded 的逻辑移到独立的函数中处理
      case 'onCallEnded':
        _handleCallEnded(timestamp);
        break;
    }
  }

  /// 【新增】7. 专门处理通话结束的逻辑
  void _handleCallEnded(int? endTimestamp) {
    debugPrint('🏁 [EventListener] Call ended event received.');

    // 场景A: 这是一个被接听后挂断的通话
    if (_activeCallNumber != null && _callStartTimeMillis != null && endTimestamp != null) {
      final duration = endTimestamp - _callStartTimeMillis!;
      final event = _pendingRawCallEvents.remove(_activeCallNumber);

      if (event != null) {
        // 有了完整的通话信息（号码、开始时间、结束时间、时长），现在等待CallData来记录日志
        // 我们需要将这些信息存回缓存，以便 _handleProcessedCallData 能使用
        _pendingRawCallEvents[_activeCallNumber!] = {
          ...event,
          'status': 'completed', // 标记为已完成
          'startTime': _callStartTimeMillis,
          'endTime': endTimestamp,
          'duration': duration,
        };
        debugPrint('✅ [EventListener] Call for $_activeCallNumber completed with duration $duration ms. Waiting for CallData.');
      }
    }
    // 场景B: 这是未被处理的响铃电话（未接来电）
    else {
      // 遍历所有仍在响铃的事件，并将它们标记为'missed'
      _pendingRawCallEvents.forEach((key, value) {
        if (value['status'] == 'ringing') {
          _pendingRawCallEvents[key]?['status'] = 'missed';
          debugPrint('📞 [EventListener] Call from $key was missed.');
        }
      });
    }

    // 无论如何，通话结束了，重置状态
    _activeCallNumber = null;
    _callStartTimeMillis = null;
  }


  /// Handle processed CallData from CallHandler's stream
  Future<void> _handleProcessedCallData(CallData callData) async {
    final phoneNumber = callData.callerIdData.phoneNumber.value;
    debugPrint('💡 [EventListener] Received processed CallData for $phoneNumber');

    // 现在我们只在需要记录日志时才移除事件
    final rawEvent = _pendingRawCallEvents[phoneNumber];

    if (rawEvent != null) {
      final callType = rawEvent['type'] as String;
      final callStatus = rawEvent['status'] as String;

      debugPrint('🤝 [EventListener] Matched CallData with raw event. Type: $callType, Status: $callStatus');
      
      // 【修改】8. 根据新的状态系统来记录日志
      switch (callStatus) {
        case 'completed': // 已接听的通话
          _pendingRawCallEvents.remove(phoneNumber); // 记录日志后移除
          await _recordCall(
            phoneNumber,
            callData,
            callType,
            accepted: true,
            startTime: DateTime.fromMillisecondsSinceEpoch(rawEvent['startTime']),
            duration: Duration(milliseconds: rawEvent['duration']),
          );
          break;
        case 'missed': // 未接来电
          _pendingRawCallEvents.remove(phoneNumber);
          await _recordCall(phoneNumber, callData, 'missed');
          break;
        case 'rejected': // 拒接（这个状态需要由 EndCallHandler 设置）
          _pendingRawCallEvents.remove(phoneNumber);
          await _recordCall(phoneNumber, callData, 'rejected');
          break;
        case 'blocked': // 拦截（同上）
          _pendingRawCallEvents.remove(phoneNumber);
          await _recordCall(phoneNumber, callData, 'blocked');
          break;
              // --- 【新增的 Case】 ---
        case 'ringing':
        case 'dialing':
        case 'answered': // 接听状态也一样，等待 onCallEnded 来最终确定时长和记录
          // 当状态是这些中间状态时，我们收到了 CallData，但通话还没有结束。
          // 我们什么都不需要做，只需要等待 onCallEnded 事件来触发最终的日志记录。
           // 当前逻辑是在 onCallEnded 后记录，所以这里可以暂时不处理
                  debugPrint('⏳ [EventListener] CallData received for an ongoing call (status: $callStatus). Waiting for the call to end before logging.');
          break;
        default:
          debugPrint('⚠️ [EventListener] Unhandled status "$callStatus" for $phoneNumber.');
      }
    } else {
      debugPrint('🤷 [EventListener] No matching raw event found for $phoneNumber.');
    }
  }

  /// Generic method to record a call using CallLogRecorder
  Future<void> _recordCall(String phoneNumber, CallData callData, String callType, {
    bool? accepted,
    // 【修改】9. 为 _recordCall 增加时间戳和时长参数
    DateTime? startTime,
    Duration? duration,
  }) async {
    // 【修改】10. 将新的时间参数传递给 CallLogRecorder
    // 注意: 这假设你的 CallLogRecorder 已经或将会被修改以接受这些新参数
    switch (callType) {
      case 'incoming':
        await _callLogRecorder.recordIncomingCall(
          phoneNumber, 
          callData, 
          accepted ?? true, 
          // timestamp: startTime?.millisecondsSinceEpoch // 假设 recordIncomingCall 接受 timestamp
        );
        break;
      case 'missed':
        await _callLogRecorder.recordIncomingCall(phoneNumber, callData, false);
        break;
      case 'outgoing':
        await _callLogRecorder.recordOutgoingCall(
          phoneNumber, 
          callData,
          // timestamp: startTime?.millisecondsSinceEpoch, 
          // duration: duration
        );
        break;
      case 'rejected':
        await _callLogRecorder.recordRejectedCall(phoneNumber, callData);
        break;
      case 'blocked':
        await _callLogRecorder.recordBlockedCall(phoneNumber, callData);
        break;
    }
  }

  /// Stop the listening service
  void dispose() {
    _callEventSubscription?.cancel();
    _callDataStreamSubscription?.cancel();
    _pendingRawCallEvents.clear();
    _activeCallNumber = null;
    _callStartTimeMillis = null;
    debugPrint('🗑️ [EventListener] Disposed and all subscriptions cancelled.');
  }
}