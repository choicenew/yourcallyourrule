import '../../../domain/entities/label/label_entry.dart';
import '../../../domain/services/label_service.dart';
import '../../dto/label_dto.dart';
import '../base_usecase.dart';

/// 获取所有标签用例
/// 处理获取所有标签的业务逻辑
class GetAllLabels implements UseCase<List<LabelDto>, NoParams> {
  final LabelService _labelService;
  
  GetAllLabels(this._labelService);
  
  @override
  Future<List<LabelDto>> call(NoParams params) async {
    final labels = await _labelService.getAllLabels();
    return labels.map((label) => LabelDto.fromEntity(label)).toList();
  }
}

/// 获取系统标签用例
/// 处理获取系统标签的业务逻辑
class GetSystemLabels implements UseCase<List<LabelDto>, NoParams> {
  final LabelService _labelService;
  
  GetSystemLabels(this._labelService);
  
  @override
  Future<List<LabelDto>> call(NoParams params) async {
    final labels = await _labelService.getSystemLabels();
    return labels.map((label) => LabelDto.fromEntity(label)).toList();
  }
}

/// 获取用户标签用例
/// 处理获取用户标签的业务逻辑
class GetUserLabels implements UseCase<List<LabelDto>, NoParams> {
  final LabelService _labelService;
  
  GetUserLabels(this._labelService);
  
  @override
  Future<List<LabelDto>> call(NoParams params) async {
    final labels = await _labelService.getUserLabels();
    return labels.map((label) => LabelDto.fromEntity(label)).toList();
  }
}

/// 根据ID获取标签用例
/// 处理根据ID获取标签的业务逻辑
class GetLabelById implements UseCase<LabelDto?, GetLabelByIdParams> {
  final LabelService _labelService;
  
  GetLabelById(this._labelService);
  
  @override
  Future<LabelDto?> call(GetLabelByIdParams params) async {
    final label = await _labelService.getLabelById(params.id);
    return label != null ? LabelDto.fromEntity(label) : null;
  }
}

/// 根据ID获取标签参数
class GetLabelByIdParams {
  final String id;
  
  GetLabelByIdParams(this.id);
}

/// 获取电话号码的标签用例
/// 处理获取电话号码的标签的业务逻辑
class GetLabelsForPhone implements UseCase<List<LabelDto>, GetLabelsForPhoneParams> {
  final LabelService _labelService;
  
  GetLabelsForPhone(this._labelService);
  
  @override
  Future<List<LabelDto>> call(GetLabelsForPhoneParams params) async {
    final labels = await _labelService.getLabelsForPhone(params.phoneNumber);
    return labels.map((label) => LabelDto.fromEntity(label)).toList();
  }
}

/// 获取电话号码的标签参数
class GetLabelsForPhoneParams {
  final String phoneNumber;
  
  GetLabelsForPhoneParams(this.phoneNumber);
}