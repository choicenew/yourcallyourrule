// 数据源基类，所有数据源都应该实现这个接口

/// 数据源基类接口
/// [T] 是数据模型类型
/// [ID] 是数据模型ID类型，默认为String
abstract class BaseDataSource<T, ID> {
  /// 根据ID获取数据
  Future<T?> getById(ID id);
  
  /// 获取所有数据
  Future<List<T>> getAll();
  
  /// 保存数据
  Future<T> save(T data);
  
  /// 批量保存数据
  Future<List<T>> saveAll(List<T> dataList);
  
  /// 根据ID删除数据
  Future<bool> deleteById(ID id);
  
  /// 删除数据
  Future<bool> delete(T data);
  
  /// 批量删除数据
  Future<bool> deleteAll(List<T> dataList);
  
  /// 检查数据是否存在
  Future<bool> exists(ID id);
  
  /// 获取数据总数
  Future<int> count();
  
  /// 根据条件查询数据
  Future<List<T>> query(Map<String, dynamic> conditions);
}