/// 数据源基类
/// 所有数据源都应该实现这个接口
abstract class BaseDataSource<T> {
  /// 获取所有数据
  Future<List<T>> getAll();
  
  /// 根据ID获取数据
  Future<T?> getById(String id);
  
  /// 添加数据
  Future<void> add(T item);
  
  /// 更新数据
  Future<void> update(T item);
  
  /// 删除数据
  Future<void> delete(String id);
  
  /// 批量添加数据
  Future<void> addAll(List<T> items) async {
    for (final item in items) {
      await add(item);
    }
  }
  
  /// 批量更新数据
  Future<void> updateAll(List<T> items) async {
    for (final item in items) {
      await update(item);
    }
  }
  
  /// 批量删除数据
  Future<void> deleteAll(List<String> ids) async {
    for (final id in ids) {
      await delete(id);
    }
  }
  
  /// 清空所有数据
  Future<void> clear();
}