import 'dart:async';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_call_monitor_protocol/pyro_call_monitor_protocol.dart';
import 'package:pyro_call_monitor_hub/pyro_call_monitor_hub.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/display_mode_handler.dart';
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

    debugPrint('[CallCoordinator Hub] 生产级全流程并发调度中枢已全面激活');
  }

  Future<void> _handleMonitorEvent(CallMonitorEvent event) async {
    if (event is IncomingCallEvent) {
      debugPrint('[CallCoordinator Hub] 收到来电事件: ${event.phoneNumber}');

      final policyFuture = _ref.read(callPolicyEvaluatorProvider).evaluate(
        event.phoneNumber,
      );

      final identityFuture = _identityService.getCallerId(
        event.phoneNumber,
        Locale.english,
      );

      unawaited(policyFuture.then((policyResult) {
        final bool shouldAccept = policyResult.action == 'allow';
        debugPrint('[CallCoordinator Hub] 策略响应: ${policyResult.action} ($shouldAccept)');
        _ref.read(shouldAcceptCallHandlerProvider).sendDecision(shouldAccept);
      }));

      final callerIdData = await identityFuture;
      final displayModeHandler = await _ref.read(displayModeHandlerProvider.future);
      await displayModeHandler.handleDisplayMode(callerIdData);

      final recorder = _ref.read(callLogRecorderProvider);
      await recorder.recordIncomingCall(event.phoneNumber, callerIdData, false);
    } else if (event is CallEndedEvent) {
      debugPrint('[CallCoordinator Hub] 通话结束事件: ${event.phoneNumber}');
    }
  }

  Future<void> _onCallerIdIncrementalUpdate(CallerIdData data) async {
    debugPrint('[CallCoordinator Hub] 接收到插件增量刷新: ${data.name}');
    final displayModeHandler = await _ref.read(displayModeHandlerProvider.future);
    await displayModeHandler.handleDisplayMode(data);
  }

  void dispose() {
    _subscription?.cancel();
    _identitySubscription?.cancel();
  }
}
