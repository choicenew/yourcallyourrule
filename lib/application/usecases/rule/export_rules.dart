import '../../dto/rule_dto.dart';
import '../../usecases/base_usecase.dart';
import '../../../domain/repositories/rule_repository.dart';
import '../../../common/utils/file_utils.dart';
import '../../../common/error/failures.dart';

/// 导出规则用例
/// 用于将规则导出到文件
class ExportRules implements UseCase<bool, ExportRulesParams> {
  final RuleRepository repository;
  final FileUtils fileUtils;
  
  ExportRules(this.repository, this.fileUtils);
  
  @override
  Future<bool> call(ExportRulesParams params) async {
    try {
      // 获取规则列表
      final rules = await repository.getRules(
        ruleType: params.ruleType,
        onlyEnabled: params.onlyEnabled,
      );
      
      // 将规则转换为DTO
      final ruleDtos = rules.map((rule) => RuleDto.fromEntity(rule)).toList();
      
      // 将DTO列表转换为JSON并写入文件
      final jsonData = ruleDtos.map((dto) => dto.toMap()).toList();
      await FileUtils.writeJsonFile(params.filePath, jsonData);
      
      return true;
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw FileOperationFailure('导出规则失败: ${e.toString()}');
    }
  }
}

/// 导出规则参数
class ExportRulesParams {
  final String filePath;
  final String? ruleType; // 规则类型，如果为null则导出所有类型
  final bool onlyEnabled; // 是否只导出已启用的规则
  
  ExportRulesParams({
    required this.filePath,
    this.ruleType,
    this.onlyEnabled = false,
  });
}