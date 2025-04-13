import '../../dto/rule_dto.dart';
import '../base_usecase.dart';
import '../../../domain/repositories/rule_repository.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../../../domain/entities/rule/regex_rule.dart';
import '../../../domain/value_objects/rule_priority.dart';
import '../../../domain/value_objects/rule_action.dart';
import '../../../domain/value_objects/phone_number.dart';

/// 获取规则用例
/// 用于获取规则列表
class GetRules implements UseCase<List<RuleDto>, GetRulesParams> {
  final RuleRepository ruleRepository;
  
  GetRules(this.ruleRepository);
  
  @override
  Future<List<RuleDto>> call(GetRulesParams params) async {
    List<RuleBase> rules;
    
    if (params.priorityName != null) {
      rules = await ruleRepository.getByPriority(params.priorityName!);
    } else if (params.actionValue != null) {
      rules = await ruleRepository.getByAction(params.actionValue!);
    } else if (params.phoneNumber != null) {
      rules = await ruleRepository.matchByPhoneNumber(params.phoneNumber!);
    } else if (params.enabledOnly) {
      rules = await ruleRepository.getAllEnabled();
    } else {
      rules = await ruleRepository.getAll();
    }
    
    return rules.map(_mapToDto).toList();
  }
  
  /// 将规则实体映射为DTO
  RuleDto _mapToDto(RuleBase rule) {
    // 获取电话号码和标签（如果适用）
    String? phoneNumber;
    String? label;
    String? avatar;
    String? pattern;
    
    // 根据规则类型获取特定属性
    if (rule is PhoneNumberRule) {
      phoneNumber = rule.phoneNumber.value;
      label = rule.label;
      avatar = rule.avatar;
    } else if (rule is RegexRule) {
      pattern = rule.pattern;
    }
    
    return RuleDto(
      id: rule.id,
      name: rule.name,
      description: rule.description,
      isEnabled: rule.isEnabled,
      createdAt: rule.createdAt,
      updatedAt: rule.updatedAt,
      priority: rule.priority.name,
      action: rule.action.value,
      source: rule.source,
      pattern: pattern,
      phoneNumber: phoneNumber,
      label: label,
      avatar: avatar,
    );
  }
}

/// 获取规则参数
class GetRulesParams {
  final String? priorityName; // 按优先级名称筛选
  final String? actionValue; // 按动作值筛选
  final String? phoneNumber; // 按电话号码匹配
  final bool enabledOnly; // 是否只获取启用的规则
  
  GetRulesParams({
    this.priorityName,
    this.actionValue,
    this.phoneNumber,
    this.enabledOnly = false,
  });
}

/// 电话号码规则接口
/// 用于标识包含电话号码的规则类型
abstract class PhoneNumberRule {
  PhoneNumber get phoneNumber;
  String? get label;
  String? get avatar;
}