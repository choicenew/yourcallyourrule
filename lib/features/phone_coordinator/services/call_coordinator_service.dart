import 'dart:async';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_phone_call_monitor_protocol/pyro_phone_call_monitor_protocol.dart';
import 'package:pyro_phone_call_monitor_hub/pyro_phone_call_monitor_hub.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/phone_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/phone_coordinator/handlers/display_mode_handler.dart';
import 'package:yourcallyourrule/features/phone_evaluators/handlers/should_accept_call_handler.dart';
import 'package:yourcallyourrule/features/phone_evaluators/handlers/end_call_handler.dart';
import 'package:yourcallyourrule/features/phone_evaluators/handlers/intercept_event_provider.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/call_policy_evaluator.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/label_action_config_provider.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/features/phone_caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/phone_time_interception/service/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/phone_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/emergency_call_policy_service.dart';
import 'package:yourcallyourrule/features/phone_evaluators/evaluators/expected_call_service.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/features/phone_subscription/utils/phone_utils.dart';
import 'package:yourcallyourrule/features/phone_rules/services/basic_rule_filter_service.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';
import 'package:yourcallyourrule/features/phone_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/phone_coordinator/models/call_evaluation_report.dart';
import 'package:yourcallyourrule/features/phone_coordinator/handlers/kit_live_activity_handler.dart';
import 'package:yourcallyourrule/features/phone_coordinator/handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/phone_coordinator/handlers/overlay_handler.dart';

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
      ).timeout(
        const Duration(milliseconds: 600),
        onTimeout: () => CallerIdData(phoneNumber: event.phoneNumber),
      );

      final timeInterceptFuture = _ref.read(timeInterceptorServiceProvider).shouldIntercept(event.phoneNumber);
      final filterFuture = _ref.read(enhancedCompositeFilterServiceProvider).shouldAcceptCall(event.phoneNumber);
      final emergencyExemptFuture = _ref.read(emergencyCallPolicyServiceProvider).isExempted();
      final isExpectedActive = _ref.read(expectedCallServiceProvider).isActive;

      final results = await Future.wait([
        identityFuture,
        timeInterceptFuture,
        filterFuture,
        emergencyExemptFuture,
      ]);

      final callerIdData = results[0] as CallerIdData;
      final isTimeBlocked = results[1] as bool;
      final isFilterAccepted = results[2] as bool;
      final isEmergencyExempted = results[3] as bool;

      final labelActionMap = _ref.read(labelActionConfigProvider);
      final defaultAction = _ref.read(interceptActionConfigProvider);

      final List<String> labelsList = callerIdData.labels;

      final policyContext = CallPolicyContext(
        phoneNumber: event.phoneNumber,
        isTimeBlocked: isTimeBlocked,
        isFilterAccepted: isFilterAccepted,
        isEmergencyExempted: isEmergencyExempted,
        isExpectedCallActive: isExpectedActive,
        labels: labelsList,
        labelActionMap: labelActionMap,
        defaultInterceptAction: defaultAction,
      );

      final verdict = _ref.read(callPolicyEvaluatorProvider).evaluate(policyContext);
      debugPrint('[CallCoordinator Hub] 策略综合评估完成: shouldBlock=${verdict.shouldBlock}, action=${verdict.action}, reason=${verdict.reason}');

      _ref.read(shouldAcceptCallHandlerProvider).sendDecision(verdict.shouldAccept);

      if (verdict.shouldBlock) {
        if (verdict.action != null) {
          _ref.read(endCallHandlerProvider).setInjectedActionForPhone(event.phoneNumber, verdict.action);
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
    } else if (event is OutgoingCallEvent) {
      debugPrint('[CallCoordinator Hub] 去电事件: ${event.phoneNumber}');
      await _ref.read(emergencyCallPolicyServiceProvider).recordEmergencyCallIfMatched(event.phoneNumber);
    } else if (event is CallEndedEvent) {
      debugPrint('[CallCoordinator Hub] 通话结束事件: ${event.phoneNumber}');
    }
  }

  Future<void> _onCallerIdIncrementalUpdate(CallerIdData data) async {
    debugPrint('[CallCoordinator Hub] 接收到插件增量刷新: ${data.name}');
    final displayModeHandler = await _ref.read(displayModeHandlerProvider.future);
    await displayModeHandler.handleDisplayMode(data);
  }

  /// 插件增量数据流
  Stream<PluginSourceData> get pluginDataStream => _identityService.pluginDataStream;

  /// 全流程空跑模拟评估（Dry-Run Evaluation）
  Future<CallEvaluationReport> dryRunEvaluate(String phoneNumberStr, {String? countryIso}) async {
    final target = phoneNumberStr.trim();
    if (target.isEmpty) return const CallEvaluationReport();

    final basicRuleFilterService = _ref.read(basicRuleFilterServiceProvider);
    final timeInterceptorService = _ref.read(timeInterceptorServiceProvider);
    final localCountFilterService = _ref.read(localCountFilterServiceProvider);
    final remoteNumberFilterService = _ref.read(remoteNumberFilterServiceProvider);
    final contactService = _ref.read(contactServiceProvider);
    final labelService = _ref.read(labelServiceProvider);
    final callFilterConfig = await _ref.read(callFilterConfigProvider.future);
    final currentLocale = await _ref.read(localeProvider.future);

    ParsedPhoneNumber parsedEntity = ParsedPhoneNumber.empty;
    try {
      parsedEntity = await PhoneUtils.parsePhoneNumberEntity(target);
      if (!parsedEntity.isValid && countryIso != null && countryIso.isNotEmpty) {
        parsedEntity = await PhoneUtils.parsePhoneNumberWithIsoEntity(target, countryIso);
      }
    } catch (_) {}

    final effectiveCountryCode = parsedEntity.countryCode.isNotEmpty ? parsedEntity.countryCode : (countryIso ?? '');
    final queryNumberStr = parsedEntity.e164Number.isNotEmpty ? parsedEntity.e164Number : target;
    final number = vo.PhoneNumber.fromString(queryNumberStr);
    final rawNumber = vo.PhoneNumber.fromString(target);

    final dlibLocale = Locale(
      language: currentLocale.languageCode,
      country: effectiveCountryCode,
    );

    CallerIdData? callerIdData;
    try {
      callerIdData = await _identityService.getCallerId(number.value, dlibLocale);
    } catch (e) {
      debugPrint('[CallCoordinator] dryRun evaluate getCallerId fallback: $e');
      callerIdData = null;
    }

    var rules = await basicRuleFilterService.verifyAllRules(number);
    if (rules.isEmpty && number.value != rawNumber.value) {
      final fallbackRules = await basicRuleFilterService.verifyAllRules(rawNumber);
      rules = [...rules, ...fallbackRules];
    }

    PhoneContactEntry? matchedContact;
    try {
      matchedContact = await contactService.findContactByPhoneNumber(number);
      if (matchedContact == null && number.value != rawNumber.value) {
        matchedContact = await contactService.findContactByPhoneNumber(rawNumber);
      }
    } catch (_) {
      matchedContact = null;
    }

    LabelPhoneEntry? matchedLabel;
    try {
      matchedLabel = await labelService.getLabelByPhoneNumberString(number.value);
      if (matchedLabel == null && number.value != rawNumber.value) {
        matchedLabel = await labelService.getLabelByPhoneNumberString(rawNumber.value);
      }
    } catch (_) {
      matchedLabel = null;
    }

    bool timeRuleHit = false;
    try {
      timeRuleHit = await timeInterceptorService.shouldIntercept(number.value);
      if (!timeRuleHit && number.value != rawNumber.value) {
        timeRuleHit = await timeInterceptorService.shouldIntercept(rawNumber.value);
      }
    } catch (_) {}

    bool localCountBlocked = false;
    try {
      localCountBlocked = !await localCountFilterService.shouldAcceptCall(number.value);
      if (!localCountBlocked && number.value != rawNumber.value) {
        localCountBlocked = !await localCountFilterService.shouldAcceptCall(rawNumber.value);
      }
    } catch (_) {}

    bool remoteNumberBlocked = false;
    try {
      remoteNumberBlocked = !await remoteNumberFilterService.shouldAcceptCall(number.value);
      if (!remoteNumberBlocked && number.value != rawNumber.value) {
        remoteNumberBlocked = !await remoteNumberFilterService.shouldAcceptCall(rawNumber.value);
      }
    } catch (_) {}

    final rulesMap = <String, bool>{
      'Allowed': rules.any((rule) => rule.actionType == 'allow'),
      'Blocked': rules.any((rule) => rule.actionType == 'block'),
      'Silenced': rules.any((rule) => rule.actionType == 'silence'),
      'None Action': rules.any((rule) => rule.actionType == 'none'),
      'Global Reject': callFilterConfig.rejectAllNumbers,
      'Blacklist': rules.any((rule) => rule.actionType == 'block'),
      'Whitelist': rules.any((rule) => rule.actionType == 'allow'),
      'Regex': rules.any((rule) => rule is RegexRuleEntity),
      'Time Rules': timeRuleHit,
      'Local Count Filter': localCountBlocked,
      'Remote Number Filter': remoteNumberBlocked,
    };

    return CallEvaluationReport(
      callerIdData: callerIdData,
      matchedContact: matchedContact,
      matchedLabel: matchedLabel,
      rulesResults: rulesMap,
    );
  }

  /// 模拟触发悬浮窗效果测试 (Overlay)
  Future<void> simulateOverlay(CallerIdData data) async {
    final handler = await _ref.read(overlayHandlerProvider.future);
    await handler.showCallerIdOverlay(data, null, null);
  }

  /// 关闭悬浮窗 (Close Overlay)
  Future<void> closeOverlay() async {
    final handler = await _ref.read(overlayHandlerProvider.future);
    await handler.hideCallerIdOverlay();
  }

  /// 模拟触发 Live Activity / 灵动岛效果测试
  Future<void> simulateLiveActivity(CallerIdData data) async {
    final liveActivityHandler = await _ref.read(kitLiveActivityHandlerProvider.future);
    await liveActivityHandler.showCallerIdActivity(
      callerIdData: data,
      simCardData: null,
      stirData: null,
    );
  }

  /// 模拟触发系统本地通知效果测试 (Notification)
  Future<void> simulateNotification(CallerIdData data) async {
    final notificationHandler = _ref.read(notificationHandlerProvider);
    await notificationHandler.showCallerIdNotification(
      callerIdData: data,
      simInfo: null,
      stirInfo: null,
    );
  }

  /// 模拟触发当前配置模式测试 (Configured Display Mode)
  Future<void> simulateDefaultDisplayMode(CallerIdData data) async {
    final displayHandler = await _ref.read(displayModeHandlerProvider.future);
    await displayHandler.handleDisplayMode(data);
  }

  void dispose() {
    _subscription?.cancel();
    _identitySubscription?.cancel();
  }
}
