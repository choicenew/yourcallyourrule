// 数据源接口定义，用于本地和远程数据源的统一接口

import 'dart:async';

// 通用数据源接口
abstract class DataSource<T> {
  // 获取所有数据
  Future<List<T>> getAll();
  
  // 根据ID获取数据
  Future<T?> getById(String id);
  
  // 插入数据
  Future<String> insert(T item);
  
  // 更新数据
  Future<int> update(T item);
  
  // 删除数据
  Future<int> delete(String id);
  
  // 批量插入数据
  Future<List<String>> insertAll(List<T> items);
  
  // 批量更新数据
  Future<int> updateAll(List<T> items);
  
  // 批量删除数据
  Future<int> deleteAll(List<String> ids);
  
  // 清空所有数据
  Future<void> clear();
}

// 本地数据源接口，扩展通用数据源接口
abstract class LocalDataSource<T> extends DataSource<T> {
  // 导出数据
  Future<String> exportData();
  
  // 导入数据
  Future<bool> importData(String data);
}

// 远程数据源接口，扩展通用数据源接口
abstract class RemoteDataSource<T> extends DataSource<T> {
  // 同步数据
  Future<bool> syncData();
  
  // 获取最后同步时间
  Future<DateTime?> getLastSyncTime();
  
  // 增量同步数据
  Future<bool> incrementalSync(DateTime lastSyncTime);
}