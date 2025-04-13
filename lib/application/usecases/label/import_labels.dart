import '../../../domain/entities/label/label_entry.dart';
import '../../../domain/repositories/label_repository.dart';
import '../../dto/label_dto.dart';
import '../base_usecase.dart';

/// 导入标签用例
/// 处理导入标签的业务逻辑
class ImportLabels implements UseCase<int, ImportLabelsParams> {
  final LabelRepository _labelRepository;
  
  ImportLabels(this._labelRepository);
  
  @override
  Future<int> call(ImportLabelsParams params) async {
    final labels = params.labels.map((dto) => dto.toEntity()).toList();
    return await _labelRepository.importLabels(labels);
  }
}

/// 导入标签参数
class ImportLabelsParams {
  final List<LabelDto> labels;
  
  ImportLabelsParams(this.labels);
}