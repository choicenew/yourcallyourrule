// 服务基类，所有服务都应该继承自这个类

import 'base_entity.dart';
import '../repositories/base_repository.dart';

/// 服务基类
/// [T] 是实体类型
/// [ID] 是实体ID类型，默认为String
abstract class BaseService<T extends BaseEntity, ID> {
  final BaseRepository<T, ID> repository;

  const BaseService(this.repository);

  /// 根据ID获取实体
  Future<T?> getById(ID id) => repository.getById(id);
  
  /// 获取所有实体
  Future<List<T>> getAll() => repository.getAll();
  
  /// 保存实体
  Future<T> save(T entity) => repository.save(entity);
  
  /// 批量保存实体
  Future<List<T>> saveAll(List<T> entities) => repository.saveAll(entities);
  
  /// 根据ID删除实体
  Future<bool> deleteById(ID id) => repository.deleteById(id);
  
  /// 删除实体
  Future<bool> delete(T entity) => repository.delete(entity);
  
  /// 批量删除实体
  Future<bool> deleteAll(List<T> entities) => repository.deleteAll(entities);
  
  /// 检查实体是否存在
  Future<bool> exists(ID id) => repository.exists(id);
}