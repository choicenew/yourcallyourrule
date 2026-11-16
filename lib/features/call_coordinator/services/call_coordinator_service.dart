import 'dart:async';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_phone_call_monitor_protocol/pyro_phone_call_monitor_protocol.dart';
import 'package:pyro_phone_call_monitor_hub/pyro_phone_call_monitor_hub.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/display_mode_handler.dart';
import 'package:yourcallyourrule/features/call_evaluators/handlers/should_accept_call_handler.dart';
import 'package:yourcallyourrule/features/call_evaluators/handlers/end_call_handler.dart';
import 'package:yourcallyourrule/features/call_evaluators/handlers/intercept_event_provider.dart';
import 'package:yourcallyourrule/features/call_evaluators/evaluators/call_policy_evaluator.dart';
import 'package:yourcallyourrule/features/call_evaluators/config/label_action_config_provider.dart';
import 'package:yourcallyourrule/features/call_evaluators/config/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/time_interceptor/service/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/call_filter/enhanced_composite_filter_service.dart';

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

      final identityFuture = _identityService.getCallerId(
        event.phoneNumber,
        Locale.english,
      );

      final timeInterceptFuture = _ref.read(timeInterceptorServiceProvider).shouldIntercept(event.phoneNumber);
      final filterFuture = _ref.read(enhancedCompositeFilterServiceProvider).shouldAcceptCall(event.phoneNumber);

      final results = await Future.wait([
        identityFuture,
        timeInterceptFuture,
        filterFuture,
      ]);

      final callerIdData = results[0] as CallerIdData;
      final isTimeBlocked = results[1] as bool;
      final isFilterAccepted = results[2] as bool;

      final labelActionMap = _ref.read(labelActionConfigProvider);
      final defaultAction = _ref.read(interceptActionConfigProvider);

      final rawLabels = callerIdData.labels;
      final List<String> labelsList = [];
      if (rawLabels != null) {
        for (final item in rawLabels) {
          if (item is String) {
            labelsList.add(item);
          } else {
            final str = (item as dynamic).label?.toString() ?? (item as dynamic).text?.toString() ?? item.toString();
            labelsList.add(str);
          }
        }
      }

      final policyContext = CallPolicyContext(
        phoneNumber: event.phoneNumber,
        isTimeBlocked: isTimeBlocked,
        isFilterAccepted: isFilterAccepted,
        labels: labelsList,
        labelActionMap: labelActionMap,
        defaultInterceptAction: defaultAction,
      );

      final verdict = _ref.read(callPolicyEvaluatorProvider).evaluate(policyContext);
      debugPrint('[CallCoordinator Hub] 策略综合评估完成: shouldBlock=${verdict.shouldBlock}, action=${verdict.action}, reason=${verdict.reason}');

      _ref.read(shouldAcceptCallHandlerProvider).sendDecision(verdict.shouldAccept);

      if (verdict.shouldBlock) {
        if (verdict.action != null) {
          _ref.read(endCallHandlerProvider).setInjectedAction(verdict.action);
        }
        _ref.read(interceptEventStreamControllerProvider).add(
          InterceptEvent(
            phoneNumber: event.phoneNumber,
            actionName: verdict.action?.actionName ?? defaultAction.actionName,
          ),
        );
      }

      final displayModeHandler = await _ref.read(displayModeHandlerProvider.future);
      await displayModeHandler.handleDisplayMode(callerIdData);

      final recorder = _ref.read(callLogRecorderProvider);
      await recorder.recordIncomingCall(event.phoneNumber, callerIdData, verdict.shouldAccept);
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
