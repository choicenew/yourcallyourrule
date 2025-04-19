// 仓库基类接口，所有仓库接口都应该继承自这个接口

/// 泛型仓库基类接口
/// [T] 是实体类型
/// [ID] 是实体ID类型，默认为String
abstract class BaseRepository<T, ID> {
  /// 根据ID获取实体
  Future<T?> getById(ID id);
  
  /// 获取所有实体
  Future<List<T>> getAll();
  
  /// 保存实体
  Future<T> save(T entity);
  
  /// 批量保存实体
  Future<List<T>> saveAll(List<T> entities);
  
  /// 根据ID删除实体
  Future<bool> deleteById(ID id);
  
  /// 删除实体
  Future<bool> delete(T entity);
  
  /// 批量删除实体
  Future<bool> deleteAll(List<T> entities);
  
  /// 检查实体是否存在
  Future<bool> exists(ID id);
  
  /// 获取实体数量
  Future<int> count();
}