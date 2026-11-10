import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';

/// 规则数据状态的Notifier
class RulesNotifier extends AsyncNotifier<List<PhoneRuleEntity>> {
  late final RuleRepository _ruleRepository;

  @override
  Future<List<PhoneRuleEntity>> build() async {
    _initRepository();
    return _loadRules();
  }

  void _initRepository() {
    _ruleRepository = ref.read(ruleRepositoryProvider);
  }

  Future<List<PhoneRuleEntity>> _loadRules() async {
    try {
      return await _ruleRepository.getAllRules();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<void> addRule(PhoneRuleEntity rule) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.savePhoneRule(rule);
      state = AsyncValue.data(await _loadRules());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateRule(PhoneRuleEntity rule) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.savePhoneRule(rule);
      state = AsyncValue.data(await _loadRules());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteRule(String ruleId) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.deletePhoneRule(ruleId);
      state = AsyncValue.data(await _loadRules());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final rulesProvider = AsyncNotifierProvider<RulesNotifier, List<PhoneRuleEntity>>(() {
  return RulesNotifier();
});
