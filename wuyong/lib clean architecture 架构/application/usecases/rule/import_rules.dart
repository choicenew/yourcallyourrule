import '../../dto/rule_dto.dart';
import '../base_usecase.dart';
import '../../../domain/repositories/rule_repository.dart';
import '../../../common/utils/file_utils.dart';
import '../../../common/error/failures.dart';

/// 导入规则用例
/// 用于从文件导入规则
class ImportRules implements UseCase<List<RuleDto>, ImportRulesParams> {
  final RuleRepository repository;
  final FileUtils fileUtils;
  
  ImportRules(this.repository, this.fileUtils);
  
  @override
  Future<List<RuleDto>> call(ImportRulesParams params) async {
    try {
      // 从文件读取规则数据
      final jsonData = await FileUtils.readJsonFile(params.filePath);
      
      if (jsonData is! List) {
        throw const InvalidFileFailure('无效的规则文件格式');
      }
      
      // 将JSON数据转换为规则DTO列表
      final ruleDtos = (jsonData as List)
          .map((json) => RuleDto.fromJson(json))
          .toList();
      
      // 导入规则到仓库
      final importedRules = await repository.importRules(ruleDtos);
      
      // 返回成功导入的规则DTO列表
      return importedRules.map((rule) => RuleDto.fromEntity(rule)).toList();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw FileOperationFailure('导入规则失败: ${e.toString()}');
    }
  }
}

/// 导入规则参数
class ImportRulesParams {
  final String filePath;
  final String source; // 导入来源
  
  ImportRulesParams({
    required this.filePath,
    required this.source,
  });
}