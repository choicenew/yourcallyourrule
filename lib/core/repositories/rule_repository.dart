// 规则仓库接口，定义规则相关的数据操作方法

import '../entities/rule/rule_base.dart';
import 'base_repository.dart';

/// 规则仓库接口
abstract class RuleRepository extends BaseRepository<RuleBase, String> {
  /// 根据规则类型获取所有规则
  Future<List<RuleBase>> getAllByType(String type);
  
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