/// 服务基类
abstract class BaseService<T, ID> {
  const BaseService();

  Future<T?> getById(ID id) async => null;
  Future<List<T>> getAll() async => [];
  Future<T> save(T entity) async => entity;
  Future<List<T>> saveAll(List<T> entities) async => entities;
  Future<bool> deleteById(ID id) async => true;
  Future<bool> delete(T entity) async => true;
  Future<T> update(T entity) async => entity;
  Future<bool> deleteAll(List<T> entities) async => true;
  Future<bool> exists(ID id) async => false;
}
