import 'package:yourcallyourrule/core/base/base_service.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/%E5%A4%87%E4%BB%BD/blacklist_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/rule/whitelist_rule.dart';
import 'package:yourcallyourrule/core/entities/sms/keyword_rule.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';

/// 短信过滤服务基类
abstract class SmsFilterService<T extends RuleBase> extends ListService {
  final RuleImportExportService _importExportService;

  SmsFilterService(RuleRepository super.repository)
      : _importExportService = RuleImportExportService(repository);

  Future<void> addRule(String value, String name, RuleAction action);
  Future<List<T>> getRulesByAction(RuleAction action);
}

/// 电话号码过滤服务（继承自BlacklistWhitelistService）
class PhoneNumberFilterService extends BlacklistWhitelistService {
  PhoneNumberFilterService(super.repository);

  @override
  Future<void> addToBlacklist(ListEntry entry) async {
    final rule = BlacklistRule(
      id: '',
      name: entry.name,
      priority: const RulePriority(3),
      phoneNumber: entry.phoneNumber,
      label: entry.label,
      avatar: entry.avatar,
    );
    await _ruleRepository.saveRule(rule);
  }

  @override
  Future<void> addToWhitelist(ListEntry entry) async {
    final rule = WhitelistRule(
      id: '',
      name: entry.name,
      priority: const RulePriority(7),
      phoneNumber: entry.phoneNumber,
      label: entry.label,
      avatar: entry.avatar,
    );
    await _ruleRepository.saveRule(rule);
  }
}

/// 关键词过滤服务
class KeywordFilterService extends SmsFilterService<KeywordRule> {
  KeywordFilterService(super.repository);

  @override
  Future<void> addRule(String keyword, String name, RuleAction action) async {
    final rule = KeywordRule(
      id: '',
      name: name,
      keyword: keyword,
      action: action,
      priority: action == RuleAction.block 
        ? const RulePriority(4) 
        : const RulePriority(6),
    );
    await _ruleRepository.saveRule(rule);
  }

  @override
  Future<List<KeywordRule>> getRulesByAction(RuleAction action) async {
    final rules = await _ruleRepository.getRulesByType(KeywordRule.ruleType);
    return rules.whereType<KeywordRule>()
                .where((r) => r.action == action)
                .toList();
  }

  Future<bool> containsKeyword(String content) async {
    final rules = await getAllRules();
    return rules.any((r) => content.contains(r.keyword));
  }

  Future<List<KeywordRule>> getAllRules() async {
    return (await _ruleRepository.getRulesByType(KeywordRule.ruleType))
           .whereType<KeywordRule>().toList();
  }
}