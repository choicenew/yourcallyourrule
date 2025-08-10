// 规则仓库接口，定义规则相关的数据操作方法

import '../entities/rule/rule_base.dart';
import 'base_repository.dart';

/// 规则仓库接口
abstract class RuleRepository extends BaseRepository<RuleBase, String> {
  /// 从Map创建规则实体
  RuleBase createRuleFromMap(Map<String, dynamic> map);

  /// 创建一个空的规则实例，用于模板或验证
  RuleBase createEmptyRule();

  /// 保存规则
  Future<void> saveRule(RuleBase rule);

  /// 删除规则
  Future<void> deleteRule(String ruleId);

  /// 更新规则
  Future<void> updateRule(RuleBase rule);

  /// 根据ID获取规则
  Future<RuleBase?> getRuleById(String ruleId);

  /// 根据类型获取规则
  Future<List<RuleBase>> getRulesByType(String type);
  
  /// 根据规则名称搜索规则
  Future<List<RuleBase>> searchByName(String name);
  
  /// 更新规则启用状态
  Future<RuleBase> updateEnabledStatus(String id, bool isEnabled);
  
  /// 更新规则优先级
  Future<RuleBase> updatePriority(String id, int priority);
  
  /// 获取所有启用的规则
  Future<List<RuleBase>> getAllEnabled();
  
  /// 获取所有禁用的规则
  Future<List<RuleBase>> getAllDisabled();
}