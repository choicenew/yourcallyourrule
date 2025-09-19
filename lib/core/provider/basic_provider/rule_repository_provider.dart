import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_phone_rule_datasource_provider.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_regex_rule_datasource_provider.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_label_datasource_provider.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_sim_slot_rule_datasource_provider.dart';

/// 规则仓库提供者
final ruleRepositoryProvider = Provider<RuleRepository>((ref) {
  final localPhoneRuleDataSource = ref.watch(localPhoneRuleDataSourceProvider);
  final localRegexRuleDataSource = ref.watch(localRegexRuleDataSourceProvider);
  final localLabelDataSource = ref.watch(localLabelDataSourceProvider);
  final localSimSlotRuleDataSource = ref.watch(localSimSlotRuleDataSourceProvider);
  // 返回规则仓库实现
  return RuleRepositoryImpl(
    localPhoneRuleDataSource,
    localRegexRuleDataSource,
    localLabelDataSource,
    localSimSlotRuleDataSource,
  );
});


/*
///已经拆分出去了所以可以注释掉了
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
    // 获取所有规则
    final allRules = await getAll();
    
    // 根据类型过滤规则
    if (type == 'phone_rule') {
      // 只过滤PhoneRule类型，不需要排除AllowedBlockedRule
      // 因为AllowedBlockedRule和PhoneRule是平行的类型，没有继承关系
      return allRules.whereType<PhoneRule>().toList();
    } else if (type == 'regex') {
      return allRules.whereType<RegexRule>().toList();
    } else if (type == 'allow_block') {
      return allRules.whereType<AllowedBlockedRule>().toList();
    } else {
      // 处理基于动作类型的查询（如allow、block、silence、none等）
      // 这样设计更灵活，不需要硬编码所有可能的action类型
      return allRules.where((rule) => rule.action.toString() == type).toList();
    }
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
    // 使用工厂方法创建对应的模型
    try {
      final ruleModel = RuleModel.fromEntity(entity);
      
      // 根据模型类型选择不同的数据源进行保存
      if (ruleModel is PhoneBasedRuleModel) {
        // 使用PhoneBasedRuleModel作为基类，可以同时处理PhoneRuleModel和AllowedBlockedRuleModel
        await _localPhoneRuleDataSource.insert(ruleModel);
      } else if (ruleModel is RegexRuleModel) {
        await _localRegexRuleDataSource.insert(ruleModel);
      } else {
        // 不支持其他类型的规则
        throw UnimplementedError('不支持的规则模型类型: ${ruleModel.runtimeType}');
      }
      return entity;
    } catch (e) {
      debugPrint('保存规则失败: $e');
      rethrow;
    }
  }

  // 已移除 _createModelFromMap 方法，不再需要

  @override
  Future<bool> saveRule(RuleBase rule) async {
    try {
      // 直接调用save方法，避免代码重复
      await save(rule);
      return true;
    } catch (e) {
      debugPrint('保存规则失败: $e');
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
    // 使用工厂方法创建对应的模型
    try {
      final ruleModel = RuleModel.fromEntity(entity);
      
      // 根据模型类型选择不同的数据源进行更新
      if (ruleModel is PhoneBasedRuleModel) {
        // 使用PhoneBasedRuleModel作为基类，可以同时处理PhoneRuleModel和AllowedBlockedRuleModel
        await _localPhoneRuleDataSource.update(ruleModel);
      } else if (ruleModel is RegexRuleModel) {
        await _localRegexRuleDataSource.update(ruleModel);
      } else {
        // 不支持其他类型的规则
        throw UnimplementedError('不支持的规则模型类型: ${ruleModel.runtimeType}');
      }
      return entity;
    } catch (e) {
      debugPrint('更新规则失败: $e');
      rethrow;
    }
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
      debugPrint('删除规则失败: $e');
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
      debugPrint('批量删除规则失败: $e');
      return false;
    }
  }

  @override
  Future<List<RuleBase>> saveAll(List<RuleBase> entities) async {
    // 按类型分组规则
    final phoneRules = <PhoneRuleModel>[];
    final regexRules = <RegexRuleModel>[];
    
    try {
      for (final rule in entities) {
        final ruleModel = RuleModel.fromEntity(rule);
        
        if (ruleModel is PhoneRuleModel) {
          phoneRules.add(ruleModel);
        } else if (ruleModel is RegexRuleModel) {
          regexRules.add(ruleModel);
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
    } catch (e) {
      debugPrint('批量保存规则失败: $e');
      rethrow;
    }
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
*/