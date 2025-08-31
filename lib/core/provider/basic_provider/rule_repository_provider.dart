import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_phone_rule_datasource_provider.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_regex_rule_datasource_provider.dart';
import 'package:yourcallyourrule/data/datasources/local/local_phone_rule_datasource.dart';
import 'package:yourcallyourrule/data/datasources/local/local_regex_rule_datasource.dart';
import 'package:yourcallyourrule/data/models/allow_block_rule_model.dart';
import 'package:yourcallyourrule/data/models/phone_rule_model.dart';
import 'package:yourcallyourrule/data/models/regex_rule_model.dart';
import 'package:yourcallyourrule/data/models/rule_model.dart';

/// 规则仓库提供者
final ruleRepositoryProvider = Provider<RuleRepository>((ref) {
  final localPhoneRuleDataSource = ref.watch(localPhoneRuleDataSourceProvider);
  final localRegexRuleDataSource = ref.watch(localRegexRuleDataSourceProvider);
  // 返回规则仓库实现
  return RuleRepositoryImpl(
    localPhoneRuleDataSource,
    localRegexRuleDataSource,
  );
});

/// 规则仓库实现类
class RuleRepositoryImpl implements RuleRepository {
  final LocalPhoneRuleDataSource _localPhoneRuleDataSource;
  final LocalRegexRuleDataSource _localRegexRuleDataSource;

  RuleRepositoryImpl(
    this._localPhoneRuleDataSource,
    this._localRegexRuleDataSource,
  );

  @override
  RuleBase createEmptyRule() {
    throw UnimplementedError();
  }

  @override
  RuleBase createRuleFromMap(Map<String, dynamic> map) {
    final ruleType = map['ruleType'] as String;
    
    switch (ruleType) {
      case 'phone_rule':
      case 'white_black': // 兼容旧数据
        return PhoneRule.fromMap(map);
      case 'regex':
        return RegexRule.fromMap(map);
      case 'alloworblock':
      case 'allow_block':
        return AllowedBlockedRule.fromMap(map);
      default:
        throw Exception('Unknown rule type: $ruleType');
    }
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    await deleteById(ruleId);
  }

  Future<List<RuleBase>> getAllByType(String type) async {
    final result = <RuleBase>[];
    
    if (type == 'phone_rule') {
      final rules = await _localPhoneRuleDataSource.getAll();
      result.addAll(rules.map((model) => createRuleFromMap(model.toMap())));
    } else if (type == 'regex') {
      final rules = await _localRegexRuleDataSource.getAll();
      result.addAll(rules.map((model) => createRuleFromMap(model.toMap())));
    }
    
    return result;
  }

  @override
  Future<List<RuleBase>> getAllDisabled() async {
    final allRules = await getAll();
    return allRules.where((rule) => !rule.isEnabled).toList();
  }

  @override
  Future<List<RuleBase>> getAllEnabled() async {
    final allRules = await getAll();
    return allRules.where((rule) => rule.isEnabled).toList();
  }

  @override
  Future<List<RuleBase>> getAll() async {
    // 从所有数据源获取规则
    final phoneRules = await _localPhoneRuleDataSource.getAll();
    final regexRules = await _localRegexRuleDataSource.getAll();
    
    // 将所有规则模型转换为RuleBase实体
    final result = <RuleBase>[];
    
    // 添加电话规则
    result.addAll(phoneRules.map((model) => createRuleFromMap(model.toMap())));
    
    // 添加正则规则
    result.addAll(regexRules.map((model) => createRuleFromMap(model.toMap())));
    
    return result;
  }

  @override
  Future<RuleBase?> getById(String id) async {
    // 依次从各个数据源查找规则
    var phoneRule = await _localPhoneRuleDataSource.getById(id);
    if (phoneRule != null) {
      return createRuleFromMap(phoneRule.toMap());
    }
    
    var regexRule = await _localRegexRuleDataSource.getById(id);
    if (regexRule != null) {
      return createRuleFromMap(regexRule.toMap());
    }
    
    return null;
  }

  @override
  Future<RuleBase?> getRuleById(String ruleId) async {
    return getById(ruleId);
  }

  @override
  Future<List<RuleBase>> getRulesByType(String type) async {
    return getAllByType(type);
  }

  @override
  Future<RuleBase> save(RuleBase entity) async {
    // 根据规则类型选择不同的数据源
    if (entity is PhoneRule) {
      final phoneRuleModel = PhoneRuleModel.fromEntity(entity);
      await _localPhoneRuleDataSource.insert(phoneRuleModel);
    } else if (entity is RegexRule) {
      final regexRuleModel = RegexRuleModel.fromEntity(entity);
      await _localRegexRuleDataSource.insert(regexRuleModel);
    }
    return entity;
  }

  // 已移除 _createModelFromMap 方法，不再需要

  @override
  Future<bool> saveRule(RuleBase rule) async {
    try {
      // 根据规则类型选择不同的数据源
      if (rule is PhoneRule) {
        // 使用copyWith创建新的规则对象，设置正确的ruleType
        final updatedRule = rule.copyWith(ruleType: 'phone_rule');
        final phoneRuleModel = PhoneRuleModel.fromEntity(updatedRule);
        await _localPhoneRuleDataSource.insert(phoneRuleModel);
      } else if (rule is RegexRule) {
        // 使用copyWith创建新的规则对象，设置正确的ruleType
        final updatedRule = rule.copyWith(ruleType: RegexRule.ruleType);
        final regexRuleModel = RegexRuleModel.fromEntity(updatedRule);
        await _localRegexRuleDataSource.insert(regexRuleModel);
      } else if (rule is AllowedBlockedRule) {
        // 将AllowedBlockedRule转换为PhoneRule并保存
        // 因为AllowedBlockedRule本质上也是基于电话号码的规则
        final phoneRule = PhoneRule(
          id: rule.id,
          name: rule.name,
          priority: rule.priority,
          action: rule.action,
          phoneNumber: rule.phoneNumber,
          labelId: rule.labelId,
          isEnabled: rule.isEnabled,
          count: rule.count,
          avatar: rule.avatar,
          ruleType: 'allow_block',
        );
        final phoneRuleModel = PhoneRuleModel.fromEntity(phoneRule);
        await _localPhoneRuleDataSource.insert(phoneRuleModel);
      } else {
        // 不支持其他类型的规则
        throw UnimplementedError('不支持的规则类型: ${rule.runtimeType}');
      }
      return true;
    } catch (e) {
      print('保存规则失败: $e');
      return false;
    }
  }

  @override
  Future<List<RuleBase>> searchByName(String name) async {
    final result = <RuleBase>[];
    
    // 从电话规则中搜索
    final phoneRules = await _localPhoneRuleDataSource.searchByName(name);
    result.addAll(phoneRules.map((model) => createRuleFromMap(model.toMap())));
    
    // 从正则规则中搜索
    final regexRules = await _localRegexRuleDataSource.searchByName(name);
    result.addAll(regexRules.map((model) => createRuleFromMap(model.toMap())));
    
    return result;
  }

  @override
  Future<RuleBase> update(RuleBase entity) async {
    // 根据规则类型选择不同的数据源进行更新
    if (entity is PhoneRule) {
      // 使用copyWith创建新的规则对象，设置正确的ruleType
      final updatedRule = entity.copyWith(ruleType: 'phone_rule');
      final phoneRuleModel = PhoneRuleModel.fromEntity(updatedRule);
      await _localPhoneRuleDataSource.update(phoneRuleModel);
    } else if (entity is RegexRule) {
      // 使用copyWith创建新的规则对象，设置正确的ruleType
      final updatedRule = entity.copyWith(ruleType: RegexRule.ruleType);
      final regexRuleModel = RegexRuleModel.fromEntity(updatedRule);
      await _localRegexRuleDataSource.update(regexRuleModel);
    } else {
      // 不支持其他类型的规则
      throw UnimplementedError('不支持的规则类型: ${entity.runtimeType}');
    }
    return entity;
  }

  @override
  Future<void> updateRule(RuleBase rule) async {
    await update(rule);
  }

  @override
  Future<RuleBase> updateEnabledStatus(String id, bool isEnabled) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found');
    }
    // 使用copyWith方法创建新的规则对象，而不是直接修改final字段
    final updatedRule = rule.copyWith(isEnabled: isEnabled);
    await update(updatedRule);
    return updatedRule;
  }

  @override
  Future<RuleBase> updatePriority(String id, int priority) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found');
    }
    // 使用copyWith方法创建新的规则对象，而不是直接修改final字段
    final updatedRule = rule.copyWith(priority: RulePriority.fromInt(priority));
    await update(updatedRule);
    return updatedRule;
  }

  @override
  Future<bool> delete(RuleBase entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    // 尝试从所有数据源删除规则
    try {
      await _localPhoneRuleDataSource.delete(id);
      await _localRegexRuleDataSource.delete(id);
      return true;
    } catch (e) {
      print('删除规则失败: $e');
      return false;
    }
  }

  @override
  Future<bool> deleteAll(List<RuleBase> entities) async {
    try {
      final ids = entities.map((e) => e.id).toList();
      // 从所有数据源删除规则
      await _localPhoneRuleDataSource.deleteAll(ids);
      await _localRegexRuleDataSource.deleteAll(ids);
      return true;
    } catch (e) {
      print('批量删除规则失败: $e');
      return false;
    }
  }

  @override
  Future<List<RuleBase>> saveAll(List<RuleBase> entities) async {
    // 按类型分组规则
    final phoneRules = <PhoneRuleModel>[];
    final regexRules = <RegexRuleModel>[];
    
    for (final rule in entities) {
      if (rule is PhoneRule) {
        // 使用copyWith创建新的规则对象，设置正确的ruleType
        final updatedRule = rule.copyWith(ruleType: 'phone_rule');
        final model = PhoneRuleModel.fromEntity(updatedRule);
        phoneRules.add(model);
      } else if (rule is RegexRule) {
        // 使用copyWith创建新的规则对象，设置正确的ruleType
        final updatedRule = rule.copyWith(ruleType: RegexRule.ruleType);
        final model = RegexRuleModel.fromEntity(updatedRule);
        regexRules.add(model);
      }
    }
    
    // 批量保存不同类型的规则
    if (phoneRules.isNotEmpty) {
      await _localPhoneRuleDataSource.insertAll(phoneRules);
    }
    
    if (regexRules.isNotEmpty) {
      await _localRegexRuleDataSource.insertAll(regexRules);
    }
    
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final rules = await getAll();
    return rules.length;
  }

  @override
  RuleBase fromMap(Map<String, dynamic> map) {
    return createRuleFromMap(map);
  }

  @override
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumberStr) {
    // Not applicable for local rules
    throw UnimplementedError();
  }

  @override
  Future<bool> syncRemoteNumbers() {
    // Not applicable for local rules
    throw UnimplementedError();
  }
}