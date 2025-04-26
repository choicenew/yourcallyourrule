import '../entities/label/label_entry.dart';

/// 标签服务接口
/// 定义标签相关的业务逻辑
abstract class LabelService {
  /// 获取所有标签
  Future<List<LabelEntry>> getAllLabels();
  
  /// 根据ID获取标签
  Future<LabelEntry?> getLabelById(String id);
  
  /// 根据名称获取标签
  Future<LabelEntry?> getLabelByName(String name);
  
  /// 添加标签
  Future<void> addLabel(LabelEntry label);
  
  /// 更新标签
  Future<void> updateLabel(LabelEntry label);
  
  /// 删除标签
  Future<void> deleteLabel(String id);
  
  /// 获取系统标签
  Future<List<LabelEntry>> getSystemLabels();
  
  /// 获取用户自定义标签
  Future<List<LabelEntry>> getUserLabels();
  
  /// 为电话号码分配标签
  Future<void> assignLabelToPhone(String phoneNumber, String labelId);
  
  /// 从电话号码移除标签
  Future<void> removeLabelFromPhone(String phoneNumber, String labelId);
  
  /// 获取电话号码的所有标签
  Future<List<LabelEntry>> getLabelsForPhone(String phoneNumber);
}