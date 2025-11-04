// 远程数据访问限制实现，确保远程数据只能查询不能导出
// (已移除日志功能，并从 sqflite 重构到 drift 的最终版本)

import 'dart:async';

// 导入 Drift 数据库及其生成的数据类
import '../remote/remote_database.dart';
// import '../remote/remote_database.g.dart'; // Drift 可能会隐式需要，显式导入更安全

// -----------------------------------------------------------
// --- 接口定义 (与上一步的 sqflite 版本完全相同) ---
// -----------------------------------------------------------
abstract class RemoteDataAccessRestriction {
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumber);
  
  Future<bool> checkAccessPermission(String accessType, {String? userId});
}

// -----------------------------------------------------------
// --- 实现类 (drift 重构版) ---
// -----------------------------------------------------------
class RemoteDataAccessRestrictionImpl implements RemoteDataAccessRestriction {
  
  // 【重构点 1】: 依赖注入 Drift
  // 依赖从 sqflite 的 RemoteDatabaseManagerImpl 切换到 drift 的 RemoteDatabase。
  // 不再使用单例，而是通过构造函数注入。
  final RemoteDatabase _db;

  // 【重构点 2】: 常量可见性与命名
  // 保持与 sqflite 版本一致，使用私有常量。
  // (如果 Repository 需要引用，可改为 public)
  static const String accessTypeQuery = 'query';
  static const String accessTypeSync = 'sync';

  // 构造函数，接收 Drift 数据库实例。
  RemoteDataAccessRestrictionImpl(this._db);
  
  // 【重构点 3】: 使用 Drift 实现 queryRemoteNumberInfo
  @override
  Future<Map<String, dynamic>?> queryRemoteNumberInfo(String phoneNumber) async {
    // 步骤 1: 权限检查 (逻辑不变)
    final hasPermission = await checkAccessPermission(accessTypeQuery);
    if (!hasPermission) {
      throw UnauthorizedAccessException('无权访问远程数据');
    }
    
    try {
      // 步骤 2: 使用 Drift 的类型安全查询
      final query = _db.select(_db.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
      
      final remoteNumberData = await query.getSingleOrNull();

      // 步骤 3: 处理结果 (逻辑不变, 返回类型不变)
      if (remoteNumberData != null) {
        // 将 Drift 的数据对象转换为 Map，以匹配接口定义
        return {
          'name': remoteNumberData.name,
          'label': remoteNumberData.label,
          'priority': remoteNumberData.priority,
          'action': remoteNumberData.action,
          'count': remoteNumberData.count,
        };
      }
      
      return null;
    } catch (e) {
      // 错误处理逻辑不变
      return null;
    }
  }
  
  // 权限检查逻辑不变
  @override
  Future<bool> checkAccessPermission(String accessType, {String? userId}) async {
    return accessType == accessTypeQuery || accessType == accessTypeSync;
  }
  
  // -----------------------------------------------------------
  // --- 以下方法在 sqflite 版本中已无实现，此处也无需实现 ---
  // --- 但为了接口完整性，如果接口要求，则需要添加抛出异常的实现 ---
  // -----------------------------------------------------------
  
  // 为保持与原始文件意图一致，添加禁止操作的实现
  Future<Map<String, dynamic>> exportData() async {
    throw UnsupportedError('远程数据不支持导出操作');
  }
  
  Future<void> modifyData() async {
    throw UnsupportedError('远程数据不支持修改操作');
  }
  
  Future<void> deleteData() async {
    throw UnsupportedError('远程数据不支持删除操作');
  }
}

// 未授权访问异常 (保持不变)
class UnauthorizedAccessException implements Exception {
  final String message;
  
  UnauthorizedAccessException(this.message);
  
  @override
  String toString() => 'UnauthorizedAccessException: $message';
}