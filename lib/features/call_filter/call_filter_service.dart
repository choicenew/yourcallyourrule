import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/core/database/entity_store.dart';
import 'package:yourcallyourrule/core/database/entity_store_provider.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/call_filter/config/call_filter_config.dart';
import 'providers/call_filter_provider.dart';

part 'call_filter_service.g.dart';

/// CallFilterService Riverpod Provider (完全解耦，零横向 rules import)
@riverpod
CallFilterService callFilterService(Ref ref) {
  final phoneRuleStore = getEntityStore<PhoneRuleEntity>(ref);
  final regexRuleStore = getEntityStore<RegexRuleEntity>(ref);
  return CallFilterService(
    phoneRuleStore: phoneRuleStore,
    regexRuleStore: regexRuleStore,
    getConfigForSim: (simSlotIndex) async {
      if (simSlotIndex != null) {
        return await ref.read(simSlotCallFilterConfigProvider(simSlotIndex).future);
      }
      return await ref.read(callFilterConfigProvider.future);
    },
  );
}

/// 通话过滤服务 (零跨 Feature 依赖)
class CallFilterService implements CallFilterInterface {
  final EntityStore<PhoneRuleEntity> _phoneRuleStore;
  final EntityStore<RegexRuleEntity> _regexRuleStore;
  final Future<CallFilterConfig> Function(int? simSlotIndex) _getConfigForSim;

  CallFilterService({
    required EntityStore<PhoneRuleEntity> phoneRuleStore,
    required EntityStore<RegexRuleEntity> regexRuleStore,
    required Future<CallFilterConfig> Function(int? simSlotIndex) getConfigForSim,
  })  : _phoneRuleStore = phoneRuleStore,
        _regexRuleStore = regexRuleStore,
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

    final phoneRules = await _phoneRuleStore.getAll();
    final matchedRules = phoneRules.where((r) => r.phoneNumber == phoneNumber.value && r.isEnabled).toList();

    if (config.allowAllAllowedNumbers) {
      final isAllowed = matchedRules.any((r) => r.actionType == 'allow');
      if (isAllowed) return true;
    }

    if (config.allowAllBlockRules) {
      final isBlocked = matchedRules.any((r) => r.actionType == 'block');
      if (isBlocked) return false;
    }

    if (matchedRules.isNotEmpty) {
      matchedRules.sort((a, b) => b.priority.compareTo(a.priority));
      final topRule = matchedRules.first;
      if (topRule.actionType == 'block') return false;
      if (topRule.actionType == 'allow') return true;
    }

    if (config.allowRegexAllowRules || config.allowRegexBlockRules) {
      final regexRules = await _regexRuleStore.getAll();
      final enabledRegexRules = regexRules.where((r) => r.isEnabled).toList();
      for (final rule in enabledRegexRules) {
        if (rule.matches(phoneNumberStr)) {
          final actionType = rule.actionType;
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

  Future<List<PhoneRuleEntity>> verifyAllRules(PhoneNumber number) async {
    final phoneRules = await _phoneRuleStore.getAll();
    final matchedPhoneRules = phoneRules.where((r) => r.phoneNumber == number.value && r.isEnabled).toList();

    final regexRules = await _regexRuleStore.getAll();
    final matchedRegex = regexRules.where((r) => r.isEnabled && r.matches(number.value)).toList();

    final convertedRegex = matchedRegex.map((r) => PhoneRuleEntity(
      id: r.id,
      name: r.name,
      phoneNumber: number.value,
      actionType: r.actionType,
      priority: r.priority,
      isEnabled: r.isEnabled,
    )).toList();

    return [...matchedPhoneRules, ...convertedRegex];
  }

  @override
  Future<void> initialize() async {
    return;
  }
}
