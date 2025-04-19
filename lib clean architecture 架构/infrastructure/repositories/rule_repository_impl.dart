import '../../domain/entities/rule/rule_base.dart';
import '../../domain/repositories/rule_repository.dart';
import '../../domain/value_objects/phone_number.dart';
import '../../domain/value_objects/rule_priority.dart';
import '../../domain/value_objects/rule_action.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/local/database/dao/rule_dao.dart';
import '../models/rule_model.dart';
import 'base_repository_impl.dart';

/// 规则仓库实现
/// 实现规则仓库接口，提供规则相关的数据操作
class RuleRepositoryImpl extends BaseRepositoryImpl<RuleBase, RuleDao> implements RuleRepository {
  RuleRepositoryImpl(AppDatabase database)
      : super(database, database.ruleDao);
  
  @override
  Future<List<RuleBase>> getByPriority(String priorityName) async {
    final priority = RulePriority.fromName(priorityName);
    return await dao.getByPriority(priority);
  }
  
  @override
  Future<List<RuleBase>> getByAction(String actionValue) async {
    final action = RuleAction.fromValue(actionValue);
    return await dao.getByAction(action.value);
  }
  
  @override
  Future<List<RuleBase>> matchByPhoneNumber(String phoneNumberValue) async {
    try {
      final phoneNumber = PhoneNumber(phoneNumberValue);
      return await dao.matchByPhoneNumber(phoneNumber.normalized);
    } catch (e) {
      // 如果电话号码格式无效，返回空列表
      return [];
    }
  }
  
  @override
  Future<List<RuleBase>> getAllEnabled() async {
    return await dao.getEnabled();
  }
  
  @override
  Future<bool> deleteRule(String id) async {
    try {
      await delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<void> updateRule(RuleBase rule) async {
    await update(rule);
  }
  
  @override
  Future<List<RuleBase>> getRules({String? ruleType, bool onlyEnabled = false}) async {
    if (ruleType != null) {
      return await dao.getByType(ruleType);
    } else if (onlyEnabled) {
      return await getAllEnabled();
    } else {
      return await getAll();
    }
  }
  
  @override
  Future<List<RuleBase>> exportRules() async {
    // 导出所有规则
    return await getAll();
  }
  
  @override
  Future<List<RuleBase>> importRules(List<dynamic> ruleDtos) async {
    final rules = <RuleBase>[];
    
    for (final dto in ruleDtos) {
      try {
        final ruleModel = RuleModel.fromDto(dto);
        final rule = ruleModel.toEntity();
        await add(rule);
        rules.add(rule);
      } catch (e) {
        // 跳过无效的规则
        continue;
      }
    }
    
    return rules;
  }
}