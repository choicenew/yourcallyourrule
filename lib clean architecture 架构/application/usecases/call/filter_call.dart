import '../../dto/call_dto.dart';
import '../../dto/rule_dto.dart';
import '../base_usecase.dart';
import '../rule/match_rule.dart';

/// 过滤通话用例
/// 用于根据规则过滤来电
class FilterCall implements UseCase<FilterCallResult, FilterCallParams> {
  final MatchRule matchRuleUseCase;
  
  FilterCall(this.matchRuleUseCase);
  
  @override
  Future<FilterCallResult> call(FilterCallParams params) async {
    // 使用匹配规则用例查找匹配的规则
    final matchedRule = await matchRuleUseCase(MatchRuleParams(
      phoneNumber: params.callDto.phoneNumber,
    ));
    
    // 创建过滤结果
    return FilterCallResult(
      callDto: params.callDto,
      matchedRule: matchedRule,
      shouldAllow: matchedRule?.action == 'ALLOW',
      shouldBlock: matchedRule?.action == 'BLOCK',
      shouldSilent: matchedRule?.action == 'SILENT',
      shouldNotify: matchedRule?.action == 'NOTIFY',
    );
  }
}

/// 过滤通话参数
class FilterCallParams {
  final CallDto callDto;
  
  FilterCallParams({required this.callDto});
}

/// 过滤通话结果
class FilterCallResult {
  final CallDto callDto;
  final RuleDto? matchedRule;
  final bool shouldAllow;
  final bool shouldBlock;
  final bool shouldSilent;
  final bool shouldNotify;
  
  FilterCallResult({
    required this.callDto,
    this.matchedRule,
    required this.shouldAllow,
    required this.shouldBlock,
    required this.shouldSilent,
    required this.shouldNotify,
  });
}