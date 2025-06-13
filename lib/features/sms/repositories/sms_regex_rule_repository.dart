import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';

class SmsRegexRuleRepository implements BaseRepository<SmsRegexRule, String> {
  final RuleRepository _ruleRepository;

  SmsRegexRuleRepository(this._ruleRepository);

  @override
  Future<int> count() async {
    return (await _ruleRepository.getRulesByType(SmsRegexRule.ruleType)).length;
  }

  @override
  Future<bool> delete(SmsRegexRule entity) async {
    return _ruleRepository.delete(entity);
  }

  @override
  Future<bool> deleteAll(List<SmsRegexRule> entities) async {
    return _ruleRepository.deleteAll(entities);
  }

  @override
  Future<bool> deleteById(String id) async {
    return _ruleRepository.deleteById(id);
  }

  @override
  Future<bool> exists(String id) async {
    return _ruleRepository.exists(id);
  }

  @override
  SmsRegexRule fromMap(Map<String, dynamic> map) {
    return SmsRegexRule.fromMap(map);
  }

  @override
  Future<List<SmsRegexRule>> getAll() async {
    final rules = await _ruleRepository.getRulesByType(SmsRegexRule.ruleType);
    return rules.whereType<SmsRegexRule>().toList();
  }

  @override
  Future<SmsRegexRule?> getById(String id) async {
    final rule = await _ruleRepository.getById(id);
    return rule is SmsRegexRule ? rule : null;
  }

  @override
  Future<SmsRegexRule> save(SmsRegexRule entity) async {
    return _ruleRepository.save(entity) as SmsRegexRule;
  }

  @override
  Future<List<SmsRegexRule>> saveAll(List<SmsRegexRule> entities) async {
    final savedRules = await _ruleRepository.saveAll(entities);
    return savedRules.whereType<SmsRegexRule>().toList();
  }

  @override
  Future<SmsRegexRule> update(SmsRegexRule entity) async {
    return _ruleRepository.update(entity) as SmsRegexRule;
  }
}