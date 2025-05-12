import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';

/// 预定义标签仓库接口
abstract class PredefinedLabelRepository {
  /// 保存标签
  Future<void> save(PredefinedLabel label);
  
  /// 批量保存标签
  Future<void> saveAll(List<PredefinedLabel> labels);
  
  /// 更新标签
  Future<void> update(PredefinedLabel label);
  
  /// 删除标签
  Future<void> delete(String id);
  
  /// 获取所有标签
  Future<List<PredefinedLabel>> getAll();
  
  /// 根据ID获取标签
  Future<PredefinedLabel?> getById(String id);
  
  /// 根据文本获取标签
  Future<List<PredefinedLabel>> getByText(String text);
}