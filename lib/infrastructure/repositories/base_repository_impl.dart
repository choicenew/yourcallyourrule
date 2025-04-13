import '../../domain/repositories/base_repository.dart';
import '../datasources/local/database/dao/base_dao.dart';
import '../datasources/local/database/app_database.dart';

/// 仓库基类实现
/// 提供基本的仓库操作实现，所有具体仓库实现都应该继承自这个基类
abstract class BaseRepositoryImpl<T, D extends BaseDao<T>> implements BaseRepository<T> {
  final AppDatabase database;
  final D dao;
  
  BaseRepositoryImpl(this.database, this.dao);
  
  @override
  Future<List<T>> getAll() async {
    return await dao.getAll();
  }
  
  @override
  Future<T?> getById(String id) async {
    return await dao.getById(id);
  }
  
  @override
  Future<void> add(T entity) async {
    await dao.insert(entity);
  }
  
  @override
  Future<void> update(T entity) async {
    await dao.update(entity);
  }
  
  @override
  Future<void> delete(String id) async {
    await dao.delete(id);
  }
  
  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }
}