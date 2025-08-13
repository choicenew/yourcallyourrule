// 远程数据访问限制实现，确保远程数据只能查询不能导出

import 'dart:async';

import 'package:uuid/uuid.dart';
import '../../models/remote/remote_number_model.dart';
import '../remote/remote_database_manager.dart';

// 远程数据访问限制接口
abstract class RemoteDataAccessRestriction {
  // 查询远程号码信息
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumber);
  
  // 记录访问日志
  Future<void> logAccess(String phoneNumber, String accessType, {String? userId});
  
  // 检查访问权限
  Future<bool> checkAccessPermission(String accessType, {String? userId});
}

// 远程数据访问限制实现类
class RemoteDataAccessRestrictionImpl implements RemoteDataAccessRestriction {
  static final RemoteDataAccessRestrictionImpl _instance = RemoteDataAccessRestrictionImpl._internal();
  
  // 远程数据库管理器
  late final RemoteDatabaseManagerImpl _remoteDatabaseManager;
  
  // 允许的访问类型
  static const String _accessTypeQuery = 'query';
  static const String _accessTypeSync = 'sync';
  
  // 禁止的访问类型
  static const String _accessTypeExport = 'export';
  static const String _accessTypeModify = 'modify';
  static const String _accessTypeDelete = 'delete';
  
  // 私有构造函数
  RemoteDataAccessRestrictionImpl._internal() {
    _remoteDatabaseManager = RemoteDatabaseManagerImpl();
  }
  
  // 工厂构造函数
  factory RemoteDataAccessRestrictionImpl() {
    return _instance;
  }
  
  // 查询远程号码信息
  @override
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumber) async {
    // 检查访问权限
    final hasPermission = await checkAccessPermission(_accessTypeQuery);
    if (!hasPermission) {
      throw UnauthorizedAccessException('无权访问远程数据');
    }
    
    try {
      // 获取数据库实例
      final db = await _remoteDatabaseManager.database;
      
      // 查询远程号码
      final List<Map<String, dynamic>> maps = await db.query(
        'remote_numbers',
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
      );
      
      // 记录访问日志
      await logAccess(phoneNumber, _accessTypeQuery);
      
      // 如果找到远程号码，返回相关信息
      if (maps.isNotEmpty) {
        final remoteNumber = RemoteNumberModel.fromMap(maps.first);
        return {
          'name': remoteNumber.name,
          'label': remoteNumber.label,
          'priority': remoteNumber.priority,
          'action': remoteNumber.action,
          'count': remoteNumber.count,
        };
      }
      
      return null;
    } catch (e) {
      // 记录错误日志
      await logAccess(phoneNumber, 'error', userId: e.toString());
      return null;
    }
  }
  
  // 记录访问日志
  @override
  Future<void> logAccess(String phoneNumber, String accessType, {String? userId}) async {
    try {
      // 获取数据库实例
      final db = await _remoteDatabaseManager.database;
      
      // 检查远程访问日志表是否存在
      final tables = await db.query(
        'sqlite_master',
        where: 'type = ? AND name = ?',
        whereArgs: ['table', 'remote_access_logs'],
      );
      
      // 如果表不存在，创建表
      if (tables.isEmpty) {
        await db.execute('''
          CREATE TABLE remote_access_logs (
            id TEXT PRIMARY KEY,
            phoneNumber TEXT NOT NULL,
            accessTime TEXT NOT NULL,
            accessType TEXT NOT NULL,
            userId TEXT
          )
        ''');
      }
      
      // 插入访问日志
      await db.insert(
        'remote_access_logs',
        {
          'id': const Uuid().v4(),
          'phoneNumber': phoneNumber,
          'accessTime': DateTime.now().toIso8601String(),
          'accessType': accessType,
          'userId': userId,
        },
      );
    } catch (e) {
      // 忽略日志记录错误
    }
  }
  
  // 检查访问权限
  @override
  Future<bool> checkAccessPermission(String accessType, {String? userId}) async {
    // 只允许查询和同步操作
    return accessType == _accessTypeQuery || accessType == _accessTypeSync;
  }
  
  // 导出数据（禁止使用）
  Future<Map<String, dynamic>> exportData() async {
    throw UnsupportedError('远程数据不支持导出操作');
  }
  
  // 修改数据（禁止使用）
  Future<void> modifyData() async {
    throw UnsupportedError('远程数据不支持修改操作');
  }
  
  // 删除数据（禁止使用）
  Future<void> deleteData() async {
    throw UnsupportedError('远程数据不支持删除操作');
  }
}

// 未授权访问异常
class UnauthorizedAccessException implements Exception {
  final String message;
  
  UnauthorizedAccessException(this.message);
  
  @override
  String toString() => 'UnauthorizedAccessException: $message';
}