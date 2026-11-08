import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/features/common/entities/list_entry.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/rules/services/import_export_service.dart';
import 'package:yourcallyourrule/features/common/services/list_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';

part 'allowed_blocked_service.g.dart';

/// AllowedBlockedService �?@Riverpod Provider
@Riverpod(keepAlive: true)
AllowedBlockedService allowedBlockedService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  return AllowedBlockedService(ruleRepository);
}

// 重构后的允许/阻止规则服务
class AllowedBlockedService extends ListService {
  final RuleRepository _ruleRepository;
  final RuleImportExportService _importExportService;

  AllowedBlockedService(this._ruleRepository) : 
    _importExportService = RuleImportExportService(_ruleRepository),
    super(_ruleRepository);

  /// 获取导入导出服务
  RuleImportExportService get importExportService => _importExportService;
  // 添加允许/阻止规则
  Future<void> addAllowedBlockedRule(ListEntry entry, RuleAction action) async {
    final rule = AllowedBlockedRule(
      id: const Uuid().v4(), // 使用UUID生成ID
      name: entry.name,
      action: action,
      phoneNumber: entry.phoneNumber,
      labelId: entry.labelId,
      avatar: entry.avatar,
      // isSubscribed �?count 会使用默认�?
    );
    await _ruleRepository.saveRule(rule);
  }

  // 获取所有允许规�?
  Future<List<AllowedBlockedRule>> getAllAllowedRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.allow.toString());
    return rules.whereType<AllowedBlockedRule>().toList();
  }

  // 获取所有阻止规�?
  Future<List<AllowedBlockedRule>> getAllBlockedRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.block.toString());
    return rules.whereType<AllowedBlockedRule>().toList();
  }
  
  // 获取所有静音规�?
  Future<List<AllowedBlockedRule>> getAllSilenceRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.silence.toString());
    return rules.whereType<AllowedBlockedRule>().toList();
  }
  
  // 获取所有无动作规则
  Future<List<AllowedBlockedRule>> getAllNoneRules() async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.none.toString());
    return rules.whereType<AllowedBlockedRule>().toList();
  }
  
  // 获取所有规则（按动作类型分类）
  Future<List<AllowedBlockedRule>> getAllRulesByActionType(RuleActionType? actionType) async {
    if (actionType == null) {
      // 获取所有规�?
      final rules = await _ruleRepository.getAll();
      return rules.whereType<AllowedBlockedRule>().toList();
    } else {
      // 获取特定动作类型的规�?
      final rules = await _ruleRepository.getRulesByType(RuleAction(type: actionType).toString());
      return rules.whereType<AllowedBlockedRule>().toList();
    }
  }

  // 切换规则状�?
  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    final rule = await _ruleRepository.getRuleById(ruleId) as AllowedBlockedRule?;
    if (rule != null) {
      // AllowedBlockedRule 需要一�?copyWith 方法，或者手动创建新实例
      final updatedRule = AllowedBlockedRule(
        id: rule.id,
        name: rule.name,
        action: rule.action,
        phoneNumber: rule.phoneNumber,
        labelId: rule.labelId,
        priority: rule.priority,
        isEnabled: isEnabled, // 更新状�?
        subscriptionId: rule.subscriptionId, // 使用subscriptionId而不是isSubscribed
        count: rule.count,
        avatar: rule.avatar,
      );
      await _ruleRepository.updateRule(updatedRule);
    }
  }

  // 删除规则
  Future<void> removeRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }

  // 检查号码是否被允许
  Future<bool> isInAllowed(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.allow.toString());
    return rules.whereType<AllowedBlockedRule>().any((r) => r.phoneNumber.value == phoneNumber.value && r.isEnabled);
  }

  // 检查号码是否被阻止
  Future<bool> isInBlocked(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.block.toString());
    return rules.whereType<AllowedBlockedRule>().any((r) => r.phoneNumber.value == phoneNumber.value && r.isEnabled);
  }
  
  // 获取匹配指定号码的阻止规�?
  Future<List<AllowedBlockedRule>> getBlockedRules(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.block.toString());
    return rules
        .whereType<AllowedBlockedRule>()
        .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
        .toList();
  }

  // 获取匹配指定号码的允许规�?
  Future<List<AllowedBlockedRule>> getAllowedRules(PhoneNumber phoneNumber) async {
    final rules = await _ruleRepository.getRulesByType(RuleAction.allow.toString());
    return rules
        .whereType<AllowedBlockedRule>()
        .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
        .toList();
  }

  // 获取匹配指定号码的指定动作类型的规则
  // 如果action为null，则返回所有匹配的规则，不考虑动作类型
  Future<List<AllowedBlockedRule>> getRulesByActionType(PhoneNumber phoneNumber, RuleAction? action) async {
    if (action == null) {
      // 获取所有规�?
      final rules = await _ruleRepository.getAll();
      return rules
          .whereType<AllowedBlockedRule>()
          .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
          .toList();
    } else {
      // 获取特定动作类型的规�?
      final rules = await _ruleRepository.getRulesByType(action.toString());
      return rules
          .whereType<AllowedBlockedRule>()
          .where((rule) => rule.phoneNumber.value == phoneNumber.value && rule.isEnabled)
          .toList();
    }
  }

  // 更新允许/阻止规则
  Future<void> updateAllowedBlockedRule(AllowedBlockedRule rule) async {
    await _ruleRepository.updateRule(rule);
  }

  // 根据动作类型筛选规�?
  Future<List<RuleBase>> getRulesByAction(RuleAction action) async {
    final allowed = await getAllAllowedRules();
    final blocked = await getAllBlockedRules();
    return [
      ...allowed.where((r) => r.action == action),
      ...blocked.where((r) => r.action == action)
    ];
  }

  // 导出允许规则到文�?
  Future<bool> exportAllowedRulesToFile(String filePath) async {
    final rules = await getAllAllowedRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  // 导出阻止规则到文�?
  Future<bool> exportBlockedRulesToFile(String filePath) async {
    final rules = await getAllBlockedRules();
    return await _importExportService.exportToFile(filePath, entities: rules);
  }

  // 从文件导入允许规�?
  Future<List<RuleBase>> importAllowedRulesFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(filePath, mode: overwrite ? ImportMode.overwrite : ImportMode.merge);
    // 过滤出允许规�?
    return rules.whereType<AllowedBlockedRule>().where((r) => r.action == RuleAction.allow).toList();
  }

  // 从文件导入阻止规�?
  Future<List<RuleBase>> importBlockedRulesFromFile(String filePath, {bool overwrite = false}) async {
    final rules = await _importExportService.importFromFile(filePath, mode: overwrite ? ImportMode.overwrite : ImportMode.merge);
    // 过滤出阻止规�?
    return rules.whereType<AllowedBlockedRule>().where((r) => r.action == RuleAction.block).toList();
  }

  // 从URL导入允许规则
  Future<List<RuleBase>> importAllowedRulesFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<AllowedBlockedRule>().where((r) => r.action == RuleAction.allow).toList();
  }

  // 从URL导入阻止规则
  Future<List<RuleBase>> importBlockedRulesFromUrl(String url) async {
    final rules = await _importExportService.importFromUrl(url);
    return rules.whereType<AllowedBlockedRule>().where((r) => r.action == RuleAction.block).toList();
  }

  // 获取所有标�?
  Future<List<String>> getAllLabels() async {
    final rules = await _ruleRepository.getAll(); // 使用BaseRepository中定义的getAll方法
    final labels = <String>{};
    for (final rule in rules) {
      if (rule is AllowedBlockedRule) {
        labels.add(rule.labelId);
      }
    }
    
    return labels.toList();
  }

  // 获取所有允�?阻止规则（包括所有动作类型）
  Future<List<AllowedBlockedRule>> getAllAllowedBlockedRules() async {
    // 使用已有的方法获取所有规�?
    return await getAllRulesByActionType(null);
  }
}