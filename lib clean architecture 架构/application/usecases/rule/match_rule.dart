import '../../dto/rule_dto.dart';
import '../base_usecase.dart';
import '../../../domain/repositories/rule_repository.dart';
import '../../../domain/services/rule_matcher_service.dart';

/// 匹配规则用例
/// 用于根据输入的电话号码匹配最高优先级的规则
class MatchRule implements UseCase<RuleDto?, MatchRuleParams> {
  final RuleRepository ruleRepository;
  final RuleMatcherService matcherService;
  
  MatchRule(this.ruleRepository, this.matcherService);
  
  @override
  Future<RuleDto?> call(MatchRuleParams params) async {
    // 获取所有启用的规则
    final rules = await ruleRepository.getRules(onlyEnabled: true);
    
    // 使用规则匹配服务找到匹配的规则
    final matchedRule = matcherService.findMatchingRule(rules, params.phoneNumber);
    
    // 如果没有匹配的规则，返回null
    if (matchedRule == null) {
      return null;
    }
    
    // 将匹配的规则转换为DTO并返回
    return RuleDto.fromEntity(matchedRule);
  }
}

/// 匹配规则参数
class MatchRuleParams {
  final String phoneNumber;
  
  MatchRuleParams({required this.phoneNumber});
}