import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/repositories/label_phone_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_label_datasource.dart';
import 'package:yourcallyourrule/data/models/label_phone_model.dart';


import '../datasource/local_label_datasource_provider.dart';

/// 电话标签仓库提供者
final labelPhoneRepositoryProvider = Provider<LabelPhoneRepository>((ref) {
  final localLabelDataSource = ref.watch(localLabelDataSourceProvider);
  // 返回电话标签仓库实现
  return LabelPhoneRepositoryImpl(localLabelDataSource);
});

/// 电话标签仓库实现类
class LabelPhoneRepositoryImpl implements LabelPhoneRepository {
  final LocalLabelDataSource _dataSource;

  LabelPhoneRepositoryImpl(this._dataSource);

  @override
  Future<List<LabelPhoneEntry>> getAll() async {
    final models = await _dataSource.getAll();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<LabelPhoneEntry?> getById(String id) async {
    final model = await _dataSource.getById(id);
    if (model == null) return null;
    return model.toEntity();
  }

  @override
  Future<LabelPhoneEntry> save(LabelPhoneEntry entity) async {
    await _dataSource.insert(LabelModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<LabelPhoneEntry> update(LabelPhoneEntry entity) async {
    await _dataSource.update(LabelModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<bool> delete(LabelPhoneEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _dataSource.delete(id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<LabelPhoneEntry> entities) async {
    final ids = entities.map((e) => e.id).toList();
    await _dataSource.deleteAll(ids);
    return true;
  }

  @override
  Future<List<LabelPhoneEntry>> saveAll(List<LabelPhoneEntry> entities) async {
    final models = entities.map((e) => LabelModel.fromEntity(e)).toList();
    await _dataSource.insertAll(models);
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final labels = await getAll();
    return labels.length;
  }

  @override
  LabelPhoneEntry fromMap(Map<String, dynamic> map) {
    return LabelPhoneEntry.fromMap(map);
  }

  @override
  Future<LabelPhoneEntry?> getByName(String name) async {
    final models = await _dataSource.getByName(name);
    if (models.isEmpty) return null;
    return models.first.toEntity();
  }

  @override
  Future<List<LabelPhoneEntry>> getByType(String type) async {
    final models = await _dataSource.getByRuleType(type);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<bool> nameExists(String name) async {
    final label = await getByName(name);
    return label != null;
  }

  @override
  Future<List<LabelPhoneEntry>> getAllEnabled() async {
    final models = await _dataSource.getEnabledLabels();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<LabelPhoneEntry?> getByPhoneNumber(String phoneNumber) async {
    final models = await _dataSource.getByPhoneNumber(phoneNumber);
    if (models.isEmpty) {
      return null;
    }
    return models.first.toEntity();
  }

  @override
  Future<List<LabelPhoneEntry>> getByLabelId(String labelId) async {
    final models = await _dataSource.getByLabelId(labelId);
    return models.map((model) => model.toEntity()).toList();
  }
}