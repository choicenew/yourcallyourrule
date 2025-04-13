/// 仓库基类接口
/// 定义所有仓库的基本操作
abstract class BaseRepository<T> {
  /// 获取所有实体
  Future<List<T>> getAll();
  
  /// 根据ID获取实体
  Future<T?> getById(String id);
  
  /// 添加实体
  Future<void> add(T entity);
  
  /// 更新实体
  Future<void> update(T entity);
  
  /// 删除实体
  Future<void> delete(String id);
  
  /// 检查实体是否存在
  Future<bool> exists(String id);
}