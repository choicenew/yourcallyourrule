import '../../base_usecase.dart';
import '../../../domain/repositories/rule_repository.dart';

/// 删除规则用例
/// 用于删除指定ID的规则
class DeleteRule implements UseCase<bool, DeleteRuleParams> {
  final RuleRepository repository;
  
  DeleteRule(this.repository);
  
  @override
  Future<bool> call(DeleteRuleParams params) async {
    return await repository.deleteRule(params.id);
  }
}

/// 删除规则参数
class DeleteRuleParams {
  final String id;
  
  DeleteRuleParams({required this.id});
}