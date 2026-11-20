import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_call_filter_protocol/pyro_phone_call_filter_protocol.dart';
import 'package:yourcallyourrule/core/database/entity_store.dart';
import 'package:yourcallyourrule/core/database/entity_store_provider.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

part 'basic_rule_filter_service.g.dart';

@Riverpod(keepAlive: true)
BasicRuleFilterService basicRuleFilterService(Ref ref) {
  final phoneRuleStore = getEntityStore<PhoneRuleEntity>(ref);
  final regexRuleStore = getEntityStore<RegexRuleEntity>(ref);
  return BasicRuleFilterService(
    phoneRuleStore: phoneRuleStore,
    regexRuleStore: regexRuleStore,
  );
}

/// 基础规则过滤服务 (实现 CallFilterInterface 契约，专职号码与正则黑白名单判定)
class BasicRuleFilterService implements CallFilterInterface {
  final EntityStore<PhoneRuleEntity> _phoneRuleStore;
  final EntityStore<RegexRuleEntity> _regexRuleStore;

  BasicRuleFilterService({
    required EntityStore<PhoneRuleEntity> phoneRuleStore,
    required EntityStore<RegexRuleEntity> regexRuleStore,
  })  : _phoneRuleStore = phoneRuleStore,
        _regexRuleStore = regexRuleStore;

  @override
  CallFilterType get filterType => CallFilterType.basicRule;

  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr, {dynamic simInfo}) async {
    final phoneNumber = PhoneNumber.fromString(phoneNumberStr);

    final phoneRules = await _phoneRuleStore.getAll();
    final matchedRules = phoneRules.where((r) => r.phoneNumber == phoneNumber.value && r.isEnabled).toList();

    if (matchedRules.isNotEmpty) {
      matchedRules.sort((a, b) => b.priority.compareTo(a.priority));
      for (final rule in matchedRules) {
        if (rule.isBlockAction) {
          return false;
        }
        if (rule.isAllowAction) {
          return true;
        }
      }
    }

    final regexRules = await _regexRuleStore.getAll();
    final enabledRegexRules = regexRules.where((r) => r.isEnabled).toList();
    if (enabledRegexRules.isNotEmpty) {
      enabledRegexRules.sort((a, b) => b.priority.compareTo(a.priority));
      for (final rule in enabledRegexRules) {
        if (rule.matches(phoneNumberStr)) {
          if (rule.isBlockAction) return false;
          if (rule.isAllowAction) return true;
        }
      }
    }

    return true;
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
  Future<void> initialize() async {}
}
