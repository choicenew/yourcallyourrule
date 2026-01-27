// 仓库基类实现，所有仓库实现都应该继承自这个类

import '../../core/repositories/base_repository.dart';
import '../models/base_model.dart';

/// 泛型仓库基类实现
/// [T] 是实体类型
/// [M] 是模型类型
/// [ID] 是实体ID类型，默认为String
abstract class BaseRepositoryImpl<T, M extends BaseModel<T>, ID> implements BaseRepository<T, ID> {
  // 数据源，子类应该提供具体实现
  final dynamic dataSource;
  
  // 构造函数
  BaseRepositoryImpl(this.dataSource);
  
  // 将实体转换为模型，子类必须实现此方法
  M toModel(T entity);
  
  // 将模型转换为实体，子类必须实现此方法
  T toEntity(M model);
  
  @override
  Future<T?> getById(ID id) async {
    final model = await dataSource.getById(id);
    if (model == null) return null;
    return toEntity(model as M);
  }
  
  @override
  Future<List<T>> getAll() async {
    final models = await dataSource.getAll();
    return models.map((model) => toEntity(model as M)).toList();
  }
  
  @override
  Future<T> save(T entity) async {
    final model = toModel(entity);
    final savedModel = await dataSource.save(model);
    return toEntity(savedModel as M);
  }
  
  @override
  Future<List<T>> saveAll(List<T> entities) async {
    final models = entities.map((entity) => toModel(entity)).toList();
    final savedModels = await dataSource.saveAll(models);
    return savedModels.map((model) => toEntity(model as M)).toList();
  }
  
  @override
  Future<bool> deleteById(ID id) async {
    return await dataSource.deleteById(id);
  }
  
  @override
  Future<bool> delete(T entity) async {
    final model = toModel(entity);
    return await dataSource.delete(model);
  }
  
  @override
  Future<bool> deleteAll(List<T> entities) async {
    final models = entities.map((entity) => toModel(entity)).toList();
    return await dataSource.deleteAll(models);
  }
  
  @override
  Future<bool> exists(ID id) async {
    return await dataSource.exists(id);
  }
}