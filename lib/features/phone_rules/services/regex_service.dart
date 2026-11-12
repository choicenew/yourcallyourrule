import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';

part 'regex_service.g.dart';

/// RegexService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
RegexService regexService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return RegexService(ruleRepository);
}

/// 正则规则服务类，提供正则规则的管理功能
class RegexService {
  final RuleRepository _ruleRepository;
  final Uuid _uuid = const Uuid();

  RegexService(this._ruleRepository);

  Future<void> addRegexRule(String name, String pattern, RuleAction action) async {
    if (!isValidRegex(pattern)) {
      throw FormatException('无效的正则表达式: $pattern');
    }

    final rule = RegexRuleEntity(
      id: _uuid.v4(),
      name: name,
      pattern: pattern,
      actionType: action.type.name,
    );
    await _ruleRepository.saveRegexRule(rule);
  }

  Future<void> removeRegexRule(String ruleId) async {
    await _ruleRepository.deleteRegexRule(ruleId);
  }

  Future<List<RegexRuleEntity>> getAllRegexRules() async {
    return await _ruleRepository.getAllRegexRules();
  }

  Future<List<RegexRuleEntity>> getMatchingRegexRulesByActionType(String phoneNumberStr, RuleAction? action) async {
    final rules = await getAllRegexRules();
    return rules.where((rule) {
      if (!rule.isEnabled) return false;
      final matchesAction = action == null || rule.actionType == action.type.name;
      if (!matchesAction) return false;
      return rule.matches(phoneNumberStr);
    }).toList();
  }

  Future<void> updateRegexRule(RegexRuleEntity rule) async {
    await _ruleRepository.saveRegexRule(rule);
  }

  bool isValidRegex(String pattern) {
    try {
      RegExp(pattern);
      return true;
    } catch (_) {
      return false;
    }
  }
}
