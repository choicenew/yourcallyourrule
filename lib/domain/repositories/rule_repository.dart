import '../entities/rule/rule_base.dart';
import 'base_repository.dart';

/// 规则仓库接口
/// 定义规则相关的数据操作
abstract class RuleRepository extends BaseRepository<RuleBase> {
  /// 获取所有启用的规则
  Future<List<RuleBase>> getAllEnabled();
  
  /// 根据优先级获取规则
  Future<List<RuleBase>> getByPriority(String priorityName);
  
  /// 根据动作获取规则
  Future<List<RuleBase>> getByAction(String actionValue);
  
  /// 根据电话号码匹配规则
  Future<List<RuleBase>> matchByPhoneNumber(String phoneNumber);
  
  /// 导入规则
  Future<int> importRules(List<RuleBase> rules);
  
  /// 导出规则
  Future<List<RuleBase>> exportRules();
}