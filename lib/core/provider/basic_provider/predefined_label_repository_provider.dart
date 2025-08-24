import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/provider/datasource/local_predefined_label_datasource_provider.dart';
import 'package:yourcallyourrule/core/repositories/predefined_label_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_predefined_label_datasource.dart';
import 'package:yourcallyourrule/data/models/predefined_label_model.dart';

/// 预定义标签仓库提供者
final predefinedLabelRepositoryProvider = Provider<PredefinedLabelRepository>((ref) {
  final dataSource = ref.watch(localPredefinedLabelDataSourceProvider);
  return PredefinedLabelRepositoryImpl(dataSource);
});

/// 预定义标签仓库实现类
class PredefinedLabelRepositoryImpl implements PredefinedLabelRepository {
  final LocalPredefinedLabelDataSource _dataSource;

  /// 构造函数
  PredefinedLabelRepositoryImpl(this._dataSource);

  @override
  Future<void> save(PredefinedLabel label) async {
    final model = PredefinedLabelModel.fromMap(label.toMap());
    await _dataSource.insert(model);
  }

  @override
  Future<void> saveAll(List<PredefinedLabel> labels) async {
    final models =
        labels.map((label) => PredefinedLabelModel.fromMap(label.toMap())).toList();
    await _dataSource.insertAll(models);
  }

  @override
  Future<void> update(PredefinedLabel label) async {
    final model = PredefinedLabelModel.fromMap(label.toMap());
    await _dataSource.update(model);
  }

  @override
  Future<void> delete(String id) async {
    await _dataSource.delete(id);
  }

  @override
  Future<List<PredefinedLabel>> getAll() async {
    final models = await _dataSource.getAll();
    return models
        .map((model) => PredefinedLabel.fromMap(model.toMap()))
        .toList();
  }

  @override
  Future<PredefinedLabel?> getById(String id) async {
    final model = await _dataSource.getById(id);
    if (model == null) return null;
    return PredefinedLabel.fromMap(model.toMap());
  }

  @override
  Future<List<PredefinedLabel>> getByText(String text) async {
    final models = await _dataSource.getByText(text);
    return models
        .map((model) => PredefinedLabel.fromMap(model.toMap()))
        .toList();
  }

  @override
  Future<String?> getLabelTextAsync(String id) async {
    final label = await getById(id);
    return label?.text ?? id;
  }
}