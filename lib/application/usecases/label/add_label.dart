import '../../../domain/entities/label/label_entry.dart';
import '../../../domain/services/label_service.dart';
import '../../dto/label_dto.dart';
import '../base_usecase.dart';

/// 添加标签用例
/// 处理添加标签的业务逻辑
class AddLabel implements UseCase<void, AddLabelParams> {
  final LabelService _labelService;
  
  AddLabel(this._labelService);
  
  @override
  Future<void> call(AddLabelParams params) async {
    // 检查标签名称是否已存在
    final existingLabel = await _labelService.getLabelByName(params.dto.name);
    if (existingLabel != null) {
      throw Exception('标签名称已存在');
    }
    
    // 添加标签
    await _labelService.addLabel(params.dto.toEntity());
  }
}

/// 添加标签参数
class AddLabelParams {
  final LabelDto dto;
  
  AddLabelParams(this.dto);
}