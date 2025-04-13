import '../../../domain/entities/rule/rule_base.dart';
import '../../../domain/repositories/rule_repository.dart';
import '../base_usecase.dart';

/// 更新规则用例
class UpdateRule implements UseCase<void, UpdateRuleParams> {
  final RuleRepository repository;
  
  UpdateRule(this.repository);
  
  @override
  Future<void> call(UpdateRuleParams params) async {
    await repository.updateRule(params.rule);
  }
}

/// 更新规则参数
class UpdateRuleParams {
  final RuleBase rule;
  
  UpdateRuleParams(this.rule);
}