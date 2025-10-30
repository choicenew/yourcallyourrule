import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/local_call_type.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/intercept_event_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_monitor_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// ## 通话事件监听服务 (CallEventListenerService)
///
/// 这个服务是整个通话日志记录功能的“中枢神经系统”。
/// 它负责监听来自原生层的所有原始通话事件（如响铃、去电、接听、挂断），
/// 并将这些事件与经过处理的通话信息（CallData）进行匹配，
/// 最终在合适的时机，调用 `CallLogRecorder` 来将通话记录持久化到数据库。
class CallEventListenerService {
  // --- 依赖 ---
  final Ref _ref;
  final CallLogService _callLogService;
  final CallerIdMonitorService _callerIdMonitorService;
  final PredefinedLabelService _predefinedLabelService;
  late final CallLogRecorder _callLogRecorder;

  // --- 内部状态 ---
  String? _activeCallNumber;
  int? _callStartTimeMillis;
  final Map<String, Map<String, dynamic>> _pendingRawCallEvents = {};
  final Map<String, CallData> _processedCallDataBuffer = {};

  // --- 事件订阅 ---
  StreamSubscription<MethodCall>? _callEventSubscription;
  StreamSubscription<CallData>? _callDataStreamSubscription;
  StreamSubscription<InterceptEvent>? _interceptEventSubscription;
  
  /// 构造函数，接收所有依赖项。
  CallEventListenerService(this._ref, this._callLogService, this._callerIdMonitorService, this._predefinedLabelService) {
    // 在构造函数内部创建 CallLogRecorder 实例，因为它只被这个服务使用。
    _callLogRecorder = CallLogRecorder(_callLogService, _predefinedLabelService);
  }

  /// 初始化服务，开始监听所有相关的事件流。
  Future<void> initialize() async {
    // 先取消所有旧的订阅，以防止在热重载等场景下重复监听，导致内存泄漏。
    await _callEventSubscription?.cancel();
    await _callDataStreamSubscription?.cancel();
    await _interceptEventSubscription?.cancel();

    // 1. 监听原始通话事件 (来自原生代码)
    _callEventSubscription = _callerIdMonitorService.rawCallEventStream.listen(_handleCallerIdMethodCall);
    
    // 2. 监听处理后的通话数据 (来自 CallerIdService)
    _callDataStreamSubscription = _callerIdMonitorService.callDataStream.listen(_handleProcessedCallData);
    
    // 3. 监听应用内拦截事件 (来自 EndCallHandler)
    _interceptEventSubscription = _ref.read(interceptEventStreamControllerProvider).stream.listen(_handleInterceptEvent);
    
    debugPrint('✅ [EventListener] Initialized and listening to all event streams.');
  }

  /// **处理函数 1**: 接收原生事件，更新内部状态字符串。
  /// 这是所有来自 Android/iOS 的通话状态变化的第一站。
  void _handleCallerIdMethodCall(MethodCall call) {
    debugPrint("➡️ [EventListener] Received raw event: ${call.method}, args: ${call.arguments}");
    
    if (call.arguments is! Map<dynamic, dynamic>) {
        if (call.method == 'onCallEnded') _handleCallEnded(null);
        return;
    }

    final arguments = call.arguments as Map<dynamic, dynamic>;
    final phoneNumber = arguments['phoneNumber'] as String?;
    final timestamp = arguments['timestamp'] as int?;

    switch (call.method) {
      case 'onIncomingCall':
        if (phoneNumber != null) {
          // 收到一个来电，将其信息存入缓冲区，状态为 'ringing'。
          _pendingRawCallEvents[phoneNumber] = {'type': 'incoming', 'status': 'ringing', 'timestamp': timestamp};
          debugPrint('📝 [EventListener] Stored incoming call event for $phoneNumber');
        }
        break;
      
      case 'onOutgoingCall':
        if (phoneNumber != null && timestamp != null) {
          // 收到一个去电，将其信息存入缓冲区，状态为 'dialing'。
          // 同时，将其标记为当前“活动通话”，并记录开始时间。
          _pendingRawCallEvents[phoneNumber] = {'type': 'outgoing', 'status': 'dialing', 'timestamp': timestamp};
          _activeCallNumber = phoneNumber;
          _callStartTimeMillis = timestamp;
          debugPrint('🚀 [EventListener] Outgoing call initiated for $phoneNumber.');
        }
        break;

      // 【新增】5. 处理电话被接听的事件
      case 'onCallAnswered':
        // 收到电话接听事件。
        // 我们需要找到哪个正在响铃的电话被接听了。
        final entry = _pendingRawCallEvents.entries.firstWhere((e) => e.value['status'] == 'ringing', orElse: () => const MapEntry('', {}));
        if (entry.key.isNotEmpty) {
          // 找到后，将其标记为“活动通话”，记录接听时间，并更新状态为 'answered'。
          _activeCallNumber = entry.key;
          _callStartTimeMillis = timestamp;
          _pendingRawCallEvents[_activeCallNumber!]?['status'] = 'answered';
          debugPrint('⏱️ [EventListener] Incoming call answered for $_activeCallNumber.');
        }
        break;

      // 【新增】6. 将 onCallEnded 的逻辑移到独立的函数中处理
      case 'onCallEnded':
        // 收到通话结束事件，交由专门的函数处理。
        _handleCallEnded(timestamp);
        break;
    }
  }

  /// **处理函数 2**: 处理通话结束，更新内部状态字符串。
  void _handleCallEnded(int? endTimestamp) {
    debugPrint('🏁 [EventListener] Call ended event received.');

    // 场景 A: 如果当前有一个“活动通话”（已接听的来电或去电）。
    if (_activeCallNumber != null && _callStartTimeMillis != null && endTimestamp != null) {
      final number = _activeCallNumber!;
      final event = _pendingRawCallEvents[number];
      if (event != null) {
        // 计算通话时长，并更新事件状态为 'completed'。
        _pendingRawCallEvents[number] = {
          ...event,
          'status': 'completed',
          'startTime': _callStartTimeMillis,
          'endTime': endTimestamp,
          'duration': endTimestamp - _callStartTimeMillis!,
        };
        debugPrint('✅ [EventListener] Call for $number completed. Attempting to log.');
        // 状态更新后，立即尝试记录日志。
        _tryLogCall(number);
      }
    } else {
      // 场景 B: 如果没有活动通话，说明是未被处理的响铃电话（未接来电）。
      final missed = _pendingRawCallEvents.entries.where((e) => e.value['status'] == 'ringing').map((e) => e.key).toList();
      for (final number in missed) {
          // 将所有仍在响铃的电话状态更新为 'missed'。
          _pendingRawCallEvents[number]?['status'] = 'missed';
          debugPrint('📞 [EventListener] Call from $number was missed. Attempting to log.');
          _tryLogCall(number);
      }
    }
    // 通话结束，重置活动通话状态。
    _activeCallNumber = null;
    _callStartTimeMillis = null;
  }

  /// **处理函数 3**: 接收已加工的通话数据（CallData）。
  Future<void> _handleProcessedCallData(CallData callData) {
    final phoneNumber = callData.callerIdData.phoneNumber.value;
    debugPrint('💡 [EventListener] Received processed CallData for $phoneNumber');
    // 将收到的 CallData 存入缓冲区。
    _processedCallDataBuffer[phoneNumber] = callData;
    // 立即尝试记录日志，因为可能另一部分信息（如通话结束事件）已经到达。
    return _tryLogCall(phoneNumber);
  }

  /// **处理函数 4**: 接收应用内拦截事件，并更新通话状态字符串。
  void _handleInterceptEvent(InterceptEvent event) {
    final phoneNumber = event.phoneNumber;
    debugPrint("🔔 [EventListener] Received intercept event for $phoneNumber, raw action name: ${event.actionName}");

    if (_pendingRawCallEvents.containsKey(phoneNumber)) {
      // 直接使用来自 InterceptAction 枚举的名称 (如 'endCall') 作为我们的内部状态。
      // 这个状态字符串将在 _tryLogCall 中被翻译成最终的 LocalCallType。
      _pendingRawCallEvents[phoneNumber]?['status'] = event.actionName;
      debugPrint("   ➡️ Internal status updated to: ${event.actionName}");
      _tryLogCall(phoneNumber);
    } else {
       debugPrint("⚠️ [EventListener] Intercept event received for an unknown number: $phoneNumber");
    }
  }

  /// **调度中心 / 决策者**
  /// 它的职责是：
  /// 1. **检查**：确认记录日志所需的所有信息（rawEvent, callData）是否都已到达。
  /// 2. **决策**：根据 `status` 字符串，决定这次通话的最终类型 (`LocalCallType`)。
  /// 3. **打包**：根据最终类型，准备好对应的额外时间数据（`extraArgs`）。
  /// 4. **委派**：调用 `_recordCall`，将所有整理好的、类型安全的信息传递给它去执行。
  Future<void> _tryLogCall(String phoneNumber) async {
    final rawEvent = _pendingRawCallEvents[phoneNumber];
    final callData = _processedCallDataBuffer[phoneNumber];

    // --- 1. 检查 ---
    if (rawEvent == null || callData == null) {
      debugPrint('⏳ [EventListener] Waiting for more data for $phoneNumber.');
      return; // 信息不全，现在还不能记录。
    }

    final statusString = rawEvent['status'] as String;
    
    // --- 2. 决策 & 3. 打包 ---

    // 最终的通话类型，将在 switch 中被确定。
    LocalCallType callType; 
    
    // 一个动态的数据包，用于存放不同通话类型所需的特定时间信息。
    // **重要**: 我们在这里为它设置了默认值。
    // 对于所有非 `completed` 的通话（missed, rejected 等），它们都需要 `timestamp`。
    // 所以我们默认就把它放进去。
    Map<String, dynamic> extraArgs = {'timestamp': rawEvent['timestamp']};

    // 根据状态字符串，决定 callType 并准备好对应的 extraArgs 数据包。
    switch (statusString) {
      case 'completed':
        // 已完成的通话，是 `incoming` 还是 `outgoing`？
        callType = rawEvent['type'] == 'incoming' ? LocalCallType.incoming : LocalCallType.outgoing;
        
        // 已完成的通话有特殊的时间数据：`startTime` 和 `duration`。
        // 所以我们用一个新的数据包覆盖掉默认的 `extraArgs`。
        extraArgs = {
          'startTime': DateTime.fromMillisecondsSinceEpoch(rawEvent['startTime']),
          'duration': Duration(milliseconds: rawEvent['duration']),
        };
        break;

      case 'missed':
        callType = LocalCallType.missed;
        // extraArgs 不需要修改，因为它已经包含了我们需要的 `timestamp`。
        break;

      case 'endCall': // 这是从 InterceptAction.name 来的字符串
        callType = LocalCallType.rejected;
        // extraArgs 同样不需要修改，因为它已经包含了 `timestamp`。
        break;

      case 'answerThenHangup':
        callType = LocalCallType.blocked;
        // extraArgs 同样不需要修改。
        break;

      case 'silenceNoAnswer':
        callType = LocalCallType.silenced;
        // extraArgs 同样不需要修改。
        break;
      
      // 中间状态，决策为"不记录"，直接返回。
      case 'ringing':
      case 'dialing':
      case 'answered':
        debugPrint('⏳ [EventListener] Data ready for $phoneNumber, but call is ongoing (status: "$statusString").');
        return;

      default:
        // 遇到未知的状态字符串，记录为 `unknown` 类型，并使用默认的 `timestamp`。
        debugPrint('⚠️ [EventListener] Unhandled status string "$statusString" for $phoneNumber. Logging as unknown.');
        callType = LocalCallType.unknown;
    }

    // --- 4. 委派 ---
    // 将所有整理好的信息（phoneNumber, callData, callType, extraArgs）
    // 交给 `_recordCall` 去执行。
    await _recordCall(phoneNumber, callData, callType, extraArgs);

    // 任务成功委派并执行后，清理这个号码的所有缓冲数据。
    _pendingRawCallEvents.remove(phoneNumber);
    _processedCallDataBuffer.remove(phoneNumber);
    debugPrint('✅ [EventListener] Logged and cleaned up for $phoneNumber.');
  }

  /// **执行者 / 传送带**
  /// 它的职责是：
  /// 1. **接收**：接收来自 `_tryLogCall` 的、完全整理好的、类型安全的指令。
  /// 2. **分发**：根据 `LocalCallType`，将任务精确地分发给 `CallLogRecorder` 中对应的具体方法。
  /// 它不进行任何逻辑判断或数据转换。
  Future<void> _recordCall(String phoneNumber, CallData callData, LocalCallType callType, Map<String, dynamic> args) async {
    debugPrint("🔴 [EventListener] EXECUTING record for $phoneNumber as TYPE: ${callType.name}");
    
    switch (callType) {
      case LocalCallType.incoming:
        await _callLogRecorder.recordIncomingCall(phoneNumber, callData, true, 
          startTime: args['startTime'], 
          duration: (args['duration'] as Duration).inMilliseconds
        );
        break;
      case LocalCallType.missed:
        await _callLogRecorder.recordIncomingCall(phoneNumber, callData, false, 
          timestamp: args['timestamp']
        );
        break;
      case LocalCallType.outgoing:
        await _callLogRecorder.recordOutgoingCall(phoneNumber, callData, 
          startTime: args['startTime'], 
          duration: args['duration']
        );
        break;
      case LocalCallType.rejected:
        await _callLogRecorder.recordRejectedCall(phoneNumber, callData, 
          timestamp: args['timestamp']
        );
        break;
      case LocalCallType.blocked:
        await _callLogRecorder.recordBlockedCall(phoneNumber, callData, 
          timestamp: args['timestamp']
        );
        break;
      case LocalCallType.silenced:
        await _callLogRecorder.recordSilencedCall(phoneNumber, callData, 
          timestamp: args['timestamp']
        );
        break;
      
      // 为所有可能的枚举值提供处理，即使它们当前不记录，
      // 也能防止在未来添加新类型时出现编译警告或逻辑遗漏。
      case LocalCallType.unknown:
      case LocalCallType.unknownIntercept:
      case LocalCallType.voicemail:
        debugPrint("ℹ️ [EventListener] Call type ${callType.name} is not configured for recording. Ignoring.");
        break;
    }
  }

  /// 清理资源，取消所有事件订阅，防止内存泄漏。
  void dispose() {
    _callEventSubscription?.cancel();
    _callDataStreamSubscription?.cancel();
    _interceptEventSubscription?.cancel();
    _pendingRawCallEvents.clear();
    _processedCallDataBuffer.clear();
    _activeCallNumber = null;
    _callStartTimeMillis = null;
    debugPrint('🗑️ [EventListener] Disposed and all subscriptions cancelled.');
  }
}