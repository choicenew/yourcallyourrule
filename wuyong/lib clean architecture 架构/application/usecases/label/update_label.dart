import '../../../domain/entities/label/label_entry.dart';
import '../../../domain/services/label_service.dart';
import '../../dto/label_dto.dart';
import '../base_usecase.dart';

/// 更新标签用例
/// 处理更新标签的业务逻辑
class UpdateLabel implements UseCase<void, UpdateLabelParams> {
  final LabelService _labelService;
  
  UpdateLabel(this._labelService);
  
  @override
  Future<void> call(UpdateLabelParams params) async {
    // 检查标签是否存在
    final existingLabel = await _labelService.getLabelById(params.dto.id);
    if (existingLabel == null) {
      throw Exception('标签不存在');
    }
    
    // 如果名称已更改，检查新名称是否已存在
    if (existingLabel.name != params.dto.name) {
      final labelWithSameName = await _labelService.getLabelByName(params.dto.name);
      if (labelWithSameName != null && labelWithSameName.id != params.dto.id) {
        throw Exception('标签名称已存在');
      }
    }
    
    // 更新标签
    await _labelService.updateLabel(params.dto.toEntity());
  }
}

/// 更新标签参数
class UpdateLabelParams {
  final LabelDto dto;
  
  UpdateLabelParams(this.dto);
}