import '../../dto/rule_dto.dart';
import '../base_usecase.dart';
import '../../../domain/repositories/rule_repository.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../../../domain/entities/rule/allowed_rule.dart';
import '../../../domain/entities/rule/blocked_rule.dart';
import '../../../domain/entities/rule/whitelist_rule.dart';
import '../../../domain/entities/rule/blacklist_rule.dart';
import '../../../domain/entities/rule/regex_rule.dart';
import '../../../domain/value_objects/rule_priority.dart';
import '../../../domain/value_objects/rule_action.dart';
import '../../../domain/value_objects/phone_number.dart';

/// 添加规则用例
/// 用于添加新的规则
class AddRule implements UseCase<void, AddRuleParams> {
  final RuleRepository ruleRepository;
  
  AddRule(this.ruleRepository);
  
  @override
  Future<void> call(AddRuleParams params) async {
    final RuleBase rule = _createRuleFromDto(params.ruleDto);
    await ruleRepository.add(rule);
  }
  
  /// 根据DTO创建规则实体
  RuleBase _createRuleFromDto(RuleDto dto) {
    final priority = RulePriority.fromName(dto.priority);
    final action = RuleAction.fromValue(dto.action);
    
    switch (priority.name) {
      case 'Allowed':
        return AllowedRule(
          id: dto.id,
          name: dto.name,
          description: dto.description,
          isEnabled: dto.isEnabled,
          createdAt: dto.createdAt,
          updatedAt: dto.updatedAt,
          priority: priority,
          action: action,
          source: dto.source,
          phoneNumber: PhoneNumber(dto.phoneNumber!),
          label: dto.label,
          avatar: dto.avatar,
        );
      case 'Blocked':
        return BlockedRule(
          id: dto.id,
          name: dto.name,
          description: dto.description,
          isEnabled: dto.isEnabled,
          createdAt: dto.createdAt,
          updatedAt: dto.updatedAt,
          priority: priority,
          action: action,
          source: dto.source,
          phoneNumber: PhoneNumber(dto.phoneNumber!),
          label: dto.label,
          avatar: dto.avatar,
        );
      case 'Whitelist':
        return WhitelistRule(
          id: dto.id,
          name: dto.name,
          description: dto.description,
          isEnabled: dto.isEnabled,
          createdAt: dto.createdAt,
          updatedAt: dto.updatedAt,
          priority: priority,
          action: action,
          source: dto.source,
          phoneNumber: PhoneNumber(dto.phoneNumber!),
          label: dto.label,
          avatar: dto.avatar,
        );
      case 'Blacklist':
        return BlacklistRule(
          id: dto.id,
          name: dto.name,
          description: dto.description,
          isEnabled: dto.isEnabled,
          createdAt: dto.createdAt,
          updatedAt: dto.updatedAt,
          priority: priority,
          action: action,
          source: dto.source,
          phoneNumber: PhoneNumber(dto.phoneNumber!),
          label: dto.label,
          avatar: dto.avatar,
        );
      case 'Regex':
        return RegexRule(
          id: dto.id,
          name: dto.name,
          description: dto.description,
          isEnabled: dto.isEnabled,
          createdAt: dto.createdAt,
          updatedAt: dto.updatedAt,
          priority: priority,
          action: action,
          source: dto.source,
          pattern: dto.pattern!,
        );
      default:
        throw ArgumentError('不支持的规则类型: ${priority.name}');
    }
  }
}

/// 添加规则参数
class AddRuleParams {
  final RuleDto ruleDto;
  
  AddRuleParams(this.ruleDto);
}