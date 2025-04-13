import '../entities/label/label_entry.dart';
import 'base_repository.dart';

/// 标签仓库接口
/// 定义标签相关的数据操作
abstract class LabelRepository extends BaseRepository<LabelEntry> {
  /// 根据名称获取标签
  Future<LabelEntry?> getByName(String name);
  
  /// 获取所有系统标签
  Future<List<LabelEntry>> getSystemLabels();
  
  /// 获取所有用户自定义标签
  Future<List<LabelEntry>> getUserLabels();
  
  /// 为电话号码分配标签
  Future<void> assignToPhone(String phoneNumber, String labelId);
  
  /// 从电话号码移除标签
  Future<void> removeFromPhone(String phoneNumber, String labelId);
  
  /// 获取电话号码的所有标签
  Future<List<LabelEntry>> getForPhone(String phoneNumber);
  
  /// 导入标签
  Future<int> importLabels(List<LabelEntry> labels);
  
  /// 导出标签
  Future<List<LabelEntry>> exportLabels();
}