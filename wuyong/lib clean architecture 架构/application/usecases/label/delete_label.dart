import '../../../domain/services/label_service.dart';
import '../base_usecase.dart';

/// 删除标签用例
/// 处理删除标签的业务逻辑
class DeleteLabel implements UseCase<void, DeleteLabelParams> {
  final LabelService _labelService;
  
  DeleteLabel(this._labelService);
  
  @override
  Future<void> call(DeleteLabelParams params) async {
    // 检查标签是否存在
    final existingLabel = await _labelService.getLabelById(params.id);
    if (existingLabel == null) {
      throw Exception('标签不存在');
    }
    
    // 检查是否为系统标签
    if (existingLabel.isSystem) {
      throw Exception('系统标签不能删除');
    }
    
    // 删除标签
    await _labelService.deleteLabel(params.id);
  }
}

/// 删除标签参数
class DeleteLabelParams {
  final String id;
  
  DeleteLabelParams(this.id);
}