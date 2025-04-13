import '../../../domain/repositories/label_repository.dart';
import '../../dto/label_dto.dart';
import '../base_usecase.dart';

/// 导出标签用例
/// 处理导出标签的业务逻辑
class ExportLabels implements UseCase<List<LabelDto>, NoParams> {
  final LabelRepository _labelRepository;
  
  ExportLabels(this._labelRepository);
  
  @override
  Future<List<LabelDto>> call(NoParams params) async {
    final labels = await _labelRepository.exportLabels();
    return labels.map((label) => LabelDto.fromEntity(label)).toList();
  }
}