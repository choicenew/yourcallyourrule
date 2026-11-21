import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';

part 'rules_provider.g.dart';

@Riverpod(keepAlive: true)
class RulesNotifier extends _$RulesNotifier {
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
      return await _ruleRepository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  Future<void> addRule(PhoneRuleEntity rule) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.saveRule(rule);
      state = AsyncValue.data(await _loadRules());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateRule(PhoneRuleEntity rule) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.saveRule(rule);
      state = AsyncValue.data(await _loadRules());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteRule(String ruleId) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.deleteRule(ruleId);
      state = AsyncValue.data(await _loadRules());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
