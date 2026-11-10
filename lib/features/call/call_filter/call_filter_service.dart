import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/regex_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/call/call_filter/config/call_filter_config.dart';
import 'providers/call_filter_provider.dart';

part 'call_filter_service.g.dart';

/// CallFilterService Riverpod Provider
@riverpod
CallFilterService callFilterService(Ref ref) {
  return CallFilterService(
    regexService: ref.watch(regexServiceProvider),
    allowedBlockedService: ref.watch(allowedBlockedServiceProvider),
    ruleManagementService: ref.watch(ruleManagementServiceProvider),
    getConfigForSim: (simSlotIndex) async {
      if (simSlotIndex != null) {
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
  Future<bool> shouldAcceptCall(String phoneNumberStr, {dynamic simInfo}) async {
    final phoneNumber = PhoneNumber.fromString(phoneNumberStr);
    final int? simSlotIndex = (simInfo is int) ? simInfo : (simInfo != null ? (simInfo as dynamic).simSlotIndex as int? : null);
    final config = await _getConfigForSim(simSlotIndex);

    if (config.rejectAllNumbers) {
      return false;
    }

    if (config.allowAllAllowedNumbers) {
      final allowed = await _allowedBlockedService.isInAllowed(phoneNumber);
      if (allowed) {
        return true;
      }
    }

    if (config.allowAllBlockRules) {
      final blocked = await _allowedBlockedService.isInBlocked(phoneNumber);
      if (blocked) {
        return false;
      }
    }

    final rules = await _ruleManagementService.getRulesByPhoneNumber(phoneNumber);
    if (rules.isNotEmpty) {
      final topRule = rules.first;
      if (topRule.actionType == 'block') return false;
      if (topRule.actionType == 'allow') return true;
    }

    if (config.allowRegexAllowRules || config.allowRegexBlockRules) {
      final regexRules = await _regexService.getAllRegexRules();
      for (final rule in regexRules) {
        if (rule.matches(phoneNumberStr)) {
          final map = rule.toMap();
          final actionType = map['actionType'] as String? ?? 'block';
          if (actionType == 'block') return false;
          if (actionType == 'allow') return true;
        }
      }
    }

    return true;
  }

  Future<bool> shouldAcceptCallWithSim(String phoneNumberStr, {dynamic simInfo}) {
    return shouldAcceptCall(phoneNumberStr, simInfo: simInfo);
  }

  @override
  Future<void> initialize() async {
    return;
  }
}
