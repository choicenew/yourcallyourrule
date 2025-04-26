import 'package:yourcallyourrule/core/entities/regex/regex_pattern.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

/// 正则规则服务类，继承自ListService，提供正则规则的管理功能
/// 包括添加、删除、查询正则规则等操作
class RegexService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;

  RegexService(this._ruleRepository)
      : _importExportService = RuleImportExportService(_ruleRepository),
        super(_ruleRepository);

  // 添加模式有效性检查
  Future<void> addRegexRule(RegExPattern pattern) async {
    if (!pattern.isValid) {
      throw FormatException('无效的正则表达式: ${pattern.pattern}');
    }

    final rule = RegexRule(
      id: '',
      name: pattern.name,
      pattern: pattern.pattern,
      action: pattern.action,
    );
    await _ruleRepository.saveRule(rule);
  }

  // 使用现有的导入导出方法
  Future<List<RuleBase>> importRegexRulesFromFile(String filePath,
      {bool overwrite = false}) async {
    return _importExportService.importFromFile(filePath, mode: overwrite ? ImportMode.overwrite : ImportMode.merge);
  }

  Future<bool> exportRegexRulesToFile(String filePath) async {
    final rules = await getAllRegexRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  Future<void> toggleRegexRule(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as RegexRule?;
    if (rule != null) {
      final updatedRule = rule.copyWith(isEnabled: isEnabled);
      await _ruleRepository.updateRule(updatedRule);
    }
  }

  /// 删除正则规则
  Future<void> removeRegexRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  /// 获取所有正则规则
  Future<List<RegexRule>> getAllRegexRules() async {
    final rules = await _ruleRepository.getRulesByType(RegexRule.ruleType);
    return rules.whereType<RegexRule>().toList();
  }

  /// 根据动作类型获取正则规则
  Future<List<RegexRule>> getRegexRulesByAction(RuleAction action) async {
    final rules = await getAllRegexRules();
    return rules.where((rule) => rule.action == action).toList();
  }

  /// 更新正则规则
  Future<void> updateRegexRule(RegexRule rule) async {
    await _ruleRepository.updateRule(rule);
  }

  /// 检查电话号码是否匹配任何正则规则
  /// 返回匹配的规则和对应的动作
  Future<Map<RegexRule, RuleAction>?> matchPhoneNumber(
      PhoneNumber phoneNumber) async {
    final rules = await getAllRegexRules();
    final enabledRules = rules.where((rule) => rule.isEnabled).toList();

    for (final rule in enabledRules) {
      try {
        final regex = RegExp(rule.pattern);
        if (regex.hasMatch(phoneNumber.value)) {
          return {rule: rule.action};
        }
      } catch (e) {
        // 处理无效的正则表达式
        continue;
      }
    }

    return null;
  }

  /// 验证正则表达式是否有效
  bool isValidRegex(String pattern) {
    try {
      RegExp(pattern);
      return true;
    } catch (e) {
      return false;
    }
  }
}
