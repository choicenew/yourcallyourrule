import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/call_filter_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/intercept_action.dart';

part 'call_filter_service.g.dart';

/// CallFilterService Riverpod Provider
@riverpod
CallFilterService callFilterService(Ref ref) {
  return CallFilterService(
    regexService: ref.watch(regexServiceProvider),
    allowedBlockedService: ref.watch(allowedBlockedServiceProvider),
    ruleManagementService: ref.watch(ruleManagementServiceProvider),
    getConfigForSim: (simSlotIndex) async {
      final separateSims = await ref.read(separateSimsProvider.future);
      if (separateSims && simSlotIndex != null) {
        return await ref.read(simSlotCallFilterConfigProvider(simSlotIndex).future);
      }
      return await ref.read(callFilterConfigProvider.future);
    },
  );
}

/// 通话过滤服务
class CallFilterService implements CallFilterInterface {
  final RegexService _regexService;
  final AllowedBlockedService _allowedBlockedService;
  final RuleManagementService _ruleManagementService;
  final Future<CallFilterConfig> Function(int? simSlotIndex) _getConfigForSim;

  CallFilterService({
    required RegexService regexService,
    required AllowedBlockedService allowedBlockedService,
    required RuleManagementService ruleManagementService,
    required Future<CallFilterConfig> Function(int? simSlotIndex) getConfigForSim,
  })  : _regexService = regexService,
        _allowedBlockedService = allowedBlockedService,
        _ruleManagementService = ruleManagementService,
        _getConfigForSim = getConfigForSim;

  @override
  CallFilterType get filterType => CallFilterType.basicRule;

  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr, {SimInfo? simInfo}) async {
    final config = await _getConfigForSim(simInfo?.simSlotIndex);
    final phoneNumber = PhoneNumber(phoneNumberStr);
    InterceptAction? interceptAction;

    if (config.rejectAllNumbers) {
      _setCurrentInterceptAction(null);
      debugPrint("rejectAllNumbers: ${config.rejectAllNumbers}");
      return false;
    }

    final matchingRules = await _getAllMatchingRules(phoneNumber);

    if (matchingRules.isEmpty) {
      return true;
    }

    matchingRules.sort((a, b) {
      final prioA = RulePriority.fromInt((a as dynamic).priority as int).value;
      final prioB = RulePriority.fromInt((b as dynamic).priority as int).value;
      return prioB.compareTo(prioA);
    });

    final highestPriorityRule = matchingRules.first as dynamic;
    final ruleAction = RuleAction.fromString(highestPriorityRule.actionType as String);

    switch (ruleAction.type) {
      case RuleActionType.allow:
        return true;
      case RuleActionType.block:
      case RuleActionType.silence:
        interceptAction = _getInterceptActionFromRule(ruleAction);
        _setCurrentInterceptAction(interceptAction);
        return false;
      case RuleActionType.none:
      default:
        return true;
    }
  }

  @override
  Future<void> initialize() async {
    return;
  }

  InterceptAction? _getInterceptActionFromRule(RuleAction action) {
    switch (action.type) {
      case RuleActionType.block:
        if (action.parameters == null || !action.parameters!.containsKey('interceptAction')) {
          return null;
        }
        final actionName = action.parameters!['interceptAction'] as String?;
        debugPrint("_getInterceptActionFromRule: $actionName");
        return actionName != null ? InterceptAction.values.byName(actionName) : null;
      case RuleActionType.silence:
        return InterceptAction.silenceNoAnswer;

      case RuleActionType.none:
      case RuleActionType.allow:
      default:
        return null;
    }
  }

  static InterceptAction? _currentInterceptAction;

  void _setCurrentInterceptAction(InterceptAction? action) {
    debugPrint("setCurrentInterceptAction: $action");
    _currentInterceptAction = action;
  }

  static InterceptAction? getCurrentInterceptAction() {
    return _currentInterceptAction;
  }

  Future<List<dynamic>> _getAllMatchingRules(PhoneNumber number) async {
    final String phoneNumberStr = number.value;
    List<dynamic> matchingRules = [];

    final allowedBlockedRules = await _allowedBlockedService.getRulesByActionType(number, null);
    matchingRules.addAll(allowedBlockedRules);

    final matchingRegexRules = await _regexService.getMatchingRegexRulesByActionType(phoneNumberStr, null);
    matchingRules.addAll(matchingRegexRules);

    final phoneRules = await _ruleManagementService.getRulesByActionType(number, null);
    matchingRules.addAll(phoneRules);

    return matchingRules;
  }

  Future<List<dynamic>> verifyAllRules(PhoneNumber number) async {
    final matchingRules = await _getAllMatchingRules(number);
    matchingRules.sort((a, b) {
      final prioA = RulePriority.fromInt((a as dynamic).priority as int).value;
      final prioB = RulePriority.fromInt((b as dynamic).priority as int).value;
      return prioB.compareTo(prioA);
    });
    return matchingRules;
  }
}
