// 数据库管理类，用于管理本地和远程数据库

import 'package:sqflite/sqflite.dart';
import 'dart:async';

// 数据库管理器抽象类
abstract class DatabaseManager {
  // 获取数据库实例
  Future<Database> get database;
  
  // 关闭数据库
  Future<void> close();
  
  // 查询所有记录
  Future<List<Map<String, dynamic>>> queryAll(String table);
  
  // 根据ID查询记录
  Future<Map<String, dynamic>?> queryById(String table, String id);
  
  // 根据条件查询记录
  Future<List<Map<String, dynamic>>> queryWhere(String table, String field, dynamic value);
  
  // 模糊查询
  Future<List<Map<String, dynamic>>> queryLike(String table, String field, String pattern);
  
  // 插入记录
  Future<int> insert(String table, Map<String, dynamic> data);
  
  // 更新记录
  Future<int> update(String table, String id, Map<String, dynamic> data);
  
  // 删除记录
  Future<int> delete(String table, String id);

  // 根据电话号码查询记录
  Future<List<Map<String, dynamic>>> queryByPhoneNumber(String table, String phoneNumber);
}

// 本地数据库管理器抽象类
abstract class LocalDatabaseManager implements DatabaseManager {
  // 获取数据库实例
  @override
  Future<Database> get database;
  
  // 关闭数据库
  @override
  Future<void> close();

  Stream<List<Map<String, dynamic>>> watchTable(String table);
}

// 远程数据库管理器抽象类
abstract class RemoteDatabaseManager implements DatabaseManager {
  // 获取数据库实例
  @override
  Future<Database> get database;
  
  // 关闭数据库
  @override
  Future<void> close();
  
  // 删除提议相关方法
  Future<bool> hasActiveDeletionProposal(String phoneNumber);
  Future<int> cleanupCompletedDeletionProposals({Duration? olderThan});
  Future<List<Map<String, dynamic>>> getPendingDeletionProposals();
  Future<Map<String, dynamic>?> getProposalInfo(String phoneNumber);
}