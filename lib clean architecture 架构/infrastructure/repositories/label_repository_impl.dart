import '../../domain/entities/label/label_entry.dart';
import '../../domain/repositories/label_repository.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/local/database/dao/label_dao.dart';
import 'base_repository_impl.dart';

/// 标签仓库实现
/// 实现标签仓库接口，提供标签相关的数据操作
class LabelRepositoryImpl extends BaseRepositoryImpl<LabelEntry, LabelDao> implements LabelRepository {
  LabelRepositoryImpl(AppDatabase database)
      : super(database, database.labelDao);
  
  @override
  Future<LabelEntry?> getByName(String name) async {
    return await dao.getByName(name);
  }
  
  @override
  Future<List<LabelEntry>> getSystemLabels() async {
    return await dao.getSystemLabels();
  }
  
  @override
  Future<List<LabelEntry>> getUserLabels() async {
    return await dao.getUserLabels();
  }
  
  @override
  Future<void> assignToPhone(String phoneNumber, String labelId) async {
    await dao.assignToPhone(phoneNumber, labelId);
  }
  
  @override
  Future<void> removeFromPhone(String phoneNumber, String labelId) async {
    await dao.removeFromPhone(phoneNumber, labelId);
  }
  
  @override
  Future<List<LabelEntry>> getForPhone(String phoneNumber) async {
    return await dao.getForPhone(phoneNumber);
  }
  
  @override
  Future<int> importLabels(List<LabelEntry> labels) async {
    try {
      await dao.addAll(labels);
      return labels.length;
    } catch (e) {
      return 0;
    }
  }
  
  @override
  Future<List<LabelEntry>> exportLabels() async {
    return await getAll();
  }
}