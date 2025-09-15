import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/repositories/predefined_label_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_predefined_label_datasource.dart';
import 'package:yourcallyourrule/data/models/predefined_label_model.dart';

/// 预定义标签仓库实现类
class PredefinedLabelRepositoryImpl implements PredefinedLabelRepository {
  final LocalPredefinedLabelDataSource _dataSource;
  
  PredefinedLabelRepositoryImpl(this._dataSource);
  
  @override
  Future<void> save(PredefinedLabel label) async {
    await _dataSource.insert(PredefinedLabelModel.fromEntity(label));
  }
  
  @override
  Future<void> saveAll(List<PredefinedLabel> labels) async {
    final labelModels = labels.map((label) => PredefinedLabelModel.fromEntity(label)).toList();
    await _dataSource.insertAll(labelModels);
  }
  
  @override
  Future<void> update(PredefinedLabel label) async {
    await _dataSource.update(PredefinedLabelModel.fromEntity(label));
  }
  
  @override
  Future<void> delete(String id) async {
    await _dataSource.delete(id);
  }
  
  @override
  Future<List<PredefinedLabel>> getAll() async {
    final labelModels = await _dataSource.getAll();
    return labelModels.map((model) => model.toEntity()).toList();
  }
  
  @override
  Future<PredefinedLabel?> getById(String id) async {
    final labelModel = await _dataSource.getById(id);
    return labelModel?.toEntity();
  }
  
  @override
  Future<List<PredefinedLabel>> getByText(String text) async {
    final labelModels = await _dataSource.getByText(text);
    return labelModels.map((model) => model.toEntity()).toList();
  }
  
  /// 【新增实现】: 调用 DataSource 的新方法
  @override
  Future<String?> getIdByText(String text) async {
    return await _dataSource.getIdByExactText(text);
  }
  
  @override
  Future<String?> getLabelTextAsync(String id) async {
    final label = await getById(id);
    return label?.text;
  }
}