import 'dart:async';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/display_mode_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/events/call_monitor_events.dart';
import 'package:yourcallyourrule/features/call_monitor/services/call_monitor_service.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/should_accept_call_handler.dart';
import 'package:yourcallyourrule/features/call_policy/evaluators/call_policy_evaluator.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';

part 'call_coordinator_service.g.dart';

@Riverpod(keepAlive: true)
CallCoordinatorService callCoordinatorService(Ref ref) {
  final service = CallCoordinatorService(
    ref: ref,
    monitorService: ref.watch(callMonitorServiceProvider),
    identityService: ref.watch(callerIdentityServiceProvider),
  );
  ref.onDispose(() => service.dispose());
  service.startOrchestration();
  return service;
}

/// 生产级全流程调度中枢 (Master Orchestrator / Async Event Hub)
/// 0 毫秒延迟并发分发：监听到事件 ➔ 并行调度 Policy 策略 & Identity 身份画像 ➔ 汇总驱动 UI/通知与日志落库
class CallCoordinatorService {
  final Ref _ref;
  final CallMonitorService _monitorService;
  final CallerIdentityService _identityService;

  StreamSubscription<CallMonitorEvent>? _subscription;
  StreamSubscription<CallerIdData>? _identitySubscription;

  CallCoordinatorService({
    required Ref ref,
    required CallMonitorService monitorService,
    required CallerIdentityService identityService,
  })  : _ref = ref,
        _monitorService = monitorService,
        _identityService = identityService;

  void startOrchestration() {
    _subscription?.cancel();
    _subscription = _monitorService.eventStream.listen(_handleMonitorEvent);

    _identitySubscription?.cancel();
    _identitySubscription = _identityService.callerIdStream.listen(_onCallerIdIncrementalUpdate);

    debugPrint('[CallCoordinator Hub] 生产级全流程并发调度中枢已全面激活。');
  }

  Future<void> _handleMonitorEvent(CallMonitorEvent event) async {
    if (event is IncomingCallEvent) {
      debugPrint('[CallCoordinator Hub] 收到来电事件: ${event.phoneNumber}，发起 0ms 并发调度');

      // 1. 并发派发：并行发起 策略评估 & 身份画像拉取
      final policyFuture = _ref.read(callPolicyEvaluatorProvider).evaluateShouldAccept(
        rawNumber: event.phoneNumber,
        nationalNumber: event.phoneNumber,
        e164Number: event.phoneNumber,
      );

      final identityFuture = _identityService.getCallerId(
        event.phoneNumber,
        Locale.english,
      );

      // 2. 策略先出结果时，秒级响应 Native 门禁
      unawaited(policyFuture.then((shouldAccept) {
        debugPrint('[CallCoordinator Hub] 策略极速响应: $shouldAccept');
        _ref.read(shouldAcceptCallHandlerProvider).sendDecision(shouldAccept);
      }));

      // 3. 身份拉取完成后，刷新 UI 与落库
      final callerIdData = await identityFuture;
      final displayModeHandler = await _ref.read(displayModeHandlerProvider.future);
      await displayModeHandler.showCallerIdInfo(callerIdData, null, null);

      final recorder = _ref.read(callLogRecorderProvider);
      final callData = CallData(
        callerIdData: callerIdData,
        e164Number: callerIdData.phoneNumber.value,
        nationalNumber: callerIdData.phoneNumber.value,
      );
      await recorder.recordIncomingCall(event.phoneNumber, callData, false);
    } else if (event is CallEndedEvent) {
      debugPrint('[CallCoordinator Hub] 通话结束事件: ${event.phoneNumber}');
      final displayModeHandler = await _ref.read(displayModeHandlerProvider.future);
      await displayModeHandler.closeDisplay();
    }
  }

  Future<void> _onCallerIdIncrementalUpdate(CallerIdData data) async {
    debugPrint('[CallCoordinator Hub] 接收到插件增量刷新，无缝更新 UI: ${data.name}');
    final displayModeHandler = await _ref.read(displayModeHandlerProvider.future);
    await displayModeHandler.showCallerIdInfo(data, null, null);
  }

  void dispose() {
    _subscription?.cancel();
    _identitySubscription?.cancel();
  }
}
