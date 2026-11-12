import 'dart:async';

/// 通用 Protocol 实体基础契约标识
abstract class IdentifiableEntity {
  String get id;
}

/// 全局泛型自动化存储引擎契约接口 (EntityStore<T>)
/// 彻底抹平上层 UI/Service 对底层特定数据库 (Drift/Isar/Realm) 的依赖
abstract class EntityStore<T> {
  /// 获取全量记录
  Future<List<T>> getAll();

  /// 根据 ID 主键查询单条记录
  Future<T?> getById(String id);

  /// 插入或更新单条记录 (Upsert)
  Future<void> save(T entity);

  /// 批量插入或更新 (Batch Upsert)
  Future<void> saveAll(List<T> entities);

  /// 根据 ID 删除单条记录
  Future<int> delete(String id);

  /// 批量根据 ID 删除
  Future<int> deleteAll(List<String> ids);

  /// 清空全表
  Future<int> clear();

  /// 获取记录总数
  Future<int> count();

  /// 响应式监听全量记录数据流 (Stream)
  Stream<List<T>> watchAll();
}

/// 全局存储引擎工厂抽象契约
abstract class EntityStoreFactory {
  /// 根据实体类型 T 动态分发/创建对应的 EntityStore 实例
  EntityStore<T> createStore<T>();
}
