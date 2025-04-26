import '../../../domain/entities/label/label_entry.dart';
import '../../../domain/repositories/label_repository.dart';
import '../../../domain/services/label_service.dart';
import '../base_service_impl.dart';

/// 标签服务实现
/// 实现标签服务接口，提供标签相关的业务逻辑
class LabelServiceImpl extends BaseServiceImpl implements LabelService {
  final LabelRepository _labelRepository;
  
  LabelServiceImpl(this._labelRepository);
  
  @override
  Future<List<LabelEntry>> getAllLabels() async {
    return await _labelRepository.getAll();
  }
  
  @override
  Future<LabelEntry?> getLabelById(String id) async {
    return await _labelRepository.getById(id);
  }
  
  @override
  Future<LabelEntry?> getLabelByName(String name) async {
    return await _labelRepository.getByName(name);
  }
  
  @override
  Future<void> addLabel(LabelEntry label) async {
    await _labelRepository.add(label);
  }
  
  @override
  Future<void> updateLabel(LabelEntry label) async {
    await _labelRepository.update(label);
  }
  
  @override
  Future<void> deleteLabel(String id) async {
    await _labelRepository.delete(id);
  }
  
  @override
  Future<List<LabelEntry>> getSystemLabels() async {
    return await _labelRepository.getSystemLabels();
  }
  
  @override
  Future<List<LabelEntry>> getUserLabels() async {
    return await _labelRepository.getUserLabels();
  }
  
  @override
  Future<void> assignLabelToPhone(String phoneNumber, String labelId) async {
    await _labelRepository.assignToPhone(phoneNumber, labelId);
  }
  
  @override
  Future<void> removeLabelFromPhone(String phoneNumber, String labelId) async {
    await _labelRepository.removeFromPhone(phoneNumber, labelId);
  }
  
  @override
  Future<List<LabelEntry>> getLabelsForPhone(String phoneNumber) async {
    return await _labelRepository.getForPhone(phoneNumber);
  }
}