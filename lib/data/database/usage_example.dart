// 数据库使用示例，展示如何使用本地和远程数据库隔离架构

import 'dart:async';

import '../models/contact_model.dart';
import '../models/label_model.dart';
import '../models/remote/remote_number_model.dart';
import '../models/sync/sync_record_model.dart';
import 'database_service.dart';
import 'remote/remote_data_access_restriction.dart';
import 'sync/sync_manager_impl.dart';
import 'sync_manager.dart';

// 数据库使用示例类
class DatabaseUsageExample {
  // 数据库服务
  final DatabaseService _databaseService = DatabaseService();
  
  // 同步管理器
  final SyncManager _syncManager = SyncManager();
  
  // 增量同步管理器
  final SyncManagerImpl _syncManagerImpl = SyncManagerImpl();
  
  // 远程数据访问限制
  final RemoteDataAccessRestrictionImpl _remoteDataAccessRestriction = RemoteDataAccessRestrictionImpl();
  
  // 初始化
  Future<void> initialize() async {
    // 初始化数据库服务
    await _databaseService.initialize();
    
    // 初始化同步管理器
    await _syncManager.initialize();
    
    // 初始化增量同步管理器
    await _syncManagerImpl.initialize();
  }
  
  // 本地数据库操作示例
  Future<void> localDatabaseExample() async {
    // 添加联系人
    final contactModel = ContactModel(
      id: '',  // 空ID将自动生成UUID
      phoneNumber: '+1234567890',
      name: '张三',
      lastUpdated: DateTime.now(),
    );
    final contactId = await _databaseService.localContactDataSource.insert(contactModel);
    print('添加联系人成功，ID: $contactId');
    
    // 获取所有联系人
    final contacts = await _databaseService.localContactDataSource.getAll();
    print('联系人数量: ${contacts.length}');
    
    // 添加标签
    const labelModel = LabelModel(
      id: '',  // 空ID将自动生成UUID
      phoneNumber: '+1234567890',
      label: '骚扰电话',
      priority: 1,
      action: 'block',
    );
    final labelId = await _databaseService.localLabelDataSource.insert(labelModel);
    print('添加标签成功，ID: $labelId');
    
    // 获取所有标签
    final labels = await _databaseService.localLabelDataSource.getAll();
    print('标签数量: ${labels.length}');
    
    // 根据电话号码获取标签
    final phoneLabels = await _databaseService.localLabelDataSource.getByPhoneNumber('+1234567890');
    print('电话号码 +1234567890 的标签数量: ${phoneLabels.length}');
  }
  
  // 远程数据库操作示例
  Future<void> remoteDatabaseExample() async {
    // 查询远程号码信息
    final remoteNumberInfo = await _syncManager.getRemoteNumberInfo('+1234567890');
    if (remoteNumberInfo != null) {
      print('远程号码信息:');
      print('  名称: ${remoteNumberInfo['name']}');
      print('  标签: ${remoteNumberInfo['label']}');
      print('  优先级: ${remoteNumberInfo['priority']}');
      print('  动作: ${remoteNumberInfo['action']}');
    } else {
      print('未找到远程号码信息');
    }
    
    // 执行同步
    final success = await _syncManager.sync();
    if (success) {
      print('同步成功，最后同步时间: ${_syncManager.lastSyncTime}');
    } else {
      print('同步失败');
    }
    
    // 根据标签查询远程号码
    final fraudNumbers = await _syncManager.getRemoteNumbersByLabel('诈骗');
    print('诈骗标签的远程号码数量: ${fraudNumbers.length}');
    
    // 根据优先级查询远程号码
    final highPriorityNumbers = await _syncManager.getRemoteNumbersByPriority(3);
    print('高优先级(3)的远程号码数量: ${highPriorityNumbers.length}');
    
    // 根据动作查询远程号码
    final blockNumbers = await _syncManager.getRemoteNumbersByAction('block');
    print('拦截动作的远程号码数量: ${blockNumbers.length}');
  }
  
  // 数据隔离示例
  Future<void> dataIsolationExample() async {
    // 本地数据可以导出
    final contactsData = await _databaseService.localContactDataSource.exportData();
    print('导出联系人数据长度: ${contactsData.length}');
    
    final labelsData = await _databaseService.localLabelDataSource.exportData();
    print('导出标签数据长度: ${labelsData.length}');
    
    // 远程数据不能导出，只能查询
    final remoteNumberInfo = await _syncManager.getRemoteNumberInfo('+1234567890');
    if (remoteNumberInfo != null) {
      print('可以查询远程号码信息，但不能导出远程数据库');
    }
    
    // 远程数据只能通过同步管理器访问，确保隔离性
    print('远程数据库与本地数据库完全隔离，互不影响');
    
    // 1. 尝试导出远程数据（将失败）
    try {
      print('\n尝试导出远程数据...');
      await _syncManagerImpl.exportRemoteData();
    } catch (e) {
      print('导出远程数据失败：${e.toString()}');
    }
    
    // 2. 使用远程数据访问限制
    print('\n使用远程数据访问限制查询号码信息...');
    final phoneNumber = '+1234567890';
    final restrictedRemoteInfo = await _remoteDataAccessRestriction.queryRemoteNumberInfo(phoneNumber);
    
    if (restrictedRemoteInfo != null) {
      print('找到远程号码信息：');
      print('  名称: ${restrictedRemoteInfo['name'] ?? "未知"}');
      print('  标签: ${restrictedRemoteInfo['label']}');
      print('  优先级: ${restrictedRemoteInfo['priority']}');
      print('  动作: ${restrictedRemoteInfo['action']}');
    } else {
      print('未找到远程号码信息');
    }
    
    // 3. 尝试修改远程数据（将失败）
    try {
      print('\n尝试修改远程数据...');
      await _remoteDataAccessRestriction.modifyData();
    } catch (e) {
      print('修改远程数据失败：${e.toString()}');
    }
    
    // 4. 尝试删除远程数据（将失败）
    try {
      print('\n尝试删除远程数据...');
      await _remoteDataAccessRestriction.deleteData();
    } catch (e) {
      print('删除远程数据失败：${e.toString()}');
    }
  }
  
  // 增量同步示例
  Future<void> incrementalSyncExample() async {
    print('\n=== 增量同步示例 ===');
    
    // 1. 检查是否需要同步
    if (_syncManagerImpl.needSync) {
      print('需要执行同步操作');
      
      // 2. 执行增量同步
      final success = await _syncManagerImpl.syncIncremental();
      
      if (success) {
        print('增量同步成功');
        print('最后同步时间: ${_syncManagerImpl.lastSyncTime}');
      } else {
        print('增量同步失败');
      }
    } else {
      print('不需要执行同步操作');
      print('最后同步时间: ${_syncManagerImpl.lastSyncTime}');
      print('同步间隔: ${_syncManagerImpl.syncInterval}小时');
    }
    
    // 3. 获取同步记录
    print('\n获取同步记录:');
    final syncRecords = await _syncManagerImpl.getSyncRecords(limit: 5);
    
    if (syncRecords.isNotEmpty) {
      print('最近5条同步记录：');
      for (final record in syncRecords) {
        print('  ID: ${record.id}');
        print('  同步时间: ${record.syncTime}');
        print('  同步类型: ${record.syncType}');
        print('  同步状态: ${record.status}');
        if (record.error != null) {
          print('  错误信息: ${record.error}');
        }
        print('  ---');
      }
    } else {
      print('没有同步记录');
    }
  }
  
  // 运行所有示例
  Future<void> runAllExamples() async {
    await initialize();
    
    print('\n=== 本地数据库操作示例 ===');
    await localDatabaseExample();
    
    print('\n=== 远程数据库操作示例 ===');
    await remoteDatabaseExample();
    
    print('\n=== 数据隔离示例 ===');
    await dataIsolationExample();
    
    print('\n=== 增量同步示例 ===');
    await incrementalSyncExample();
  }
}

// 主函数示例
Future<void> main() async {
  final example = DatabaseUsageExample();
  await example.runAllExamples();
}